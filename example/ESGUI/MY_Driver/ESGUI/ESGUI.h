//
// Created by E_LJF on 2026/5/28.
//

#ifndef ESGUI_ESGUI_H
#define ESGUI_ESGUI_H

#include "ESGUI_Menu.h"
#include "ESGUI_DefaultVtbConfig.h"

typedef struct esgui ESGUI_T;


typedef enum {
    ESGUI_DRAW_PAGE,
    ESGUI_DRAW_POPWINDOW,
}ESGUI_DRAW_TYPE_ENU;


typedef void (*refresh)(struct esgui *ui,void *page,void *window);
typedef void (*anim_tick)(struct esgui *ui,uint32_t tick);


typedef struct esgui {
    void *draw_data;

    refresh refresh_cb;  // 刷新回调

    anim_tick anim_tick_cb;    //动画刷新回调

    ESGUI_MenuCtrl_T menu_ctrl;
}ESGUI_T;


//初始化函数
void ESGUI_Init(ESGUI_T *ui,
                ESGUI_MenuPage_T *first_page,
                refresh refresh_cb,
                anim_tick anim_tick_cb
                );

/* 外部输入入口：在主循环或按键中断里调用 */
void ESGUI_FeedKey(ESGUI_T *ui, ESGUI_EventCode_t key,uint32_t now_ms);

/* 主循环调用，负责绘制和动画更新 */
void ESGUI_Tick(ESGUI_T *ui, uint32_t now_ms);

#endif //ESGUI_ESGUI_H
