//
// Created by E_LJF on 2026/8/12.
//

#include "EC11.h"

#include <string.h>
#include "stdio.h"

static uint8_t ec11_obj_num = 0;
static EC11_T *ec11_obj_list[EC11_MAX_OBJ_NUM];
static bool ec11_isr_service_installed = false;

/* A引脚双边沿中断回调 */
static void IRAM_ATTR ec11_irq_callback(void *args)
{
    EC11_T *obj = (EC11_T *)args;
    if (obj == NULL) return;

    /* A 下降沿：开始一次采样 */
    if (gpio_get_level(obj->a_pin) == 0 && obj->exti_flag == 0)
    {
        obj->exti_flag = 1;
        obj->b_level   = gpio_get_level(obj->b_pin);
    }

    /* A 上升沿：结束采样并判断方向 */
    if (gpio_get_level(obj->a_pin) == 1 && obj->exti_flag == 1)
    {
        obj->exti_flag = 0;
        uint8_t b_now = gpio_get_level(obj->b_pin);

        if (obj->b_level == 1 && b_now == 0)
        {
            switch (obj->dir)
            {
                case EC11_DIR_CLOCKWISE:
                    obj->counter++;
                    obj->coder_state = EC11_UP;
                    break;
                case EC11_DIR_ANTICLOCKWISE:
                    obj->counter--;
                    obj->coder_state = EC11_DOWN;
                    break;
                default:
                    break;
            }
        }
        else if (obj->b_level == 0 && b_now == 1)
        {
            switch (obj->dir)
            {
                case EC11_DIR_CLOCKWISE:
                    obj->counter--;
                    obj->coder_state = EC11_DOWN;
                    break;
                case EC11_DIR_ANTICLOCKWISE:
                    obj->counter++;
                    obj->coder_state = EC11_UP;
                    break;
                default:
                    break;
            }
        }
    }
}

/* EC11 对象初始化 */
ec11_state_t ec11_init(EC11_T *ec11_obj,
                       gpio_num_t ec11_a_pin,
                       gpio_num_t ec11_b_pin,
                       gpio_num_t ec11_key_pin,
                       uint8_t ec11_dir)
{
    if (ec11_obj == NULL) return EC11_OBJ_ERROR;
    if (ec11_obj_num >= EC11_MAX_OBJ_NUM) return EC11_OBJ_ERROR;

    memset(ec11_obj, 0, sizeof(EC11_T));

    ec11_obj->a_pin   = ec11_a_pin;
    ec11_obj->b_pin   = ec11_b_pin;
    ec11_obj->key_pin = ec11_key_pin;
    ec11_obj->dir     = ec11_dir;

    ec11_obj->coder_state = EC11_DE;
    ec11_obj->key_state   = EC11_KEY_NULL;
    ec11_obj->state       = EC11_STATE_NULL;

#if EC11_GPIO_INIT_EN
    /* 配置为上拉输入 */
    gpio_config_t io_conf = {
        .pin_bit_mask = (1ULL << ec11_a_pin)
                      | (1ULL << ec11_b_pin)
                      | (1ULL << ec11_key_pin),
        .mode = GPIO_MODE_INPUT,
        .pull_up_en = GPIO_PULLUP_ENABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type = GPIO_INTR_DISABLE,
    };
    gpio_config(&io_conf);

    /* A引脚配置为双边沿中断 */
    gpio_set_intr_type(ec11_a_pin, GPIO_INTR_ANYEDGE);
    gpio_intr_enable(ec11_a_pin);
#endif

    /* 安装 GPIO ISR 服务（全局仅需一次） */
    if (!ec11_isr_service_installed)
    {
        esp_err_t ret = gpio_install_isr_service(ESP_INTR_FLAG_EDGE);
        if (ret == ESP_OK || ret == ESP_ERR_INVALID_STATE)
        {
            ec11_isr_service_installed = true;
        }
        else
        {
            return EC11_OBJ_ERROR;
        }
    }

    /* 注册 A 引脚中断回调 */
    gpio_isr_handler_add(ec11_a_pin, ec11_irq_callback, (void *)ec11_obj);

    ec11_obj_list[ec11_obj_num++] = ec11_obj;
    return EC11_INIT_OK;
}

/* 获取 EC11 状态（旋转 + 按键组合） */
ec11_state_t ec11_get_state(EC11_T *ec11_obj)
{
    if (ec11_obj == NULL) return EC11_OBJ_ERROR;

    ec11_state_t buff = ec11_obj->coder_state;
    ec11_obj->coder_state = EC11_DE;

    switch (ec11_obj->key_state)
    {
        case EC11_KEY_SHORT_PRESS:
            switch (buff)
            {
                case EC11_UP:   ec11_obj->state = EC11_KEY_SHORT_PRESS_AND_UP;   break;
                case EC11_DOWN: ec11_obj->state = EC11_KEY_SHORT_PRESS_AND_DOWN; break;
                default:        ec11_obj->state = EC11_KEY_SHORT_PRESS;          break;
            }
            break;

        case EC11_KEY_LONG_PRESS:
            switch (buff)
            {
                case EC11_UP:   ec11_obj->state = EC11_KEY_LONG_PRESS_AND_UP;   break;
                case EC11_DOWN: ec11_obj->state = EC11_KEY_LONG_PRESS_AND_DOWN; break;
                default:        ec11_obj->state = EC11_KEY_LONG_PRESS;          break;
            }
            break;

        default:
            switch (buff)
            {
                case EC11_UP:   ec11_obj->state = EC11_UP;   break;
                case EC11_DOWN: ec11_obj->state = EC11_DOWN; break;
                default:        ec11_obj->state = EC11_STATE_NULL; break;
            }
            break;
    }

    return ec11_obj->state;
}

/* EC11 按键扫描，建议在 10ms 周期任务中调用 */
void ec11_key_scan(EC11_T *ec11_obj)
{
    if (ec11_obj == NULL) return;

    TickType_t now_time = xTaskGetTickCount();

    /* 低电平有效（按下） */
    if (gpio_get_level(ec11_obj->key_pin) == 0)
    {
        switch (ec11_obj->key_state)
        {
            case EC11_KEY_NULL:
                ec11_obj->key_state = EC11_KEY_PRESS;
                ec11_obj->last_time = now_time;
                break;

            case EC11_KEY_PRESS:
                if ((now_time - ec11_obj->last_time) >= EC11_KEY_LONG_PRESS_TICKS)
                {
                    ec11_obj->key_state = EC11_KEY_LONG_PRESS;
                }
                break;

            default:
                break;
        }
    }
    else
    {
        switch (ec11_obj->key_state)
        {
            case EC11_KEY_PRESS:
                if ((now_time - ec11_obj->last_time >= pdMS_TO_TICKS(10)) &&
                    (now_time - ec11_obj->last_time < EC11_KEY_LONG_PRESS_TICKS))
                {
                    ec11_obj->key_state = EC11_KEY_SHORT_PRESS;
                }
                else if (now_time - ec11_obj->last_time >= EC11_KEY_LONG_PRESS_TICKS)
                {
                    ec11_obj->key_state = EC11_KEY_LONG_PRESS;
                }
                break;

            default:
                ec11_obj->key_state = EC11_KEY_NULL;
                ec11_obj->last_time = now_time;
                break;
        }
    }
}