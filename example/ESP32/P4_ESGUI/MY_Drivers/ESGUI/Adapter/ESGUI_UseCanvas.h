//
// Created by E_LJF on 2026/6/9.
//

#ifndef ESGUI_ESGUI_USECANVAS_H
#define ESGUI_ESGUI_USECANVAS_H

#include "../ESGUI.h"
#include "ESGUI_BSP_Canvas.h"


void ESGUI_UseCanvasFlush(int x0,int y0,int x1,int y1,const eui_uint8_t* buff,void* user);
void ESGUI_CanvasRefresh_CB(ESGUI_T *ui,void *page,void *window);
void ESGUI_AnimTick_CB(ESGUI_T *ui,eui_uint32_t tick);

void ESGUI_BindCanvas(ESGUI_T *ui,
                        Canvas *canva,
                        CanvasStripIter *canvas_it,
                        eui_uint8_t *buff,
                        eui_uint16_t screen_w,
                        eui_uint16_t screen_h,
                        eui_uint16_t strip_h);

#endif //ESGUI_ESGUI_USECANVAS_H
