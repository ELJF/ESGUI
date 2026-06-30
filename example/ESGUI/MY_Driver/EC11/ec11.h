#ifndef __EC11_H
#define __EC11_H

#include "main.h"

#define EC11_MAX_OBJ_NUM 5				//EC11最大对象数量
#define EC11_KEY_LONNG_PRESS_TIM 600	//EC11按键长按判定时间(ms),超过此值视为长按



//EC11的状态
typedef enum EC11_STATE_ENUM
{
	EC11_OBJ_ERROR,//EC11对象错误
	EC11_INIT_OK,	//对象初始化成功

	EC11_DIR_CLOCKWISE,//EC11方向顺时针
	EC11_DIR_ANTICLOCKWISE,//EC11方向逆时针

	EC11_UP,//顺时针转,计数增加
	EC11_DOWN,//逆时针转,计数减少
	EC11_DE,//不转,等待
	
	EC11_KEY_LONG_PRESS,//按键长按
	EC11_KEY_PRESS,		//按键按下
	EC11_KEY_SHORT_PRESS,//按键短按
	EC11_KEY_NULL,		//按键未被按下

	EC11_STATE_NULL,	//没有按键按下并且编码器没转

	EC11_KEY_SHORT_PRESS_AND_UP,
	EC11_KEY_SHORT_PRESS_AND_DOWN,
	EC11_KEY_LONG_PRESS_AND_UP,
	EC11_KEY_LONG_PRESS_AND_DOWN,

}EC11_STATE_ENUM_T;


typedef struct EC11_OBJ {
	GPIO_TypeDef* ec11_a_port;	//EC11 A引脚
	uint16_t ec11_a_pin;

	GPIO_TypeDef* ec11_b_port;	//EC11 B引脚
	uint16_t ec11_b_pin;

	GPIO_TypeDef* ec11_key_port;//EC11 Key引脚
	uint16_t ec11_key_pin;

	uint8_t ec11_dir;			//EC11方向

	uint32_t ec11_counter;		//EC11计数值

	EC11_STATE_ENUM_T ec11_state;//EC11 状态
	EC11_STATE_ENUM_T ec11_coder_state;//EC11 编码状态
	EC11_STATE_ENUM_T ec11_key_state;//EC11 按键状态

}EC11_OBJ_T;



EC11_STATE_ENUM_T EC11_Init(EC11_OBJ_T *ec11_obj,
	GPIO_TypeDef* ec11_a_port,
	uint16_t ec11_a_pin,
	GPIO_TypeDef* ec11_b_port,
	uint16_t ec11_b_pin,
	GPIO_TypeDef* ec11_key_port,
	uint16_t ec11_key_pin,
	EC11_STATE_ENUM_T ec11_dir);

EC11_STATE_ENUM_T EC11_GetState(EC11_OBJ_T *ec11_obj);

void EC11_KeyScan(EC11_OBJ_T *ec11_obj);


#endif

