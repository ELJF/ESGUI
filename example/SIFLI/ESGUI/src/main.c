#include "bf0_pin_const.h"
#include "rtthread.h"
#include "bf0_hal.h"
#include "oled_rtt.h"
#include "drv_gpio.h"
#include "ESGUI.h"
#include "ESGUI_UseCanvas.h"
#include "text_page.h"
#include "mem_section.h"
#include "ec11.h"


//OLED屏幕高度，屏幕宽度默认128像素
#define oled_h 128

//EC11编码器引脚编号获取
#define EC11_A_PIN   GET_PIN(1, 39)   
#define EC11_B_PIN   GET_PIN(1, 37)   
#define EC11_KEY_PIN GET_PIN(1, 38)   

//思澈SDK必须手动指定一下IO
#define OLED_MOSI_PINMUX()  HAL_PIN_Set(PAD_PA24, SPI1_DIO,  PIN_PULLDOWN, 1);  // MOSI
#define OLED_SCL_PINMUX()   HAL_PIN_Set(PAD_PA28, SPI1_CLK,  PIN_PULLDOWN, 1);  // CLK

//注意：如果EC11 A PIN 和 B PIN 已经有了上拉电阻，则下面的配置不要启用io上拉，不然编码器会没反应
#define EC11_A_PINMUX() HAL_PIN_Set(PAD_PA39, GPIO_A39, PIN_NOPULL, 1)
#define EC11_B_PINMUX() HAL_PIN_Set(PAD_PA37, GPIO_A37, PIN_NOPULL, 1);
#define EC11_KEY_PINMUX() HAL_PIN_Set(PAD_PA38, GPIO_A38, PIN_PULLUP, 1);


//从外挂RAM中创建一个数组作为OLED显存
L2_NON_RET_BSS_SECT_BEGIN(oled_famebuff)
L2_NON_RET_BSS_SECT(oled_famebuff, ALIGN(64) uint8_t oled_buff[128*(oled_h / 8)]);
L2_NON_RET_BSS_SECT_END



EC11_OBJ_T ec11;



OLED_T oled1;
void ESGUI_UseCanvasFlush(int x0,int y0,int x1,int y1,const uint8_t* buff,void* user) {
    OLED_Refresh(&oled1,oled_buff,sizeof(oled_buff));
}


ESGUI_T ui;


static void ESGUI_KeyThread(void* arg) {
    uint32_t now_ms = 0;
    while (1) {
        now_ms = HAL_GetTick();
        EC11_KeyScan(&ec11);

        switch (EC11_GetState(&ec11)) {
            case EC11_UP:
                ESGUI_FeedKey(&ui,EVT_KEY_UP,now_ms);
                break;

            case EC11_DOWN:
                ESGUI_FeedKey(&ui,EVT_KEY_DOWN,now_ms);
                break;

            case EC11_STATE_NULL:
                ESGUI_FeedKey(&ui,EVT_NONE,now_ms);
                break;

            case EC11_KEY_SHORT_PRESS:
                ESGUI_FeedKey(&ui,EVT_CLICKED,now_ms);
                break;

            case EC11_KEY_LONG_PRESS:
                ESGUI_FeedKey(&ui,EVT_KEY_BACK,now_ms);
                break;

            default:
                ESGUI_FeedKey(&ui,EVT_NONE,now_ms);
                break;
        }
        rt_thread_mdelay(10);
    }
}


/**
 * @brief  Main program
 * @param  None
 * @retval 0 if success, otherwise failure number
 */
int main(void)
{
    /* Output a message on console using printf function */
    rt_kprintf("Hello world!\n");




    // SPI1 用于 OLED（3线SPI，只发不收）
    OLED_MOSI_PINMUX();
    OLED_SCL_PINMUX();
    oled_init(&oled1,
    "oled1",
    128,
    oled_h,
    "spi1",
    GET_PIN(1,29),
    GET_PIN(1,25),
    GET_PIN(1,36));



    EC11_A_PINMUX();
    EC11_B_PINMUX();
    EC11_KEY_PINMUX();
    EC11_Init(&ec11,
               EC11_A_PIN,
               EC11_B_PIN,
               EC11_KEY_PIN,
               EC11_DIR_ANTICLOCKWISE);


    Canvas c;
    CanvasStripIter c_it;
    

    //初始化ESGUI框架
    ESGUI_Init(&ui,&text_page,ESGUI_CanvasRefresh_CB,ESGUI_AnimTick_CB);
    //绑定绘图库为默认的Canvas绘图库
    ESGUI_BindCanvas(&ui,&c,&c_it,oled_buff,128,oled_h,oled_h);
    eui_test_page_init();

    rt_thread_t esgui_key_thread_handle = rt_thread_create("ESGUI_Key",ESGUI_KeyThread,NULL,2048,12,20);
    rt_thread_startup(esgui_key_thread_handle);
    uint32_t now_ms = 0;

    /* Infinite loop */
    while (1)
    {
        now_ms = HAL_GetTick();
        ESGUI_Tick(&ui,now_ms);
        rt_thread_mdelay(10);
    }
    return 0;
}

