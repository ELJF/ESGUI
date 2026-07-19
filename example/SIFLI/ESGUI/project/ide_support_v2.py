#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
ide_support.py
为 SiFli SDK 的 SCons 项目提供 VSCode 和 CLion 的 IDE 支持

基于社区原始脚本改进，核心思路：
1. 优先使用 env.CompilationDatabase() 获取 SDK 原生生成的 compile_commands.json（最准确）
2. 自动注入编译器系统头文件路径（-isystem），解决 clangd 找不到 sys/stat.h 等问题
3. 所有路径强制绝对路径化，避免 CLion 解析错误
4. 如果 SDK 未生成 compile_commands.json，自动回退到手动生成模式

用法：
1. 将本文件放到项目根目录（与 SConstruct 同级）
2. 在 SConstruct 第一行添加：from ide_support import vscode_support, clion_support
3. 在 SConstruct 最后一行添加：clion_support(env)  # 或 vscode_support(env)
4. 执行 scons 编译，脚本会自动生成 IDE 配置文件
"""

import os
import json
import shlex
import subprocess
import re
from typing import List, Optional, Dict, Any


# =============================================================================
# 内部辅助函数
# =============================================================================

def _get_system_include_paths(compiler_path: str) -> List[str]:
    """
    获取编译器的系统头文件搜索路径。
    通过执行 `gcc -E -Wp,-v -xc /dev/null` 并解析 stderr 实现。
    """
    if not compiler_path or not os.path.exists(compiler_path):
        return []

    try:
        command = [compiler_path, "-E", "-Wp,-v", "-xc", os.devnull]
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=False,
            timeout=15
        )
        output = result.stderr

        # 匹配 "#include <...> search starts here:" 和 "End of search list." 之间的内容
        match = re.search(
            r'#include <\.\.\.> search starts here:\s*(.*?)\s*End of search list\.',
            output,
            re.DOTALL
        )
        if not match:
            return []

        paths = []
        for line in match.group(1).splitlines():
            line = line.strip()
            if line:
                norm_path = os.path.normpath(os.path.abspath(line))
                if os.path.exists(norm_path) and norm_path not in paths:
                    paths.append(norm_path)
        return paths
    except Exception as e:
        print(f"[ide_support] Warning: failed to get system includes: {e}")
        return []


def _find_compiler(env_vars: dict) -> Optional[str]:
    """在PATH中定位编译器绝对路径"""
    cc = env_vars.get("CC", "gcc")
    if isinstance(cc, list):
        cc = cc[0]

    # 如果已经是绝对路径且存在
    if os.path.isabs(cc) and os.path.exists(cc):
        return os.path.normpath(os.path.abspath(cc))

    path_env = env_vars.get("ENV", {}).get("PATH", os.environ.get("PATH", ""))
    separator = ';' if os.name == 'nt' else ':'

    for directory in path_env.split(separator):
        dir_path = directory.strip()
        if not dir_path:
            continue
        candidate = os.path.join(dir_path, cc)
        if os.path.exists(candidate):
            return os.path.normpath(os.path.abspath(candidate))
        if os.name == 'nt':
            for ext in ('.exe', '.com', '.bat', '.cmd'):
                if os.path.exists(candidate + ext):
                    return os.path.normpath(os.path.abspath(candidate + ext))
    return None


def _to_absolute_path(path: str, base_dir: str) -> str:
    """将路径转换为绝对路径"""
    if not path:
        return path
    if os.path.isabs(path):
        return os.path.normpath(path)
    return os.path.normpath(os.path.join(base_dir, path))


def _extract_defines_from_env(env_vars: dict) -> List[str]:
    """从环境变量提取所有宏定义（去掉 -D 前缀）"""
    defines = []
    cppdefines = env_vars.get("CPPDEFINES", [])

    if isinstance(cppdefines, dict):
        for k, v in cppdefines.items():
            defines.append(f"{k}={v}")
    elif isinstance(cppdefines, list):
        for d in cppdefines:
            if isinstance(d, (tuple, list)) and len(d) >= 2:
                defines.append(f"{d[0]}={d[1]}")
            elif isinstance(d, str):
                defines.append(d)
            else:
                defines.append(str(d))

    return defines


def _extract_includes_from_env(env_vars: dict, project_dir: str) -> List[str]:
    """从环境变量提取所有 include 路径（项目级）"""
    includes = []

    # 1. 从 CPPPATH 提取
    cpppath = env_vars.get("CPPPATH", [])
    if isinstance(cpppath, str):
        cpppath = [cpppath]
    for p in cpppath:
        abs_p = _to_absolute_path(str(p), project_dir)
        if abs_p and abs_p not in includes:
            includes.append(abs_p)

    # 2. 从 CFLAGS / CXXFLAGS / CCFLAGS 中的 -I 提取
    for flag_key in ['CFLAGS', 'CXXFLAGS', 'CCFLAGS']:
        flags = env_vars.get(flag_key, [])
        if isinstance(flags, str):
            flags = flags.split()

        i = 0
        while i < len(flags):
            flag = str(flags[i])
            if flag.startswith('-I'):
                if len(flag) > 2:
                    inc_path = flag[2:]
                else:
                    i += 1
                    if i < len(flags):
                        inc_path = str(flags[i])
                    else:
                        break
                abs_p = _to_absolute_path(inc_path, project_dir)
                if abs_p and abs_p not in includes:
                    includes.append(abs_p)
            i += 1

    return includes


def _extract_other_flags(env_vars: dict) -> List[str]:
    """提取除 -I 和 -D 之外的其他编译标志"""
    other_flags = []
    skip_prefixes = ('-I', '-D', '-include')

    for flag_key in ['CFLAGS', 'CXXFLAGS', 'CCFLAGS']:
        flags = env_vars.get(flag_key, [])
        if isinstance(flags, str):
            flags = flags.split()

        i = 0
        while i < len(flags):
            flag = str(flags[i])
            # 跳过 -I / -D / -include 及其参数
            if any(flag.startswith(p) for p in skip_prefixes):
                if flag in ('-I', '-D', '-include') or len(flag) == 2:
                    i += 1  # 跳过下一个参数（值）
            elif flag not in other_flags:
                other_flags.append(flag)
            i += 1

    return other_flags


def _collect_source_files(project_dir: str) -> List[str]:
    """扫描项目目录收集源文件"""
    sources = []
    extensions = {'.c', '.cpp', '.cxx', '.cc', '.s', '.S'}

    exclude_dirs = {
        '.git', '.svn', '.hg', 'build', 'out', 'dist',
        '.sconsign.dblite', '__pycache__', '.vscode', '.idea',
        'node_modules', '.venv', 'venv', '.pio'
    }

    for root, dirs, files in os.walk(project_dir):
        dirs[:] = [d for d in dirs if d not in exclude_dirs]
        for f in files:
            ext = os.path.splitext(f)[1].lower()
            if ext in extensions:
                sources.append(os.path.join(root, f))

    return sources


# =============================================================================
# 回退：手动生成 compile_commands.json（当 SDK 未生成时的备用方案）
# =============================================================================

def _clion_support_manual(env, project_dir: str) -> None:
    """手动生成 compile_commands.json（SDK 未生成时的回退）"""
    env_vars = json.loads(env.Dump(format="json"))
    compiler = _find_compiler(env_vars)

    print(f"[ide_support] Manual generation of compile_commands.json...")
    print(f"[ide_support] Compiler: {compiler}")

    includes = _extract_includes_from_env(env_vars, project_dir)
    defines = []
    cppdefines = env_vars.get("CPPDEFINES", {})
    if isinstance(cppdefines, dict):
        for k, v in cppdefines.items():
            defines.append(f"-D{k}={v}")
    elif isinstance(cppdefines, list):
        for d in cppdefines:
            if isinstance(d, (tuple, list)) and len(d) >= 2:
                defines.append(f"-D{d[0]}={d[1]}")
            elif isinstance(d, str):
                defines.append(f"-D{d}" if not d.startswith('-D') else d)
            else:
                defines.append(f"-D{d}")

    other_flags = _extract_other_flags(env_vars)
    sys_includes = _get_system_include_paths(compiler) if compiler else []

    base_command = [compiler] if compiler else []
    base_command.extend(other_flags)
    base_command.extend(defines)
    for inc in includes:
        base_command.append(f"-I{inc}")
    for inc in sys_includes:
        base_command.append(f"-isystem{inc}")

    sources = _collect_source_files(project_dir)

    compile_commands = []
    for src in sources:
        cmd = list(base_command)
        cmd.append(src)
        compile_commands.append({
            "directory": project_dir,
            "command": ' '.join(shlex.quote(a) for a in cmd),
            "file": src
        })

    output_path = os.path.join(project_dir, "compile_commands.json")
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(compile_commands, f, indent=4, ensure_ascii=False)

    print(f"[ide_support] Generated CLion config (manual mode): {output_path}")
    print(f"  Entries: {len(compile_commands)}")
    if sys_includes:
        print(f"  System includes injected: {len(sys_includes)}")
        for inc in sys_includes:
            print(f"    -isystem {inc}")


# =============================================================================
# 对外接口
# =============================================================================

def vscode_support(env) -> None:
    """
    生成 VSCode 所需的 .vscode/c_cpp_properties.json

    需要安装微软 C/C++ Extension Pack 插件。

    使用方法：
        1. 在 SConstruct 最后一行调用 vscode_support(env)
        2. 执行 scons 编译
        3. 用 VSCode 打开项目文件夹即可
    """
    env_vars = json.loads(env.Dump(format="json"))
    project_dir = os.path.abspath(os.getcwd())

    print(f"[ide_support] Generating c_cpp_properties.json for VSCode...")

    # 处理 includePath：转为绝对路径
    raw_includes = env_vars.get("CPPPATH", [])
    includes = []
    for p in raw_includes:
        abs_p = _to_absolute_path(str(p), project_dir)
        if abs_p and abs_p not in includes:
            includes.append(abs_p)

    # 获取系统 include
    compiler_path = _find_compiler(env_vars)
    sys_includes = _get_system_include_paths(compiler_path) if compiler_path else []
    for inc in sys_includes:
        if inc and inc not in includes:
            includes.append(inc)

    # 处理 defines
    defines = _extract_defines_from_env(env_vars)

    # 检测 intelliSenseMode
    compiler_name = os.path.basename(compiler_path or "").lower()
    if 'arm' in compiler_name:
        intelliSenseMode = "gcc-arm"
    elif 'gcc' in compiler_name:
        intelliSenseMode = "gcc-x64"
    else:
        intelliSenseMode = "gcc-arm"

    config = {
        "configurations": [{
            "name": "sf32",
            "includePath": includes,
            "compilerPath": compiler_path,
            "intelliSenseMode": intelliSenseMode,
            "defines": defines,
            "cStandard": "c11",
            "cppStandard": "c++17"
        }]
    }

    vscode_dir = os.path.join(project_dir, '.vscode')
    os.makedirs(vscode_dir, exist_ok=True)

    config_path = os.path.join(vscode_dir, 'c_cpp_properties.json')
    with open(config_path, 'w', encoding='utf-8') as config_file:
        json.dump(config, config_file, indent=4, ensure_ascii=False)

    print(f"[ide_support] Generated VS Code config: {config_path}")
    print(f"  Include paths: {len(includes)}")
    print(f"  Defines: {len(defines)}")


def clion_support(env) -> None:
    """
    生成 CLion 所需的 compile_commands.json（Compilation Database）

    核心改进：
    1. 优先使用 env.CompilationDatabase() 获取 SDK 原生生成的 compile_commands.json（最准确）
    2. 自动注入编译器系统头文件路径（-isystem），解决 clangd 找不到 sys/stat.h 等问题
    3. 所有路径强制绝对路径化，避免 CLion 解析错误
    4. 如果 SDK 未生成 compile_commands.json，自动回退到手动生成模式

    使用方法：
        1. 在 SConstruct 最后一行调用 clion_support(env)
        2. 执行 scons 编译
        3. 在 CLion 中选择 "Open" -> 选择生成的 compile_commands.json
        4. CLion 会提示 "Open as Project"，选择即可
        5. 代码补全、跳转、重构等功能即可正常使用

    编译/调试：
        由于 CLion 不直接支持 SCons，需要配置 Custom Build Target：
        Settings -> Build -> Custom Build Targets -> 添加
        Build:  Program=scons, Arguments=--board=你的板子, Working directory=$ProjectFileDir$
        Clean:  Program=scons, Arguments=-c, Working directory=$ProjectFileDir$
    """
    env_vars = json.loads(env.Dump(format="json"))
    project_dir = os.path.abspath(os.getcwd())
    build_dir = env_vars.get("BUILD_DIR_FULL_PATH", project_dir)

    print(f"[ide_support] Generating compile_commands.json for CLion...")
    print(f"[ide_support] Project dir: {project_dir}")

    # 尝试从 SDK 获取原生 compile_commands.json
    compile_db_path = None
    try:
        db_list = env.CompilationDatabase()
        if db_list:
            db_name = str(db_list[0])
            compile_db_path = os.path.join(build_dir, db_name)
            print(f"[ide_support] Found SDK compilation database: {compile_db_path}")
    except Exception as e:
        print(f"[ide_support] SDK compilation database not available: {e}")

    # 如果 SDK 没有生成，回退到手动模式
    if not compile_db_path or not os.path.exists(compile_db_path):
        print(f"[ide_support] Falling back to manual generation...")
        _clion_support_manual(env, project_dir)
        return

    # 验证编译器路径
    compiler_path = _find_compiler(env_vars)
    if not compiler_path:
        raise RuntimeError(f"Compiler '{env_vars.get('CC')}' not found in PATH")
    print(f"[ide_support] Compiler: {compiler_path}")

    # 获取系统 include 路径
    sys_includes = _get_system_include_paths(compiler_path)
    sys_include_flags = [f"-isystem{inc}" for inc in sys_includes]

    with open(compile_db_path, 'r', encoding='utf-8') as db_file:
        commands = json.load(db_file)

    processed = []
    for entry in commands:
        # 1. directory 绝对路径化
        base_dir = entry.get("directory", build_dir)
        if not os.path.isabs(base_dir):
            base_dir = os.path.normpath(os.path.join(project_dir, base_dir))
        else:
            base_dir = os.path.normpath(base_dir)
        entry["directory"] = base_dir

        # 2. file 绝对路径化
        source_path = entry.get("file", "")
        if source_path and not os.path.isabs(source_path):
            source_path = os.path.normpath(os.path.join(base_dir, source_path))
        entry["file"] = source_path

        # 3. 跳过不存在的源文件
        if source_path and not os.path.exists(source_path):
            continue

        # 4. 处理 command 字段（字符串形式）
        if "command" in entry:
            tokens = shlex.split(entry["command"])
            if tokens:
                # 第一个 token 是编译器，替换为绝对路径
                tokens[0] = compiler_path

            # 将 -I 相对路径转为绝对路径，并追加系统 include
            new_tokens = []
            i = 0
            while i < len(tokens):
                token = tokens[i]
                if token.startswith('-I') and len(token) > 2:
                    abs_path = _to_absolute_path(token[2:], base_dir)
                    new_tokens.append(f'-I{abs_path}')
                elif token == '-I' and i + 1 < len(tokens):
                    abs_path = _to_absolute_path(tokens[i + 1], base_dir)
                    new_tokens.append('-I')
                    new_tokens.append(abs_path)
                    i += 1
                elif token.startswith('-isystem') and len(token) > 8:
                    abs_path = _to_absolute_path(token[8:], base_dir)
                    new_tokens.append(f'-isystem{abs_path}')
                elif token == '-isystem' and i + 1 < len(tokens):
                    abs_path = _to_absolute_path(tokens[i + 1], base_dir)
                    new_tokens.append('-isystem')
                    new_tokens.append(abs_path)
                    i += 1
                else:
                    new_tokens.append(token)
                i += 1

            # 追加系统 include
            new_tokens.extend(sys_include_flags)
            entry["command"] = ' '.join(shlex.quote(t) for t in new_tokens)

        # 5. 处理 arguments 字段（数组形式）
        elif "arguments" in entry:
            args = entry["arguments"]
            if args:
                args[0] = compiler_path

            new_args = []
            i = 0
            while i < len(args):
                arg = args[i]
                if arg.startswith('-I') and len(arg) > 2:
                    abs_path = _to_absolute_path(arg[2:], base_dir)
                    new_args.append(f'-I{abs_path}')
                elif arg == '-I' and i + 1 < len(args):
                    abs_path = _to_absolute_path(args[i + 1], base_dir)
                    new_args.append('-I')
                    new_args.append(abs_path)
                    i += 1
                elif arg.startswith('-isystem') and len(arg) > 8:
                    abs_path = _to_absolute_path(arg[8:], base_dir)
                    new_args.append(f'-isystem{abs_path}')
                elif arg == '-isystem' and i + 1 < len(args):
                    abs_path = _to_absolute_path(args[i + 1], base_dir)
                    new_args.append('-isystem')
                    new_args.append(abs_path)
                    i += 1
                else:
                    new_args.append(arg)
                i += 1

            new_args.extend(sys_include_flags)
            entry["arguments"] = new_args

        processed.append(entry)

    output_path = os.path.join(project_dir, 'compile_commands.json')
    with open(output_path, 'w', encoding='utf-8') as output_file:
        json.dump(processed, output_file, indent=4, ensure_ascii=False)

    print(f"[ide_support] Generated CLion config: {output_path}")
    print(f"  Original entries: {len(commands)}, Valid entries: {len(processed)}")
    if sys_includes:
        print(f"  System includes injected: {len(sys_includes)}")
        for inc in sys_includes:
            print(f"    -isystem {inc}")
    print(f"[ide_support] Now open with CLion: File -> Open -> select {output_path}")