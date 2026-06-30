//
// Created by E_LJF on 2025/8/15.
//

#ifndef F401_OLED_LIB_OLED_H
#define F401_OLED_LIB_OLED_H

#include "spi.h"


#define OLED_SPI_DMA_EN 1  //是否开启SPI DMA宏定义,0禁用 1启用
#define OLED_FUNK_EN    0  //功能函数是否启用宏定义,0禁用 1启用
#define OLED_MAX_OBJ_NUM 5 //OLED最大对象数量

typedef enum OLED_ENUM {
    OLED_DISPLAY_MODE_NOMAL,                 //正常显示
    OLED_DISPLAY_MODE_REVRESE_COLOR,         //反色显示
    OLED_DISPLAY_MODE_180,                   //屏幕旋转180度

    OLED_HorizontalSHAFT_DIRECTION_LEFT,     //OLED横向滚动方向 左
    OLED_HorizontalSHAFT_DIRECTION_RIGHT,    //OLED横向滚动方向 右
    OLED_HorizontalSHAFT_OFF,                //关闭滚动

    OLED_POINT_FILL,                         //填充
    OLED_POINT_CLEAN,                        //清除

    OLED_QUADRANT_1,                         //第一象限
    OLED_QUADRANT_2,                         //第二象限
    OLED_QUADRANT_3,                         //第三象限
    OLED_QUADRANT_4,                         //第四象限

    OLED_RECT_FILL,                          //正常矩形
    OLED_RECT_NOMAL,                         //矩形填充

}OLED_ENUM_T;


typedef struct OLED_OBJ {

    SPI_HandleTypeDef *hspi;

    GPIO_TypeDef *dc_port;
    uint16_t dc_pin;

    GPIO_TypeDef *rest_port;
    uint16_t rest_pin;

    GPIO_TypeDef *cs_port;
    uint16_t cs_pin;

    uint16_t oled_size_width;   //屏幕宽
    uint16_t oled_size_high;    //屏幕高
    uint16_t oled_gram_size;      //oled页数

    uint8_t *oled_gram;         //显存

}OLED_OBJ_T;


#if OLED_SPI_DMA_EN
void OLED_SPICallBack(SPI_HandleTypeDef *hspi);
#endif

void OLED_WriteCommand(OLED_OBJ_T *oled_obj,uint8_t c);
void OLED_WriteData(OLED_OBJ_T *oled_obj,uint8_t c);

void OLED_Init(OLED_OBJ_T *oled_obj,
    SPI_HandleTypeDef *hspi,
    GPIO_TypeDef *dc_port,
    uint16_t dc_pin,
    GPIO_TypeDef *rest_port,
    uint16_t rest_pin,
    GPIO_TypeDef *cs_port,
    uint16_t cs_pin,
    uint16_t oled_size_width,
    uint16_t oled_size_high
    );
void OLED_ObjDelete(OLED_OBJ_T *oled_obj);

void OLED_Refresh(OLED_OBJ_T *oled_obj);
void OLED_Off(OLED_OBJ_T *oled_obj);
void OLED_On(OLED_OBJ_T *oled_obj);
void OLED_Clear(OLED_OBJ_T *oled_obj);
void OLED_Fill(OLED_OBJ_T *oled_obj,uint8_t dat);
void OLED_DisplayMode(OLED_OBJ_T *oled_obj,OLED_ENUM_T mode);
void OLED_IntensityControl(OLED_OBJ_T *oled_obj,uint8_t intensity);
void OLED_Shift(OLED_OBJ_T *oled_obj,uint8_t shift);
void OLED_HorizontalShift(OLED_OBJ_T *oled_obj,uint8_t start_page,uint8_t end_page,OLED_ENUM_T direction);




#if OLED_FUNK_EN

void OLED_DrawPoint(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,OLED_ENUM_T t);

void OLED_FillXY(OLED_OBJ_T *oled_obj,uint16_t x1,uint16_t y1,uint16_t x2,uint16_t y2,OLED_ENUM_T mode);

void OLED_DrawLine(OLED_OBJ_T *oled_obj,uint16_t x1,uint16_t y1,uint16_t x2,uint16_t y2,OLED_ENUM_T mode);
void OLED_DrawAngleLine(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,int16_t du,uint16_t len,OLED_ENUM_T mode);

void OLED_DrawCircle(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,uint16_t r,OLED_ENUM_T mode);
void OLED_DrawCircleNoFloat(OLED_OBJ_T *oled_obj,uint16_t xc, uint16_t yc, uint16_t r,OLED_ENUM_T mode);
void OLED_DrawFillCircle(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,uint16_t r,OLED_ENUM_T mode);
void OLED_DrawPartCircle(OLED_OBJ_T *oled_obj,uint16_t x0, uint16_t y0, uint16_t r, OLED_ENUM_T quadrant,OLED_ENUM_T mode);

void OLED_DrawEllipse(OLED_OBJ_T *oled_obj,uint16_t xc, uint16_t yc, uint16_t a, uint16_t b,OLED_ENUM_T mode);

void OLED_DrawBlock(OLED_OBJ_T *oled_obj,uint16_t xStart, uint16_t yStart, uint16_t xEnd, uint16_t yEnd,OLED_ENUM_T mode);
void OLED_DrawRect(OLED_OBJ_T *oled_obj,uint16_t xStart, uint16_t yStart, uint16_t length, uint16_t width, OLED_ENUM_T isFill,OLED_ENUM_T mode);
void OLED_DrawRoundRectangle(OLED_OBJ_T *oled_obj,uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1, uint16_t R,OLED_ENUM_T mode);

void DrawTriangle(OLED_OBJ_T *oled_obj,uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2,OLED_ENUM_T mode);

void OLED_ShowPicture(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,uint16_t sizex,uint16_t sizey,uint8_t BMP[],OLED_ENUM_T mode);
 


#endif


#endif //F401_OLED_LIB_OLED_H