# ESGUI — 嵌入式简易 GUI 菜单框架

## 📋 更新日志

### v1.0.0
- 首次提交

### v1.1.0 (2026-07-07)
- 新增：五种默认弹窗的标题滚动版本
### V1.2.1 (2026-7-14)
- 修复了无动画运行还一直刷屏的BUG
- STM32的示例工程新增对SH1107 OLED驱动芯片的支持

### V1.2.2 (2026-7-20)
- 示例工程新增思澈芯片例程
- 例程使用思澈官方SF32lb52-nano-n16-r16开发板
- 该例程可作为在RT-Thread中使用ESGUI的参考

### V1.3.1 (2026-8-12)
- 修复了一些BUG，新增ESGUI_Def.h文件，统一类型定义，方便移植
- 将一些不太严谨的语句改严谨了

### V1.3.2 (2026-8-13)
- 修复了ESGUI类型冲突的BUG
- 新增ESP-IDF V6.02框架下的ESP32P4芯片例程
- 该例程可作为在FreeRTOS中使用ESGUI的参考

### V1.4.0 (2026-8-14)
- ESGUI自带的Canvas绘图库字体查找方式更改为二分查找
- ESGUI字体生成器适配二分查找
- 更新示例工程的ESGUI版本

### V1.4.1 (2026-8-14)
- 刚刚忘记更新字体生成器了，现在补上


# ↓↓ESGUI介绍↓↓
ESGUI（Embedded Simple GUI）是一个面向单色 OLED（如 SSD1315/SSD1306）的轻量级菜单框架。
采用 **纯 C 编写**、**零浮点运算**、**零动态内存分配**，专为资源受限的 MCU 设计。
>介绍视频:https://www.bilibili.com/video/BV1xFTw6iEbj?vd_source=605419deeeaedb82f5f8918bda063219

> 典型应用场景：128×64 单色屏、STM32/GD32 等 Cortex-M 内核、无外部显存或显存极小的嵌入式设备。

---

## ✨ 核心特性

| 特性 | 说明 |
|------|------|
| **零浮点** | 所有动画与进度使用千分比（0~1000），无 `float`/`double`，无 FPU 也能流畅运行 |
| **零动态内存** | 页面数据、弹窗数据、动画节点全部使用静态内存池，无 `malloc`/`free` |
| **页式显存映射** | 显存 Buffer 与 SSD1315 GDDRAM 1:1 页式映射，送屏无需转置 |
| **分块刷新** | 支持按条带（Strip）分块刷新，几 KB RAM 即可驱动大屏 |
| **动画系统** | 内置线性/缓入/缓出/回弹/冲过/弹跳等曲线，支持热更新目标值与 must_complete 阻塞 |
| **页面栈管理** | 最大 **8 级**菜单深度（可宏定义调整），支持 Push/Pop 过渡动画，动画期间自动屏蔽按键防误触 |
| **虚函数表架构** | 每个页面/弹窗自带 `esgui_page_vtable_t`，所有显示效果与输入处理均可被用户完全覆盖 |
| **模块化裁剪** | 通过宏开关编译时剔除不需要的页面类型、弹窗、动画曲线，极致压缩 Flash |
| **UTF-8 文本** | 支持中英文混排，自动换行，超长文本自动滚动 |

---

## 🏗️ 架构设计

ESGUI 采用**"核心框架 + 默认虚函数表"**的两层架构：

```
┌─────────────────────────────────────┐
│  用户自定义页面（可选）                │  ← 继承 vtable，完全重写或局部覆盖
│  ESGUI_PageDefaltVtbl.c / .h        │  ← 默认虚函数表：文本菜单、BMP菜单、5种弹窗
│  ESGUI_DefaultVtbConfig.h           │  ← 默认效果的编译时配置（尺寸/开关/动画参数）
├─────────────────────────────────────┤
│  ESGUI.c / ESGUI.h                  │  ← 框架核心：生命周期、事件路由、Tick 驱动
│  ESGUI_Menu.c / .h                  │  ← 菜单控制器：页面栈、弹窗、动作分发
│  ESGUI_Anim.c / .h                  │  ← 动画引擎：静态池、千分比插值、缓动曲线
│  ESGUI_Event.c / .h                 │  ← 事件定义（按键/编码器/触摸）
│  ESGUI_Widget.c / .h                │  ← 基础控件：进度条、焦点框、复选框等
│  ESGUI_UseCanvas.c / .h             │  ← Canvas 适配层：绑定分块刷新到框架
│  BSP/                               │  ← 底层绘图库：画布、图元、文本、位图
└─────────────────────────────────────┘
```

### 虚函数表（vtable）机制

每个页面/弹窗都是一个 `ESGUI_MenuPage_T` 或 `ESGUI_PopWindow_T`，内含一个 `const esgui_page_vtable_t *vtbl`：

```c
typedef struct {
    void (*on_create)(ESGUI_MenuPage_T *page);          // 分配资源，初始化页面
    void (*on_destroy)(ESGUI_MenuPage_T *page);         // 释放资源
    void (*on_draw)(ESGUI_MenuPage_T *page);            // 绘制背景 + 所有项
    uint16_t (*special_item_draw)(...);                   // 特殊条目标记绘制
    uint16_t (*get_special_item_draw_w)(...);            // 特殊条目宽度计算
    ESGUI_MenuAction_T (*on_input)(...);                // 按键/编码器输入处理
    void (*on_focus_change)(...);                       // 焦点变化通知（启动动画）
    void (*on_page_chenge)(...);                        // 页面切换回调（Push/Pop 动画）
} esgui_page_vtable_t;
```

**这意味着：**
- 你可以只替换 `on_draw` 实现一套完全不同的视觉风格（比如从列表改为网格）。
- 可以只替换 `on_input` 实现自定义的按键逻辑（比如旋转编码器带加速度）。
- 可以继承默认实现，只覆盖其中一两个函数，复用其余代码。
- **ESGUI_PageDefaltVtbl.c** 只是框架附带的一套"默认皮肤"，不是框架本身。你可以完全删掉它，用自己的 vtable 实现替代。

---

## 📁 项目结构

```
ESGUI_Git/
├── ESGUI/                          # 框架核心源码
│   ├── ESGUI.c / ESGUI.h           # 框架入口：Init / FeedKey / Tick
│   ├── ESGUI_Menu.c / .h           # 菜单控制器：页面栈、弹窗、动作分发
│   ├── ESGUI_Event.c / .h          # 事件定义（按键/编码器/触摸）
│   ├── ESGUI_Anim.c / .h           # 动画引擎：缓动曲线、静态池、千分比插值
│   ├── ESGUI_PageDefaltVtbl.c / .h # 【默认虚函数表】文本菜单、BMP菜单、5种弹窗的默认实现
│   ├── ESGUI_DefaultVtbConfig.h    # 【默认效果配置】尺寸、开关、动画参数、菜单深度
│   ├── ESGUI_Widget.c / .h         # 控件：进度条、焦点框、复选框、单选框
│   ├── ESGUI_UseCanvas.c / .h      # Canvas 适配层：绑定分块刷新到 ESGUI
│   ├── BSP/
│   │   ├── ESGUI_BSP_Canvas.c / .h   # 画布与分块刷新引擎
│   │   ├── ESGUI_BSP_draw.c / .h     # 基础图元：点、线、矩形、圆、圆角矩形、三角形
│   │   ├── ESGUI_BSP_Text.c / .h     # UTF-8 文本渲染与页式字模
│   │   └── ESGUI_BSP_BMP.c / .h      # 1bpp 页式位图绘制
│   └── Font/
│       ├── eui_test_font.c / .h    # 示例字体（12px，英文+部分中文）
│       └── ...                     # 用户生成的自定义字体
├── ESGUI字体生成器.exe             # 字模/位图转换工具（PCtoLCD → 页式格式）
└── example/                        # 示例工程（STM32 HAL / 标准库 等）
```

---

## ⚙️ 编译配置（ESGUI_DefaultVtbConfig.h）

`ESGUI_DefaultVtbConfig.h` 控制**默认虚函数表**的编译内容，不影响框架核心。

| 宏 | 默认值 | 说明 |
|---|-----|---|
| `ESGUI_MAX_MENU_DEPTH` | 8   | 菜单栈最大深度（可在 `ESGUI_Menu.h` 独立调整） |
| `ESGUI_ENABLE_TEXT_MENU` | 0   | 默认文本菜单页面 |
| `ESGUI_ENABLE_BMP_MENU` | 0   | 默认图形（BMP）菜单页面 |
| `ESGUI_ENABLE_POPUP_MESSAGE` | 0   | 消息弹窗 |
| `ESGUI_ENABLE_POPUP_BOOL` | 0   | 布尔弹窗（OK/Cancel） |
| `ESGUI_ENABLE_POPUP_VALUE` | 0   | 数值调节弹窗 |
| `ESGUI_ENABLE_POPUP_TEXTLIST` | 0   | 文本列表弹窗 |
| `ESGUI_ENABLE_POPUP_BMPLIST` | 0   | 图片列表弹窗 |
| `ESGUI_PAGE_TRANSITION_TYPE` | 0   | 0=百叶窗淡入淡出，1=缩放过渡 |
| `ESGUI_PAGE_TRANSITION_ANIM_TIME` | 250 | 页面过渡动画时长（ms） |
| `ESGUI_ITEM_SPACING` | 3   | 文本条目间距（像素） |
| `ESGUI_ANIM_ENABLE_OVERSHOOT` | 0   | 冲过缓动曲线 |
| `ESGUI_ANIM_ENABLE_BOUNCE` | 0   | 弹跳缓动曲线 |

> 在编译命令中加 `-DESGUI_ENABLE_TEXT_MENU=0` 即可完全剔除文本菜单代码，显著减小 Flash。

---

## 🚀 快速开始

### 1. 准备显存与画布

```c
#include "ESGUI.h"
#include "ESGUI_UseCanvas.h"

#define SCREEN_W   128
#define SCREEN_H   64
#define STRIP_H    16                 // 条带高度（8 的倍数，越大 RAM 占用越高）

uint8_t canvas_buf[SCREEN_W * STRIP_H / 8];  // 条带显存
Canvas canvas;
CanvasStripIter canvas_iter;
ESGUI_T ui;
```

### 2. 定义菜单页面（使用默认效果）

```c
/* 回调：按 OK 进入下一页 */
ESGUI_MenuAction_T on_enter_sub(void *page, void *arg) {
    extern ESGUI_MenuPage_T sub_page;
    return (ESGUI_MenuAction_T){ACT_PUSH_PAGE, &sub_page};
}

/* 回调：按 BACK 返回 */
ESGUI_MenuAction_T on_pop(void *page, void *arg) {
    return (ESGUI_MenuAction_T){ACT_POP_PAGE, NULL};
}

ESGUI_MenuItem_T main_items[] = {
    {"Setting",  NULL, on_enter_sub, NULL},
    {"Info",     NULL, on_enter_sub, NULL},
    {"Exit",     NULL, on_pop,       NULL},
};
ESGUI_MenuPage_T main_page;
```

### 3. 初始化并运行

```c
void ui_init(void) {
    /* 绑定画布（分块刷新） */
    ESGUI_BindCanvas(&ui, &canvas, &canvas_iter,
                     canvas_buf, SCREEN_W, SCREEN_H, STRIP_H);

    /* 创建默认文本菜单页面（使用默认 vtable） */
    ESGUI_DefaltTextMenuCreate(&main_page, main_items, "Main Menu", 3);

    /* 初始化 UI，传入首页面 */
    ESGUI_Init(&ui, &main_page, ESGUI_CanvasRefresh_CB, ESGUI_AnimTick_CB);
}

/* 主循环（1ms ~ 10ms 周期） */
void ui_loop(uint32_t tick_ms, ESGUI_EventCode_t key) {
    ESGUI_FeedKey(&ui, key, tick_ms);   // 输入事件
    ESGUI_Tick(&ui, tick_ms);           // 动画 + 绘制
}
```

### 4. 你需要实现的硬件接口

唯一需要用户实现的弱函数（`__WEAK`）：

```c
/* 送屏回调：将当前条带数据写入 OLED */
void ESGUI_UseCanvasFlush(int x0, int y0, int x1, int y1,
                         const uint8_t *buff, void *user) {
    // 例如：SSD1315_I2C_Write(x0, y0, x1, y1, buff);
}
```

---

## 🎨 自定义页面效果（进阶）

如果你不满意默认效果，**不需要修改框架核心**，只需提供自己的 vtable：

```c
/* 自定义绘制：比如把文本菜单改成横向标签页 */
void my_custom_draw(ESGUI_MenuPage_T *page) {
    // 完全自定义的绘制逻辑，可调用 BSP 层的 eui_draw_xxx
}

/* 自定义输入：比如把上下键改成左右键控制 */
ESGUI_MenuAction_T my_custom_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e) {
    // ...
}

static const esgui_page_vtable_t my_vtable = {
    .on_create       = esgui_text_menu_defalt_on_create,  // 复用默认创建逻辑
    .on_destroy      = esgui_text_menu_defalt_on_destroy,
    .on_draw         = my_custom_draw,                      // 替换为自己的绘制
    .on_input        = my_custom_input,                     // 替换为自己的输入
    .on_focus_change = esgui_text_menu_defalt_on_focus_change,
    .on_page_chenge  = esgui_text_menu_default_on_page_change,
};

/* 创建页面时绑定自定义 vtable */
void MyTextMenuCreate(ESGUI_MenuPage_T *page, ...) {
    memset(page, 0, sizeof(*page));
    page->vtbl = &my_vtable;
    // ...
}
```

**动画系统同样可被自定义：**
- 默认效果使用 `ESGUI_Anim.c` 中的 `anim_start()` 驱动焦点框、进度条、页面过渡。
- 你可以在自定义 vtable 中调用 `anim_start()`，也可以完全不用动画系统，直接同步修改属性。

---

## 🎬 动画系统

ESGUI 内置轻量级动画引擎，所有视觉变化（焦点框移动、进度条增长、页面滑入、弹窗弹出）均由动画驱动。

```c
anim_t a = {0};
anim_set_var(&a, &my_var)
    .set_exec_cb(&a, my_callback)
    .set_values(&a, 0, 100)       // 起始值 → 目标值
    .set_time(&a, 300)            // 300ms
    .set_path(&a, ANIM_PATH_EASE_OUT);
anim_start(&a);                   // 启动（若同变量已有动画，自动热更新终点）
```

- **must_complete**：页面退出动画可标记为必须完成，框架会阻塞真正的 `Pop/Destroy` 直到动画结束，防止画面撕裂。
- **热更新**：编码器快速转动时，同一变量不会启动多个动画，而是直接修改终点并延续。

---

## 📝 特殊条目标记

文本菜单支持在条目字符串尾部附加标记符，自动渲染控件：

```c
/* 标记格式：文本 + '' + '/' + 类型码 */
{"WiFi/0",  NULL, on_toggle, &wifi_en},   // 方形复选框
{"Mode/1",  NULL, on_toggle, &mode_sel},  // 圆形单选框
{"Vol /2",  NULL, NULL,     &volume},     // 数值显示（arg 指向 int16）
```

---

## 🔧 字体与位图生成

### 字体要求
ESGUI 使用 **页式 1bpp 字模**（与 SSD1315 GDDRAM 同布局），工具链如下：

1. 用 **PCtoLCD2002** / **Image2LCD** 生成常规水平字模（高位在前、从左到右、从上到下）。
2. 使用本仓库提供的 **`ESGUI字体生成器.exe`** 将水平字模转换为 **页式格式**。
3. 将生成的 `.c` 文件放入 `ESGUI/Font/`，并在代码中替换 `ESGUI_DEFAULT_FONT` 宏。

### 位图要求
BMP 菜单使用的图片同样需为 **页式 1bpp**，可用上述工具生成。

---

## 📦 示例工程

`example/` 目录包含一个完整的可编译工程模板，使用框架默认虚函数表（基于Clion + STM32CubeMX + STM32CubeCLT），演示：

- 文本菜单与 BMP 菜单切换
- 五种弹窗
- 长文本滚动与页面过渡动画
- 分块刷新绑定 SSD1315
---

## 🖼️ 演示与介绍视频

> https://
---

## 📄 许可证

本项目采用 **MIT License**，可自由用于商业或非商业项目。
详见仓库根目录 `LICENSE` 文件。

---

## 🤝 贡献与反馈

欢迎提交 Issue 或 PR。如果你制作了新的页面类型、缓动曲线或硬件适配层，欢迎分享！