//
// Created by E_LJF on 2025/8/15.
//

#include "oled.h"
#include <stdlib.h>
#include "math.h"
#include "string.h"


#if OLED_SPI_DMA_EN == 1

uint8_t oled_obj_num = 0;
uint8_t spi_dma_ok_flag = 1;

struct {
    GPIO_TypeDef *cs_port;
    uint16_t cs_pin;
}OLED_OBJ_CSP[OLED_MAX_OBJ_NUM];


void OLED_SPICallBack(SPI_HandleTypeDef *hspi)
{
    while (__HAL_SPI_GET_FLAG(hspi, SPI_FLAG_BSY) != RESET);
    spi_dma_ok_flag = 1;
    for (uint8_t i = 0; i < oled_obj_num; i++) {
        HAL_GPIO_WritePin(OLED_OBJ_CSP[i].cs_port,OLED_OBJ_CSP[i].cs_pin,GPIO_PIN_SET);
    }
}

static void delay_us(uint32_t us)
{
    for (volatile uint32_t i = 0; i < us * (SystemCoreClock / 1000000 / 5); i++)
    {
        __NOP();
    }
}

#endif


//以二维数组的操作方式操作一维数组
//cols 总列数
//x 列坐标
//y 行坐标
#define arr_1_to_2( arr1,cols,x,y)  (arr1)[ ((y) * (cols) + (x)) ]





#if OLED_SPI_DMA_EN == 1

//OLED写命令函数
// oled_obj OLED对象结构体
// c        要写入的命令
void OLED_WriteCommand(OLED_OBJ_T *oled_obj,uint8_t c) {
    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_RESET);
    HAL_GPIO_WritePin(oled_obj->dc_port,oled_obj->dc_pin,GPIO_PIN_RESET);

    delay_us(10);

    if (spi_dma_ok_flag) {
        spi_dma_ok_flag = 0;
        HAL_SPI_Transmit_DMA(oled_obj->hspi,&c,1);
    }
}


//OLED写数据函数
// oled_obj OLED对象结构体
// c        要写入的数据
void OLED_WriteData(OLED_OBJ_T *oled_obj,uint8_t c) {
    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_RESET);
    HAL_GPIO_WritePin(oled_obj->dc_port,oled_obj->dc_pin,GPIO_PIN_SET);

    delay_us(10);

    if (spi_dma_ok_flag) {
        spi_dma_ok_flag = 0;
        HAL_SPI_Transmit_DMA(oled_obj->hspi,&c,1);
    }
}

#else

//OLED写命令函数
// oled_obj OLED对象结构体
// c        要写入的命令
void OLED_WriteCommand(OLED_OBJ_T *oled_obj,uint8_t c) {
    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_RESET);
    HAL_GPIO_WritePin(oled_obj->dc_port,oled_obj->dc_pin,GPIO_PIN_RESET);
    HAL_SPI_Transmit(oled_obj->hspi,&c,1,10);
    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_SET);
}


//OLED写数据函数
// oled_obj OLED对象结构体
// c        要写入的数据
void OLED_WriteData(OLED_OBJ_T *oled_obj,uint8_t c) {
    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_RESET);
    HAL_GPIO_WritePin(oled_obj->dc_port,oled_obj->dc_pin,GPIO_PIN_SET);
    HAL_SPI_Transmit(oled_obj->hspi,&c,1,10);
    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_SET);
}
#endif


//OLED初始化需要的命令
const uint8_t oled_init_hex[] =
{
    /* 1. 关闭显示 */
    0xAE,

    /* 2. 设置时钟分频比/振荡器频率 */
    0xD5, 0x80,         /* 分频比=1, 振荡器频率=默认 */

    /* 3. 设置多路复用率 */
    0xA8, 0x3F,         /* 1/64 duty */

    /* 4. 设置显示偏移 */
    0xD3, 0x00,         /* 无偏移 */

    /* 5. 设置显示起始行 */
    0x40,               /* 起始行 = 0 */

    /* 6. 开启电荷泵 (SSD1306 必须) */
    0x8D, 0x14,         /* 0x14=启用电荷泵, 0x10=禁用 */

    /* 7. 设置内存地址模式 */
    0x20, 0x00,         /* 0x00=水平寻址, 0x01=垂直寻址, 0x02=页寻址 */

    /* 8. 设置段重映射 */
    0xA1,               /* 0xA0=正常, 0xA1=重映射 (配合翻转) */

    /* 9. 设置 COM 扫描方向 */
    0xC8,               /* 0xC0=正常, 0xC8=反向扫描 */

    /* 10. 设置 COM 引脚硬件配置 */
    0xDA, 0x12,         /* 0x12=顺序COM, 禁用左右重映射 */

    /* 11. 设置对比度 */
    0x81, 0xCF,         /* 对比度 = 207 (范围 0-255) */

    /* 12. 设置预充电周期 */
    0xD9, 0xF1,         /* 相位1=15, 相位2=1 */

    /* 13. 设置 VCOMH 取消选择电平 */
    0xDB, 0x40,         /* ~0.77x Vcc */

    /* 14. 禁用滚动 */
    0x2E,

    /* 15. 输出跟随 RAM */
    0xA4,               /* 0xA4=跟随RAM, 0xA5=全亮 */

    /* 16. 设置正常/反向显示 */
    0xA6,               /* 0xA6=正常, 0xA7=反向 */

    /* 17. 开启显示 (可选: 初始化后单独发送) */
    0xAF
};


//OLED对象初始化
// oled_obj     OLED对象结构体
// hspi         OLED使用的SPI
// dc_port      OLED DC引脚GPIO组
// dc_pin       OLED DC引脚GPIO号
// rest_port    OLED REST引脚GPIO组
// rest_pin     OLED REST引脚GPIO号
// cs_port      OLED CS引脚GPIO组
// cs_pin       OLED CS引脚GPIO号
// oled_size_width  OLED屏宽度(像素)
// oled_size_high   OLED屏高度(像素)
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
    ) {
    if ((oled_obj == NULL) || (hspi == NULL) || (dc_port == NULL) || (rest_port == NULL)) {
        return;
    }

    oled_obj->hspi = hspi;
    oled_obj->dc_port = dc_port;
    oled_obj->dc_pin = dc_pin;
    oled_obj->rest_port = rest_port;
    oled_obj->rest_pin = rest_pin;
    oled_obj->cs_port = cs_port;
    oled_obj->cs_pin = cs_pin;
    oled_obj->oled_size_width = oled_size_width;
    oled_obj->oled_size_high = oled_size_high;

    oled_obj->oled_gram_size = (((oled_size_high % 8) == 0) ? (oled_size_high / 8) : (oled_size_high / 8 + 1)) * oled_obj->oled_size_width;

    oled_obj->oled_gram = malloc(sizeof(uint8_t) * oled_obj->oled_gram_size);
    if (oled_obj->oled_gram == NULL) {return;}

    memset(oled_obj->oled_gram,0x00,oled_obj->oled_gram_size);

    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_RESET);

    HAL_GPIO_WritePin(oled_obj->dc_port,oled_obj->dc_pin,GPIO_PIN_RESET);

    HAL_GPIO_WritePin(oled_obj->rest_port,oled_obj->rest_pin,GPIO_PIN_RESET);//复位
    HAL_Delay(100);
    HAL_GPIO_WritePin(oled_obj->rest_port,oled_obj->rest_pin,GPIO_PIN_SET);

    HAL_SPI_Transmit(oled_obj->hspi,oled_init_hex,sizeof(oled_init_hex),100);

    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_SET);

#if OLED_SPI_DMA_EN == 1
    __HAL_DMA_DISABLE_IT(oled_obj->hspi->hdmatx,DMA_IT_HT);

    if (oled_obj_num < OLED_MAX_OBJ_NUM){
        oled_obj_num++;
        OLED_OBJ_CSP[oled_obj_num-1].cs_port = oled_obj->cs_port;
        OLED_OBJ_CSP[oled_obj_num-1].cs_pin = oled_obj->cs_pin;
    }
#endif

    OLED_Refresh(oled_obj);

}


//删除OLED对象,并回收内存资源
// oled_obj     OLED对象结构体
void OLED_ObjDelete(OLED_OBJ_T *oled_obj) {
#if OLED_SPI_DMA_EN == 1
    if ((oled_obj == NULL) || (oled_obj_num == 0)) {return;}
#else
    if (oled_obj == NULL) {return;}
#endif

    oled_obj->hspi = NULL;
    oled_obj->dc_port = NULL;
    oled_obj->dc_pin = 0;
    oled_obj->rest_port = NULL;
    oled_obj->rest_pin = 0;
    oled_obj->cs_port = NULL;
    oled_obj->cs_pin = 0;
    oled_obj->oled_size_width = 0;
    oled_obj->oled_size_high = 0;

    oled_obj->oled_gram_size = 0;

    free(oled_obj->oled_gram);

#if OLED_SPI_DMA_EN == 1
    if (oled_obj_num > 0){
        OLED_OBJ_CSP[oled_obj_num-1].cs_port = NULL;
        OLED_OBJ_CSP[oled_obj_num-1].cs_pin = 0;
        oled_obj_num--;
    }
#endif

}


//将OLED显存发送到OLED屏幕上显示
// oled_obj OLED对象结构体
void OLED_Refresh(OLED_OBJ_T *oled_obj) {
    if (oled_obj == NULL) {return;}
    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_RESET);

    HAL_GPIO_WritePin(oled_obj->dc_port,oled_obj->dc_pin,GPIO_PIN_SET);

#if OLED_SPI_DMA_EN == 1
    delay_us(7);
    if (spi_dma_ok_flag) {
        spi_dma_ok_flag = 0;
        HAL_SPI_Transmit_DMA(oled_obj->hspi,oled_obj->oled_gram,oled_obj->oled_gram_size);
    }
#else
    HAL_SPI_Transmit(oled_obj->hspi,oled_obj->oled_gram,(oled_obj->oled_gram_size),15);
    HAL_GPIO_WritePin(oled_obj->cs_port,oled_obj->cs_pin,GPIO_PIN_SET);
#endif
}


//关闭OLED屏幕
// oled_obj OLED对象结构体
void OLED_Off(OLED_OBJ_T *oled) {
    if (oled == NULL) {return;}
    OLED_WriteCommand(oled,0X8D);  //设置电荷泵
    OLED_WriteCommand(oled,0X10);  //关闭电荷泵
    OLED_WriteCommand(oled,0XAE);  //OLED休眠
}


//开启OLED屏幕
// oled_obj OLED对象结构体
void OLED_On(OLED_OBJ_T *oled) {
    if (oled == NULL) {return;}
    OLED_WriteCommand(oled,0X8D);  //设置电荷泵
    OLED_WriteCommand(oled,0X14);  //开启电荷泵
    OLED_WriteCommand(oled,0XAF);  //OLED唤醒
}


//清除空OLED显存
// oled_obj OLED对象结构体
void OLED_Clear(OLED_OBJ_T *oled_obj) {
    if (oled_obj == NULL) {return;}
    memset(oled_obj->oled_gram,0x00,oled_obj->oled_gram_size);
}


//OLED显存填充指定值
// oled_obj OLED对象结构体
// dat      要填充的值
void OLED_Fill(OLED_OBJ_T *oled_obj,uint8_t dat) {
    if (oled_obj == NULL) {return;}
    memset(oled_obj->oled_gram,dat,oled_obj->oled_gram_size);
}




//OLED是否反色显示设置
// oled_obj OLED对象结构体
// mode     显示模式
void OLED_DisplayMode(OLED_OBJ_T *oled_obj,OLED_ENUM_T mode) {
    if (oled_obj == NULL) {return;}
    switch (mode) {
        case OLED_DISPLAY_MODE_NOMAL:
            OLED_WriteCommand(oled_obj,0xC8);
            OLED_WriteCommand(oled_obj,0xA1);
            OLED_WriteCommand(oled_obj,0XA6);
            break;

        case OLED_DISPLAY_MODE_REVRESE_COLOR:
            OLED_WriteCommand(oled_obj,0XA7);
            break;

        case OLED_DISPLAY_MODE_180:
            OLED_WriteCommand(oled_obj,0xC0);
           OLED_WriteCommand(oled_obj,0xA0);
            break;

        default:
            break;
    }
}


//更改OLED亮度
// oled_obj     OLED对象结构体
// intensity    亮度,范围0~255
void OLED_IntensityControl(OLED_OBJ_T *oled_obj,uint8_t intensity)
{
    if (oled_obj == NULL) {return;}
    OLED_WriteCommand(oled_obj,0x81);
    OLED_WriteCommand(oled_obj,intensity);
}


//全屏内容向上偏移指定距离
// oled_obj OLED对象结构体
// shift    偏移距离,范围0~63
void OLED_Shift(OLED_OBJ_T *oled_obj,uint8_t shift) {
    if (oled_obj == NULL) {return;}
    for(uint8_t i = 0; i < shift; i++)
    {
        OLED_WriteCommand(oled_obj,0xd3);//设置显示偏移，垂直向上偏移
        OLED_WriteCommand(oled_obj,i);//偏移量
        HAL_Delay(10);//延时时间
    }
}


//屏幕指定范围内容水平方向滚动播放
// oled_obj OLED对象结构体
// start_page  	开始页数
// end_page  	结束页数
// direction  	滚动方向,左,右或者关闭
void OLED_HorizontalShift(OLED_OBJ_T *oled_obj,uint8_t start_page,uint8_t end_page,OLED_ENUM_T direction) {
    if (oled_obj == NULL) {return;}
    // start_page = (start_page > end_page) ? start_page : end_page;

        OLED_WriteCommand(oled_obj,0x2e);  //关闭滚动

    switch (direction) {
        case OLED_HorizontalSHAFT_DIRECTION_LEFT:
            OLED_WriteCommand(oled_obj,0x27);//设置滚动方向
            break;

        case OLED_HorizontalSHAFT_DIRECTION_RIGHT:
            OLED_WriteCommand(oled_obj,0x26);//设置滚动方向
            break;

        case OLED_HorizontalSHAFT_OFF:
            OLED_WriteCommand(oled_obj,0x2E);
            return;
            break;

        default:
            break;
    }
        OLED_WriteCommand(oled_obj,0x00);//虚拟字节设置，默认为0x00
        OLED_WriteCommand(oled_obj,start_page);//设置开始页地址
        OLED_WriteCommand(oled_obj,0x05);//设置每个滚动步骤之间的时间间隔的帧频
        OLED_WriteCommand(oled_obj,end_page);//设置结束页地址
        OLED_WriteCommand(oled_obj,0x00);//虚拟字节设置，默认为0x00
        OLED_WriteCommand(oled_obj,0xff);//虚拟字节设置，默认为0xff

        OLED_WriteCommand(oled_obj,0x2f);//开启滚动-0x2f，禁用滚动-0x2e，禁用需要重写数据
}








#if OLED_FUNK_EN

//填充OLED显存指定位置
// oled_obj     OLED对象结构体
// x1,y1,x2,y2  xy轴坐标
// mode         显示模式
void OLED_FillXY(OLED_OBJ_T *oled_obj,uint16_t x1,uint16_t y1,uint16_t x2,uint16_t y2,OLED_ENUM_T mode) {
    if (oled_obj == NULL) {return;}
    uint16_t x,y;
    for(x=x1; x<=x2; x++)
    {
        for(y=y1; y<=y2; y++)OLED_DrawPoint(oled_obj,x,y,mode);
    }
}


//画出给定点的四分对称点
// oled_obj     OLED对象结构体
// xc,yc        椭圆中心行坐标
// x,y          给定点
static void Ellipse4Point(OLED_OBJ_T *oled_obj,uint16_t xc, uint16_t yc, uint16_t x, uint16_t y,OLED_ENUM_T mode)
{

    OLED_DrawPoint(oled_obj,(xc+x), (yc+y), mode);//1
    OLED_DrawPoint(oled_obj,(xc-x), (yc+y), mode);//2
    OLED_DrawPoint(oled_obj,(xc-x), (yc-y), mode);//3
    OLED_DrawPoint(oled_obj,(xc+x), (yc-y), mode);//4
}


//画出给定点的八分对称点
// oled_obj     OLED对象结构体
// xc,yc        圆心坐标
// x,y          给定点
static inline void Circle8Point(OLED_OBJ_T *oled_obj,uint16_t xc, uint16_t yc, uint16_t x, uint16_t y,OLED_ENUM_T mode)
{
    OLED_DrawPoint(oled_obj,(xc+x), (yc+y), mode);//1
    OLED_DrawPoint(oled_obj,(xc+y), (yc+x), mode);//2
    OLED_DrawPoint(oled_obj,(xc-y), (yc+x), mode);//3
    OLED_DrawPoint(oled_obj,(xc-x), (yc+y), mode);//4
    OLED_DrawPoint(oled_obj,(xc-x), (yc-y), mode);//5
    OLED_DrawPoint(oled_obj,(xc-y), (yc-x), mode);//6
    OLED_DrawPoint(oled_obj,(xc+y), (yc-x), mode);//7
    OLED_DrawPoint(oled_obj,(xc+x), (yc-y), mode);//8
}



//在显存上画点
// oled_obj OLED对象结构体
// x 点的x轴坐标
// y 点的y轴坐标
// t 1填充 0清空
void OLED_DrawPoint(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,OLED_ENUM_T t)
{

    if (oled_obj == NULL) {return;}

    x = (x > oled_obj->oled_size_width) ? oled_obj->oled_size_width : x;
    y = (y > oled_obj->oled_size_high) ? oled_obj->oled_size_high : y;

    uint8_t i,m,n;
    i=y/8;
    m=y%8;
    n=1<<m;

    switch (t) {
        case OLED_POINT_FILL:
            arr_1_to_2(oled_obj->oled_gram,oled_obj->oled_size_width,x,i) |= n;
            break;

        case OLED_POINT_CLEAN:
            arr_1_to_2(oled_obj->oled_gram,oled_obj->oled_size_width,x,i)=~arr_1_to_2(oled_obj->oled_gram,oled_obj->oled_size_width,x,i);
            arr_1_to_2(oled_obj->oled_gram,oled_obj->oled_size_width,x,i)|=n;
            arr_1_to_2(oled_obj->oled_gram,oled_obj->oled_size_width,x,i)=~arr_1_to_2(oled_obj->oled_gram,oled_obj->oled_size_width,x,i);
            break;

        default:
            break;
    }
}


//在显存上画线
// oled_obj OLED对象结构体
// x1,y1 起点坐标
// x2,y2 终点坐标
// mode  显示模式
void OLED_DrawLine(OLED_OBJ_T *oled_obj,uint16_t x1,uint16_t y1,uint16_t x2,uint16_t y2,OLED_ENUM_T mode)
{

    if (oled_obj == NULL) {return;}

    x1 = (x1 > oled_obj->oled_size_width) ? oled_obj->oled_size_width : x1;
    x2 = (x2 > oled_obj->oled_size_width) ? oled_obj->oled_size_width : x2;
    y1 = (y1 > oled_obj->oled_size_high) ? oled_obj->oled_size_high : y1;
    y2 = (y2 > oled_obj->oled_size_high) ? oled_obj->oled_size_high : y2;

    if (y2 < y1) {
        x1 = x1 ^ x2;
        x2 = x1 ^ x2;
        x1 = x2 ^ x1;

        y1 = y1 ^ y2;
        y2 = y1 ^ y2;
        y1 = y2 ^ y1;
    }

    uint16_t t;
    int32_t xerr=0,yerr=0,delta_x,delta_y,distance;
    int32_t incx,incy,uRow,uCol;
    delta_x=x2-x1; //计算坐标增量
    delta_y=y2-y1;
    uRow=x1;//划线起点坐标
    uCol=y1;
    if(delta_x>0)incx=1; //设置单步方向
    else if (delta_x==0)incx=0;//垂直线
    else {incx=-1;delta_x=-delta_x;}
    if(delta_y>0)incy=1;
    else if (delta_y==0)incy=0;//水平线
    else {incy=-1;delta_y=-delta_x;}
    if(delta_x>delta_y)distance=delta_x; //选取基本增量坐标轴
    else distance=delta_y;
    for(t=0;t<distance+1;t++)
    {
        OLED_DrawPoint(oled_obj,uRow,uCol,mode);//画点

        xerr+=delta_x;
        yerr+=delta_y;
        if(xerr>distance)
        {
            xerr-=distance;
            uRow+=incx;
        }
        if(yerr>distance)
        {
            yerr-=distance;
            uCol+=incy;
        }
    }
}


//在显存上画带角度的线
// oled_obj OLED对象结构体
// x,y      起点坐标
// du       角度
// len      长度
// mode     显示模式
void OLED_DrawAngleLine(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,int16_t du,uint16_t len,OLED_ENUM_T mode) {
    if(oled_obj == NULL) {return;}
    int16_t x0,y0;
    //竖直向上为0度
    float k = (du-90)*(3.1415926535L/180);
    for(uint16_t i=0;i<len;i++)
    {
        x0=cos(k)*i;
        y0=sin(k)*i;
        OLED_DrawPoint(oled_obj,x+x0,y+y0,mode);
    }
}


//在显存上画四分之一圆狐
// oled_obj     OLED对象结构体
// x0,y0        圆心坐标
// r            半径
// quadrant     象限
// mode         显示模式
void OLED_DrawPartCircle(OLED_OBJ_T *oled_obj,uint16_t x0, uint16_t y0, uint16_t r, OLED_ENUM_T quadrant,OLED_ENUM_T mode) {
    if((oled_obj == NULL) || (r == 0)) {return;}

    uint16_t a;
    int16_t di;
    a = 0;
    di = 3 - (r << 1);
    while(a <= r)
    {
        switch(quadrant)
        {
            case OLED_QUADRANT_1:
                OLED_DrawPoint(oled_obj,x0 + r, y0 + a,mode);
                OLED_DrawPoint(oled_obj,x0 + a, y0 + r,mode);
                break;
            case OLED_QUADRANT_2:
                OLED_DrawPoint(oled_obj,x0 - a, y0 + r,mode);
                OLED_DrawPoint(oled_obj,x0 - r, y0 + a,mode);
                break;
            case OLED_QUADRANT_3:
                OLED_DrawPoint(oled_obj,x0 - a, y0 - r,mode);
                OLED_DrawPoint(oled_obj,x0 - r, y0 - a,mode);
                break;
            case OLED_QUADRANT_4:
                OLED_DrawPoint(oled_obj,x0 + a, y0 - r,mode);
                OLED_DrawPoint(oled_obj,x0 + r, y0 - a,mode);
                break;
            default:
                break;
        }
        a++;
        if(di < 0)di += 4 * a + 6;
        else
        {
            di += 10 + 4 * (a - r);
            r--;
        }
    }

}


//在显存上画椭圆
// oled_obj     OLED对象结构体
// xc,yc        椭圆中心坐标
// a            短半轴长
// b            长半轴长
// mode         显示模式
void OLED_DrawEllipse(OLED_OBJ_T *oled_obj,uint16_t xc, uint16_t yc, uint16_t a, uint16_t b,OLED_ENUM_T mode)
{
    int16_t x=0;
    int16_t y=b;
    int16_t b2=(int16_t)b;

    float sqa=a*a;
    float sqb=b*b;
    float d=sqb+sqa*(-b2+0.25f);

    Ellipse4Point(oled_obj,xc, yc, x, y,mode);
    while((sqb*(x+1)) < (sqa*(y-0.5f)))
    {
        if(d < 0)
        {
            d += sqb*(2*x+3);
        } else {
            d += sqb*(2*x+3)+sqa*(-2*y+2);
            --y;
        }
        ++x;
        Ellipse4Point(oled_obj,xc, yc, x, y,mode);
    }

    d = (b*(x+0.5))*2 + (a*(y-1))*2 - (a*b)*2;
    while(y > 0)
    {
        if(d < 0)
        {
            d += sqb*(2*x+2)+sqa*(-2*y+3);
            ++x;
        } else {
            d += sqa*(-2*y+3);
        }
        --y;
        Ellipse4Point(oled_obj,xc, yc, x, y,mode);
    }
}


//在显存上画圆,但避免浮点运算
// oled_obj     OLED对象结构体
// xc,yc        圆心坐标
// r            半径
// mode         显示模式
void OLED_DrawCircleNoFloat(OLED_OBJ_T *oled_obj,uint16_t xc, uint16_t yc, uint16_t r,OLED_ENUM_T mode) {
    if(oled_obj == NULL) {return;}

    uint32_t x=0, y=0;
    int32_t d=0;

    x = 0;
    y = r;
    d = 3-2*r;

    Circle8Point(oled_obj,xc ,yc, x, y,mode);
    while(x < y)
    {
        if(d < 0)
        {
            d += 4*x+6;
        } else {
            d += 4*(x-y)+10;
            --y;
        }
        ++x;
        Circle8Point(oled_obj,xc ,yc, x, y,mode);
    }
}


//在显存上画圆
// oled_obj OLED对象结构体
// x,y      圆心坐标
// r        半径
// mode     显示模式
void OLED_DrawCircle(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,uint16_t r,OLED_ENUM_T mode)
{
    if (oled_obj == NULL) {return;}
    int32_t a, b,num;
    a = 0;
    b = r;
    while(2 * b * b >= r * r)
    {
        OLED_DrawPoint(oled_obj,x + a, y - b,mode);
        OLED_DrawPoint(oled_obj,x - a, y - b,mode);
        OLED_DrawPoint(oled_obj,x - a, y + b,mode);
        OLED_DrawPoint(oled_obj,x + a, y + b,mode);

        OLED_DrawPoint(oled_obj,x + b, y + a,mode);
        OLED_DrawPoint(oled_obj,x + b, y - a,mode);
        OLED_DrawPoint(oled_obj,x - b, y - a,mode);
        OLED_DrawPoint(oled_obj,x - b, y + a,mode);

        a++;
        num = (a * a + b * b) - r*r;//计算画的点离圆心的距离
        if(num > 0)
        {
            b--;
            a--;
        }
    }
}


//在显存上画实心圆
// oled_obj OLED对象结构体
// x,y      圆心坐标
// r        半径
// mode     显示模式
void OLED_DrawFillCircle(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,uint16_t r,OLED_ENUM_T mode) {
    if (oled_obj == NULL) {return;}

    int x1, y1, r1;
    x1 = 0;
    y1 = r;
    r1 = 1 - r;
    while(x1 <= y1)
    {
        OLED_DrawLine(oled_obj,x + x1, y + y1, x - x1, y + y1, mode);
        OLED_DrawLine(oled_obj,x + x1, y - y1, x - x1, y - y1, mode);
        OLED_DrawLine(oled_obj,x + y1, y + x1, x - y1, y + x1, mode);
        OLED_DrawLine(oled_obj,x + y1, y - x1, x - y1, y - x1, mode);

        if(r1 < 0)
        {
            r1 += 2 * x1 + 3;
        }
        else
        {
            r1 += 2 * (x1 - y1) + 5;
            y1--;
        }
        x1++;
    }
}


//在显存上画方框
// oled_obj         OLED对象结构体
// xStart,yStart    起始坐标
// xEnd,yEnd        终止坐标
void OLED_DrawBlock(OLED_OBJ_T *oled_obj,uint16_t xStart, uint16_t yStart, uint16_t xEnd, uint16_t yEnd,OLED_ENUM_T mode) {
    if (oled_obj == NULL) {return;}
    if (yEnd < yStart) {
        uint16_t temp = yStart;
        yStart = yEnd;
        yEnd = temp;
    }
    OLED_DrawLine(oled_obj,xStart, yStart, xStart, yEnd,mode);//左界
    OLED_DrawLine(oled_obj,xEnd, yStart, xEnd, yEnd,mode);//右界
    OLED_DrawLine(oled_obj,xStart, yStart, xEnd, yStart,mode);//上界
    OLED_DrawLine(oled_obj,xStart, yEnd, xEnd, yEnd,mode);//下界
}


//在显存上画矩形
// oled_obj         OLED对象结构体
// xStart,yStart    起始坐标
// length,width     矩形长宽
// isFill           是否填充
// mode             显示模式
void OLED_DrawRect(OLED_OBJ_T *oled_obj,uint16_t xStart, uint16_t yStart, uint16_t length, uint16_t width, OLED_ENUM_T isFill,OLED_ENUM_T mode) {
    if (oled_obj == NULL) {return;}

    uint16_t rect_xs=xStart;
    uint16_t rect_ys=yStart;
    uint16_t rect_xe=xStart+length-1;
    uint16_t rect_ye=yStart+width-1;
    uint16_t x=0, y=0;

    OLED_DrawBlock(oled_obj,rect_xs, rect_ys, rect_xe, rect_ye,mode);//绘制边框

    if(isFill == OLED_RECT_FILL)//是否填充
    {
        for(x=xStart; x<(rect_xe+1); x++)
        {
            for(y=yStart; y<(rect_ye+1); y++){
                OLED_DrawPoint(oled_obj,x, y,mode);
            }
        }
    }
}


//在显存上画圆角矩形
// oled_obj         OLED对象结构体
// x0,y0            起始坐标
// xStart,yStart    起始坐标
// x1,y1            终止坐标
// R                圆角半径
// mode             显示模式
void OLED_DrawRoundRectangle(OLED_OBJ_T *oled_obj,uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1, uint16_t R,OLED_ENUM_T mode) {
    if (oled_obj == NULL) {return;}

    uint16_t L,W;

    R = (R > ((y1 - y0)/2)) ? ((y1 - y0)/2) : (R) ;

    L = x1 - x0 - 2 * R;
    W = y1 - y0 - 2 * R;
    OLED_DrawLine(oled_obj,x0 + R, y0,x0 + R + L,y0,mode);
    OLED_DrawLine(oled_obj,x0 + R, y1,x0 + R + L,y1,mode);
    OLED_DrawLine(oled_obj,x0, y0 + R,x0,y0 + R + W,mode);
    OLED_DrawLine(oled_obj,x1, y0 + R,x1,y0 + R + W,mode);

    if (R != 0){
        OLED_DrawPartCircle(oled_obj,x1 - R, y1 - R, R, OLED_QUADRANT_1,mode);
        OLED_DrawPartCircle(oled_obj,x0 + R, y1 - R, R, OLED_QUADRANT_2,mode);
        OLED_DrawPartCircle(oled_obj,x0 + R, y0 + R, R, OLED_QUADRANT_3,mode);
        OLED_DrawPartCircle(oled_obj,x1 - R, y0 + R, R, OLED_QUADRANT_4,mode);
    }
}


//在显存上画三角形
// oled_obj         OLED对象结构体
// x0~x2            三点横坐标
// y0~y2            三点纵坐标
// mode             显示模式
void DrawTriangle(OLED_OBJ_T *oled_obj,uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2,OLED_ENUM_T mode) {
    if (oled_obj == NULL) {return;}
    OLED_DrawLine(oled_obj,x0, y0, x1, y1,mode);
    OLED_DrawLine(oled_obj,x1,y1,x2,y2,mode);
    OLED_DrawLine(oled_obj,x2, y2, x0, y0,mode);
}


//在显存上放置图片
// oled_obj OLED对象结构体
// sizex,sizey   图片长宽
// BMP[]         图片数组
// mode          显示模式
void OLED_ShowPicture(OLED_OBJ_T *oled_obj,uint16_t x,uint16_t y,uint16_t sizex,uint16_t sizey,uint8_t BMP[],OLED_ENUM_T mode)
{
    uint16_t j=0;
    uint16_t i,n,temp,m;
    uint16_t x0=x,y0=y;
    sizey=sizey/8+((sizey%8)?1:0);
    for(n=0;n<sizey;n++)
    {
        for(i=0;i<sizex;i++)
        {
            temp=BMP[j];
            j++;
            for(m=0;m<8;m++)
            {
                if(temp&0x01)OLED_DrawPoint(oled_obj,x,y,mode);
                else OLED_DrawPoint(oled_obj,x,y,!mode);
                temp>>=1;
                y++;
            }
            x++;
            if((x-x0)==sizex)
            {
                x=x0;
                y0=y0+8;
            }
            y=y0;
        }
    }
}








#endif
