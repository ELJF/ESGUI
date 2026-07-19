#include "ec11.h"
#include <string.h>

static uint8_t ec11_obj_num = 0;
static EC11_OBJ_T *ec11_obj_list[EC11_MAX_OBJ_NUM];

/* A引脚双边沿中断回调 */
static void ec11_irq_callback(void *args)
{
    EC11_OBJ_T *obj = (EC11_OBJ_T *)args;
    if (obj == NULL) return;

    /* A 下降沿：开始一次采样 */
    if (rt_pin_read(obj->ec11_a_pin) == 0 && obj->exti_flag == 0)
    {
        obj->exti_flag = 1;
        obj->b_level   = rt_pin_read(obj->ec11_b_pin);
    }

    /* A 上升沿：结束采样并判断方向 */
    if (rt_pin_read(obj->ec11_a_pin) == 1 && obj->exti_flag == 1)
    {
        obj->exti_flag = 0;
        uint8_t b_now = rt_pin_read(obj->ec11_b_pin);

        if (obj->b_level == 1 && b_now == 0)
        {
            switch (obj->ec11_dir)
            {
                case EC11_DIR_CLOCKWISE:
                    obj->ec11_counter++;
                    obj->ec11_coder_state = EC11_UP;
                    break;
                case EC11_DIR_ANTICLOCKWISE:
                    obj->ec11_counter--;
                    obj->ec11_coder_state = EC11_DOWN;
                    break;
                default:
                    break;
            }
        }
        else if (obj->b_level == 0 && b_now == 1)
        {
            switch (obj->ec11_dir)
            {
                case EC11_DIR_CLOCKWISE:
                    obj->ec11_counter--;
                    obj->ec11_coder_state = EC11_DOWN;
                    break;
                case EC11_DIR_ANTICLOCKWISE:
                    obj->ec11_counter++;
                    obj->ec11_coder_state = EC11_UP;
                    break;
                default:
                    break;
            }
        }
    }
}

/* EC11 对象初始化 */
EC11_STATE_ENUM_T EC11_Init(EC11_OBJ_T *ec11_obj,
                            rt_base_t ec11_a_pin,
                            rt_base_t ec11_b_pin,
                            rt_base_t ec11_key_pin,
                            uint8_t ec11_dir)
{
    if (ec11_obj == NULL) return EC11_OBJ_ERROR;
    if (ec11_obj_num >= EC11_MAX_OBJ_NUM) return EC11_OBJ_ERROR;

    memset(ec11_obj, 0, sizeof(EC11_OBJ_T));

    ec11_obj->ec11_a_pin   = ec11_a_pin;
    ec11_obj->ec11_b_pin   = ec11_b_pin;
    ec11_obj->ec11_key_pin = ec11_key_pin;
    ec11_obj->ec11_dir     = ec11_dir;

    ec11_obj->ec11_coder_state = EC11_DE;
    ec11_obj->ec11_key_state   = EC11_KEY_NULL;
    ec11_obj->ec11_state       = EC11_STATE_NULL;

    /* 配置为上拉输入 */
    rt_pin_mode(ec11_a_pin,   PIN_MODE_INPUT_PULLUP);
    rt_pin_mode(ec11_b_pin,   PIN_MODE_INPUT_PULLUP);
    rt_pin_mode(ec11_key_pin, PIN_MODE_INPUT_PULLUP);

    /* A引脚双边沿中断 */
    rt_pin_attach_irq(ec11_a_pin, PIN_IRQ_MODE_RISING_FALLING,
                      ec11_irq_callback, (void *)ec11_obj);
    rt_pin_irq_enable(ec11_a_pin, 1);

    ec11_obj_list[ec11_obj_num++] = ec11_obj;
    return EC11_INIT_OK;
}

/* 获取 EC11 状态（旋转 + 按键组合） */
EC11_STATE_ENUM_T EC11_GetState(EC11_OBJ_T *ec11_obj)
{
    if (ec11_obj == NULL) return EC11_OBJ_ERROR;

    EC11_STATE_ENUM_T buff = ec11_obj->ec11_coder_state;
    ec11_obj->ec11_coder_state = EC11_DE;

    switch (ec11_obj->ec11_key_state)
    {
        case EC11_KEY_SHORT_PRESS:
            switch (buff)
            {
                case EC11_UP:   ec11_obj->ec11_state = EC11_KEY_SHORT_PRESS_AND_UP;   break;
                case EC11_DOWN: ec11_obj->ec11_state = EC11_KEY_SHORT_PRESS_AND_DOWN; break;
                default:        ec11_obj->ec11_state = EC11_KEY_SHORT_PRESS;          break;
            }
            break;

        case EC11_KEY_LONG_PRESS:
            switch (buff)
            {
                case EC11_UP:   ec11_obj->ec11_state = EC11_KEY_LONG_PRESS_AND_UP;   break;
                case EC11_DOWN: ec11_obj->ec11_state = EC11_KEY_LONG_PRESS_AND_DOWN; break;
                default:        ec11_obj->ec11_state = EC11_KEY_LONG_PRESS;          break;
            }
            break;

        default:
            switch (buff)
            {
                case EC11_UP:   ec11_obj->ec11_state = EC11_UP;   break;
                case EC11_DOWN: ec11_obj->ec11_state = EC11_DOWN; break;
                default:        ec11_obj->ec11_state = EC11_STATE_NULL; break;
            }
            break;
    }

    return ec11_obj->ec11_state;
}

/* EC11 按键扫描，建议在 10ms 周期任务中调用 */
void EC11_KeyScan(EC11_OBJ_T *ec11_obj)
{
    if (ec11_obj == NULL) return;

    rt_tick_t now_time = rt_tick_get();

    /* 低电平有效（按下） */
    if (rt_pin_read(ec11_obj->ec11_key_pin) == 0)
    {
        switch (ec11_obj->ec11_key_state)
        {
            case EC11_KEY_NULL:
                ec11_obj->ec11_key_state = EC11_KEY_PRESS;
                ec11_obj->last_time = now_time;
                break;

            case EC11_KEY_PRESS:
                if (now_time - ec11_obj->last_time >= EC11_KEY_LONG_PRESS_TIM)
                {
                    ec11_obj->ec11_key_state = EC11_KEY_LONG_PRESS;
                }
                break;

            default:
                break;
        }
    }
    else
    {
        switch (ec11_obj->ec11_key_state)
        {
            case EC11_KEY_PRESS:
                if ((now_time - ec11_obj->last_time >= 10) &&
                    (now_time - ec11_obj->last_time < EC11_KEY_LONG_PRESS_TIM))
                {
                    ec11_obj->ec11_key_state = EC11_KEY_SHORT_PRESS;
                }
                else if (now_time - ec11_obj->last_time >= EC11_KEY_LONG_PRESS_TIM)
                {
                    ec11_obj->ec11_key_state = EC11_KEY_LONG_PRESS;
                }
                break;

            default:
                ec11_obj->ec11_key_state = EC11_KEY_NULL;
                ec11_obj->last_time = now_time;
                break;
        }
    }
}