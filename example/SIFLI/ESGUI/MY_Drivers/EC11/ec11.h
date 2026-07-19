#ifndef __EC11_H
#define __EC11_H

#include <rtthread.h>
#include <rtdevice.h>

#define EC11_MAX_OBJ_NUM        5
#define EC11_KEY_LONG_PRESS_TIM 600     /* 长按判断时间(ms) */

#define EC11_DIR_CLOCKWISE      0
#define EC11_DIR_ANTICLOCKWISE  1

typedef enum
{
    EC11_OBJ_ERROR = 0,
    EC11_INIT_OK,

    EC11_UP,                /* 顺时针 / 数值增加 */
    EC11_DOWN,              /* 逆时针 / 数值减小 */
    EC11_DE,                /* 无动作 / 等待 */

    EC11_KEY_LONG_PRESS,
    EC11_KEY_PRESS,
    EC11_KEY_SHORT_PRESS,
    EC11_KEY_NULL,

    EC11_STATE_NULL,

    EC11_KEY_SHORT_PRESS_AND_UP,
    EC11_KEY_SHORT_PRESS_AND_DOWN,
    EC11_KEY_LONG_PRESS_AND_UP,
    EC11_KEY_LONG_PRESS_AND_DOWN,
} EC11_STATE_ENUM_T;

typedef struct EC11_OBJ
{
    rt_base_t ec11_a_pin;           /* EC11 A 引脚 (pin id) */
    rt_base_t ec11_b_pin;           /* EC11 B 引脚 (pin id) */
    rt_base_t ec11_key_pin;         /* EC11 KEY 引脚 (pin id) */

    uint8_t   ec11_dir;             /* 旋转方向定义 */

    uint32_t  ec11_counter;         /* 编码器计数值 */

    EC11_STATE_ENUM_T ec11_state;       /* 组合状态 */
    EC11_STATE_ENUM_T ec11_coder_state; /* 旋转状态 */
    EC11_STATE_ENUM_T ec11_key_state;   /* 按键状态 */

    /* 以下字段由驱动内部维护，用户无需初始化 */
    rt_tick_t last_time;            /* 按键扫描时间戳 */
    uint8_t   exti_flag;            /* A引脚中断状态机 */
    uint8_t   b_level;              /* B引脚电平记录 */
} EC11_OBJ_T;

EC11_STATE_ENUM_T EC11_Init(EC11_OBJ_T *ec11_obj,
                            rt_base_t ec11_a_pin,
                            rt_base_t ec11_b_pin,
                            rt_base_t ec11_key_pin,
                            uint8_t ec11_dir);

EC11_STATE_ENUM_T EC11_GetState(EC11_OBJ_T *ec11_obj);
void EC11_KeyScan(EC11_OBJ_T *ec11_obj);

#endif