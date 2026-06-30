#include "ec11.h"
#include "string.h"

typedef struct EC11_OBJ_P {
	EC11_OBJ_T *ec11_obj_ptr;
}EC11_OBJ_P_T;


static uint8_t exti_flag = 0;;
static uint8_t b_level = 0;

static uint8_t ec11_obj_num = 0;
static EC11_OBJ_P_T ec11_obj_list[EC11_MAX_OBJ_NUM];




void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
	for (uint8_t i = 0; i < ec11_obj_num; i++) {
		if (GPIO_Pin == ec11_obj_list[i].ec11_obj_ptr->ec11_a_pin) {
			if(HAL_GPIO_ReadPin(ec11_obj_list[i].ec11_obj_ptr->ec11_a_port,ec11_obj_list[i].ec11_obj_ptr->ec11_a_pin) == 0 && exti_flag == 0)
			{
				exti_flag += 1;
				b_level = 0;

				if(HAL_GPIO_ReadPin(ec11_obj_list[i].ec11_obj_ptr->ec11_b_port,ec11_obj_list[i].ec11_obj_ptr->ec11_b_pin) == 1)
				{
					b_level = 1;
				}
			}

			if(HAL_GPIO_ReadPin(ec11_obj_list[i].ec11_obj_ptr->ec11_a_port,ec11_obj_list[i].ec11_obj_ptr->ec11_a_pin) == 1 && exti_flag == 1)
			{
				exti_flag = 0;

				if(b_level==1 && HAL_GPIO_ReadPin(ec11_obj_list[i].ec11_obj_ptr->ec11_b_port,ec11_obj_list[i].ec11_obj_ptr->ec11_b_pin) == 0)
				{
					switch (ec11_obj_list[i].ec11_obj_ptr->ec11_dir) {
						case EC11_DIR_CLOCKWISE:
							ec11_obj_list[i].ec11_obj_ptr->ec11_counter++;//计数值增加
							ec11_obj_list[i].ec11_obj_ptr->ec11_coder_state = EC11_UP;
							break;

						case EC11_DIR_ANTICLOCKWISE:
							ec11_obj_list[i].ec11_obj_ptr->ec11_counter--;//计数值减小
							ec11_obj_list[i].ec11_obj_ptr->ec11_coder_state = EC11_DOWN;
							break;

						default:
							break;
					}

				}
				if(b_level==0 && HAL_GPIO_ReadPin(ec11_obj_list[i].ec11_obj_ptr->ec11_b_port,ec11_obj_list[i].ec11_obj_ptr->ec11_b_pin) == 1)
				{
					switch (ec11_obj_list[i].ec11_obj_ptr->ec11_dir) {
						case EC11_DIR_CLOCKWISE:
							ec11_obj_list[i].ec11_obj_ptr->ec11_counter--;//计数值减小
							ec11_obj_list[i].ec11_obj_ptr->ec11_coder_state = EC11_DOWN;
							break;

						case EC11_DIR_ANTICLOCKWISE:
							ec11_obj_list[i].ec11_obj_ptr->ec11_counter++;//计数值增加
							ec11_obj_list[i].ec11_obj_ptr->ec11_coder_state = EC11_UP;
							break;

						default:
							break;
					}
				}
			}
		}
	}
}


//EC11对象初始化
// ec11				EC11对象结构体
// ec11_a_port		EC11 A引脚GPIO组
// ec11_a_pin		EC11 A引脚GPIO号
// ec11_b_port		EC11 B引脚GPIO组
// ec11_b_pin		EC11 B引脚GPIO号
// ec11_key_port	EC11 KEY引脚GPIO组
// ec11_key_pin		EC11 KET引脚GPIO号
// ec11_dir			EC11 编码器方向
EC11_STATE_ENUM_T EC11_Init(EC11_OBJ_T *ec11_obj,
	GPIO_TypeDef* ec11_a_port,
	uint16_t ec11_a_pin,
	GPIO_TypeDef* ec11_b_port,
	uint16_t ec11_b_pin,
	GPIO_TypeDef* ec11_key_port,
	uint16_t ec11_key_pin,
	EC11_STATE_ENUM_T ec11_dir) {

	if ((ec11_obj == NULL)){return EC11_OBJ_ERROR;}

	if (ec11_obj_num == 0) {
		memset(ec11_obj_list, 0, sizeof(ec11_obj_list));
	}else if(ec11_obj_num == EC11_MAX_OBJ_NUM) {
		ec11_obj->ec11_a_port = NULL;
		return EC11_OBJ_ERROR;
	}

	ec11_obj->ec11_a_port = ec11_a_port;
	ec11_obj->ec11_a_pin = ec11_a_pin;
	ec11_obj->ec11_b_port = ec11_b_port;
	ec11_obj->ec11_b_pin = ec11_b_pin;
	ec11_obj->ec11_key_port = ec11_key_port;
	ec11_obj->ec11_key_pin = ec11_key_pin;
	ec11_obj->ec11_dir = ec11_dir;

	ec11_obj->ec11_counter = 0;
	ec11_obj->ec11_coder_state = EC11_DE;
	ec11_obj->ec11_key_state = EC11_KEY_NULL;
	ec11_obj->ec11_state = EC11_STATE_NULL;

	ec11_obj_list[ec11_obj_num].ec11_obj_ptr = ec11_obj;
	ec11_obj_num ++;
	return EC11_INIT_OK;
}


//获取EC11对象状态
// ec11		EC11对象结构体
//返回		EC11对象编码状态
EC11_STATE_ENUM_T EC11_GetState(EC11_OBJ_T *ec11_obj) {
	if (ec11_obj == NULL){return EC11_OBJ_ERROR;}
	EC11_STATE_ENUM_T buff = ec11_obj->ec11_coder_state;
	ec11_obj->ec11_coder_state = EC11_DE;

	switch (ec11_obj->ec11_key_state) {
		case EC11_KEY_SHORT_PRESS:
			switch (buff) {
			case EC11_UP:
					ec11_obj->ec11_state = EC11_KEY_SHORT_PRESS_AND_UP;
					break;

			case EC11_DOWN:
					ec11_obj->ec11_state = EC11_KEY_SHORT_PRESS_AND_DOWN;
					break;

			default:
					ec11_obj->ec11_state = EC11_KEY_SHORT_PRESS;
					break;
			}
			break;

		case EC11_KEY_LONG_PRESS:
			switch (buff) {
			case EC11_UP:
					ec11_obj->ec11_state = EC11_KEY_LONG_PRESS_AND_UP;
					break;

			case EC11_DOWN:
					ec11_obj->ec11_state = EC11_KEY_LONG_PRESS_AND_DOWN;
					break;

			default:
					ec11_obj->ec11_state = EC11_KEY_LONG_PRESS;
					break;
			}
			break;


		default:
			switch (buff) {
			case EC11_UP:
					ec11_obj->ec11_state = EC11_UP;
					break;

			case EC11_DOWN:
					ec11_obj->ec11_state = EC11_DOWN;
					break;

			default:
					ec11_obj->ec11_state = EC11_STATE_NULL;
					break;
			}
			break;
	}

	return ec11_obj->ec11_state;
}


//获取EC11对象按键状态
// ec11		EC11对象结构体
//返回		EC11对象按键状态
// static EC11_STATE_ENUM_T EC11_GetKeyState(EC11_OBJ_T *ec11_obj) {
// 	if (ec11_obj == NULL){return EC11_OBJ_ERROR;}
// 	return ec11_obj->ec11_key_state;
// }


//EC11 按键扫描
void EC11_KeyScan(EC11_OBJ_T *ec11_obj) {
	if (ec11_obj == NULL){return;}
	static uint32_t last_time = 0;
	uint32_t now_time = 0;

	if (HAL_GPIO_ReadPin(ec11_obj->ec11_key_port,ec11_obj->ec11_key_pin) == GPIO_PIN_RESET) {
		switch (ec11_obj->ec11_key_state) {
			case EC11_KEY_NULL://第一次按下
				ec11_obj->ec11_key_state = EC11_KEY_PRESS;
				last_time = HAL_GetTick();
				break;

			case EC11_KEY_PRESS:
				if (HAL_GetTick() - last_time >= EC11_KEY_LONNG_PRESS_TIM) {
					ec11_obj->ec11_key_state = EC11_KEY_LONG_PRESS;
				}
				break;

			default:
				break;
		}
	}
	else {
		switch (ec11_obj->ec11_key_state) {
			case EC11_KEY_PRESS:
				if ((HAL_GetTick() - last_time >= 10) && (HAL_GetTick() - last_time < EC11_KEY_LONNG_PRESS_TIM)) {
					ec11_obj->ec11_key_state = EC11_KEY_SHORT_PRESS;//确定按下
				}
				else if (HAL_GetTick() - last_time >= EC11_KEY_LONNG_PRESS_TIM) {
					ec11_obj->ec11_key_state = EC11_KEY_LONG_PRESS;
				}
				break;

			default:
				ec11_obj->ec11_key_state = EC11_KEY_NULL;
				last_time = HAL_GetTick();
				break;
		}
	}

}




