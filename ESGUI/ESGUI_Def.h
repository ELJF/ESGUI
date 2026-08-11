//
// Created by E_LJF on 2026/8/12.
//

#ifndef ESGUI_ESGUI_DEF_H
#define ESGUI_ESGUI_DEF_H

/* 检测编译器 */
#if defined(__GNUC__) || defined(__clang__)
    #define __WEAK __attribute__((weak))

#elif defined(__CC_ARM) || defined(__ARMCC_VERSION)
    /* ARM Compiler 5/6 (Keil) */
    #define __WEAK __weak

#elif defined(__ICCARM__) || defined(__ICCRX__) || defined(__ICCXX__)
    /* IAR */
    #define __WEAK __weak

#elif defined(_MSC_VER)
    /* MSVC: 数据用 selectany，函数无原生弱符号，需其他手段 */
    #define __WEAK_FUNC  /* 空，MSVC 不支持函数弱定义 */
    #define __WEAK_VAR   __declspec(selectany)

#else
    #warning "Weak symbol not supported on this compiler"
    #define __WEAK
#endif

/* 统一宏：优先用 GCC 方式，其他编译器回退 */
#ifndef __WEAK
    #ifdef __WEAK_FUNC
        #define __WEAK __WEAK_FUNC
    #else
        #define __WEAK
    #endif
#endif


#define ESGUI_NULL (void *)0

typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned long uint32_t;
typedef signed char int8_t;
typedef signed short int16_t;
typedef signed long int32_t;

#endif //P4_ESGUI_ESGUI_DEF_H
