//
// Created by E_LJF on 2026/8/12.
//

#include "ESGUI_Task.h"
#include "ESGUI.h"
#include "ESGUI_BSP_Canvas.h"
#include "text_page.h"
#include "ESGUI_UseCanvas.h"
#include "EC11.h"
#include "oled.h"
#include "freertos/FreeRTOS.h"

#define OLED_SCL 53
#define OLED_SDA 52
#define OLED_RES 24
#define OLED_DC  25
#define OLED_CS  31

#define OLED_W 128
#define OLED_H 128


#define EC11_A 20
#define EC11_B 19
#define EC11_KEY 18


uint32_t now_ms = 0;
uint32_t now_ms_key = 0;
OLED_T oled1;
Canvas c;
CanvasStripIter c_it;
ESGUI_T ui;
EC11_T ec11;
EXT_RAM_BSS_ATTR uint8_t oled_gram[OLED_W * (OLED_H / 8)];

void ESGUI_UseCanvasFlush(int x0,int y0,int x1,int y1,const uint8_t* buff,void* user) {
    OLED_Refresh(&oled1,oled_gram,sizeof(oled_gram));
}



static void ESGUI_KeyTask(void *arg) {
    while (1) {
        ec11_key_scan(&ec11);
        switch (ec11_get_state(&ec11)) {
            case EC11_UP:
                ESGUI_FeedKey(&ui,EVT_KEY_UP,now_ms_key);
                break;

            case EC11_DOWN:
                ESGUI_FeedKey(&ui,EVT_KEY_DOWN,now_ms_key);
                break;

            case EC11_STATE_NULL:
                ESGUI_FeedKey(&ui,EVT_NONE,now_ms_key);
                break;

            case EC11_KEY_SHORT_PRESS:
                ESGUI_FeedKey(&ui,EVT_CLICKED,now_ms_key);
                break;

            case EC11_KEY_LONG_PRESS:
                ESGUI_FeedKey(&ui,EVT_KEY_BACK,now_ms_key);
                break;

            default:
                ESGUI_FeedKey(&ui,EVT_NONE,now_ms_key);
                break;
        }
        now_ms_key += 10;
        vTaskDelay(pdMS_TO_TICKS(10));
    }
}




static void ESGUI_LoopTask(void *arg) {
    while (1) {
        ESGUI_Tick(&ui,now_ms);
        now_ms += 10;
        vTaskDelay(pdMS_TO_TICKS(10));
    }
}


void ESGUI_Task_Init() {
    oled_init(&oled1,
       OLED_W,
       OLED_H,
       SPI2_HOST,
       OLED_SCL,
       OLED_SDA,
       OLED_RES,
       OLED_DC,
       OLED_CS);
    OLED_Refresh(&oled1,oled_gram,sizeof(oled_gram));

    eui_test_page_init();
    //初始化ESGUI框架
    ESGUI_Init(&ui,&text_page,ESGUI_CanvasRefresh_CB,ESGUI_AnimTick_CB);
    //绑定绘图库为默认的Canvas绘图库
    ESGUI_BindCanvas(&ui,&c,&c_it,oled_gram,OLED_W,OLED_H,OLED_H);

    ec11_init(&ec11,EC11_A,EC11_B,EC11_KEY,EC11_DIR_CLOCKWISE);

    xTaskCreatePinnedToCore(ESGUI_LoopTask,"ESGUI_LOOP",4096,NULL,4,NULL,0);
    xTaskCreatePinnedToCore(ESGUI_KeyTask,"ESGUI_KEY",2048,NULL,5,NULL,0);
}
