//
// Created by E_LJF on 2026/6/9.
// Flash-optimized: removed float APIs, only permille remains
//

#ifndef ESGUI_ESGUI_WIDGET_H
#define ESGUI_ESGUI_WIDGET_H

#include "ESGUI_BSP_Canvas.h"

#define ESGUI_WIDGET_PROGBAR_UP    0
#define ESGUI_WIDGET_PROGBAR_DOWN  1
#define ESGUI_WIDGET_PROGBAR_LEFT  2
#define ESGUI_WIDGET_PROGBAR_RIGHT 3

#define ESGUI_WIDGET_DEFAULT_MARK '\x03'

/* 全屏进度条（千分比 0~1000，零浮点） */
void ESGUI_WidgetProgrssBarPermille(Canvas *c, int x, int y, uint8_t w, uint16_t permille, uint8_t direction);

/* 可变长度进度条（千分比 0~1000，零浮点） */
void ESGUI_WidgetProgrssBarChangeLenPermille(Canvas *c, int x, int y, uint8_t w, uint16_t len, uint16_t permille, uint8_t direction);

void ESGUI_WidgetTextFocusBox(Canvas *c,int x,int y,uint8_t h,uint8_t len);
void ESGUI_WidgetCheckBoxSquare(Canvas *c,int x,int y,uint8_t h,uint8_t len,bool state);
void ESGUI_WidgetCheckBoxRound(Canvas *c,int x,int y,uint8_t r,bool state);
bool ESGUI_WidgetCheckMarker(const char *raw,char marker,uint16_t *out_len,char *out_ch);
void ESGUI_WidgetBmpFocusBox(Canvas *c,int x,int y,uint16_t w,uint16_t h);
void ESGUI_WidgetBmpFocusBoxAnim(Canvas *c, int cx, int cy, uint16_t box_w, uint16_t box_h);

#endif //ESGUI_ESGUI_WIDGET_H