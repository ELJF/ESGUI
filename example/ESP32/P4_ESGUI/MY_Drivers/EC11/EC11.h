//
// Created by E_LJF on 2026/8/12.
//

#ifndef P4_ESGUI_EC11_H
#define P4_ESGUI_EC11_H

#include "driver/gpio.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#define EC11_MAX_OBJ_NUM        5
#define EC11_KEY_LONG_PRESS_MS  600     /* 长按判断时间(ms) */
#define EC11_KEY_LONG_PRESS_TICKS pdMS_TO_TICKS(EC11_KEY_LONG_PRESS_MS)

#define EC11_DIR_CLOCKWISE      0
#define EC11_DIR_ANTICLOCKWISE  1

#define EC11_GPIO_INIT_EN       1       /* 1: 驱动内部初始化GPIO，0: 用户自行配置 */

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
} ec11_state_t;

typedef struct
{
    gpio_num_t a_pin;           /* EC11 A 引脚 */
    gpio_num_t b_pin;           /* EC11 B 引脚 */
    gpio_num_t key_pin;         /* EC11 KEY 引脚 */

    uint8_t   dir;              /* 旋转方向定义 */

    uint32_t  counter;          /* 编码器计数值 */

    ec11_state_t state;         /* 组合状态 */
    ec11_state_t coder_state;   /* 旋转状态 */
    ec11_state_t key_state;     /* 按键状态 */

    /* 以下字段由驱动内部维护，用户无需初始化 */
    TickType_t last_time;       /* 按键扫描时间戳 */
    uint8_t    exti_flag;       /* A引脚中断状态机 */
    uint8_t    b_level;         /* B引脚电平记录 */
} EC11_T;

ec11_state_t ec11_init(EC11_T *ec11_obj,
                       gpio_num_t ec11_a_pin,
                       gpio_num_t ec11_b_pin,
                       gpio_num_t ec11_key_pin,
                       uint8_t ec11_dir);

ec11_state_t ec11_get_state(EC11_T *ec11_obj);
void ec11_key_scan(EC11_T *ec11_obj);

#endif //P4_ESGUI_EC11_H
