# Hello World示例（RT-Thread）

## 支持的平台
<!-- 支持哪些板子和芯片平台 -->
- 任意板子（包括`pc`）

## 概述
Hello_world应用会在板子的串口打印hello world!


### 编译和烧录
切换到例程project目录，运行scons命令执行编译：
```
scons --board=sf32lb52-lcd_n16r8 -j32
```

simulator: 
```
scons --board=pc -j32
```



