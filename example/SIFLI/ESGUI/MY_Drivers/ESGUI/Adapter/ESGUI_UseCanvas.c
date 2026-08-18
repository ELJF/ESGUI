//
// Created by E_LJF on 2026/6/9.
//

#include "ESGUI_UseCanvas.h"
#include "../ESGUI_Anim.h"
#include "../ESGUI_Menu.h"

/**
 * @brief 条带刷新回调（弱定义）
 * @param x0   刷新区域左上角 X 坐标
 * @param y0   刷新区域左上角 Y 坐标
 * @param x1   刷新区域右下角 X 坐标
 * @param y1   刷新区域右下角 Y 坐标
 * @param buff 像素数据缓冲区指针
 * @param user 用户自定义参数
 * @return 无
 *
 * 说明：此函数为 __WEAK 弱定义，用户必须在其他地方提供具体实现，
 * 用于将 canvas 计算好的条带数据发送到物理屏幕。
 */
__WEAK void ESGUI_UseCanvasFlush(int x0,int y0,int x1,int y1,const eui_uint8_t* buff,void* user) {
}

/**
 * @brief 画布刷新回调，供 ESGUI 主循环调用
 * @param ui   UI 系统指针
 * @param page 当前待绘制的页面或弹窗指针
 * @return 无
 *
 * 说明：遍历所有条带（strip），逐条清零、压入裁剪区、调用页面绘制函数、
 * 弹出裁剪区，最后通过 ESGUI_UseCanvasFlush 送屏。实现分块刷新以降低内存占用。
 */
void ESGUI_CanvasRefresh_CB(ESGUI_T *ui,void *page,void *window) {
    if (ui == ESGUI_NULL || page == ESGUI_NULL)return;

    CanvasStripIter *canvas_it = (CanvasStripIter*)ui->draw_ctx;

    canvas_strip_iter_clean(canvas_it);
    while (canvas_strip_iter_next(canvas_it)) {
        /* 1. 绑定当前条带并清零 */
        canvas_strip_iter_bind(canvas_it);

        /* 2. 压入精确裁剪区，防止画出当前条带 */
        Area draw_clip = {0, canvas_it->y1, canvas_it->canvas->width - 1, canvas_it->y2};
        canvas_clip_push(canvas_it->canvas, &draw_clip);

        /* 3. 在外部任意地方绘制！不需要回调 */

        ESGUI_MenuPage_T *menu_page = (ESGUI_MenuPage_T*)page;
        menu_page->vtbl->on_draw(menu_page);

        if (window != ESGUI_NULL) {
            ((ESGUI_PopWindow_T*)window)->vtbl->on_draw(window);
        }

        /* 覆盖层：叠加在页面与弹窗之上（列表顺序即 z-order，先加的在底层） */
        for (eui_uint8_t i = 0; i < ui->overlay_count; i++) {
            ESGUI_Overlay_T *ov = ui->overlays[i];
            if (ov == ESGUI_NULL || !ov->visible || ov->on_draw == ESGUI_NULL) continue;
            ov->on_draw(ov);
        }

        /* 4. 弹出裁剪区 */
        canvas_clip_pop(canvas_it->canvas);

        /* 5. 送屏当前条带 */
        canvas_strip_iter_flush(canvas_it, ESGUI_UseCanvasFlush, ESGUI_NULL);
    }
}



/**
 * @brief 动画心跳回调，供 ESGUI 主循环调用
 * @param ui   UI 系统指针
 * @param tick 当前系统时间戳（ms）
 * @return 无
 *
 * 说明：驱动动画引擎更新一帧；若有动画在运行，自动标记需要刷新，
 * 确保下一 Tick 会重绘画面。
 */
void ESGUI_AnimTick_CB(ESGUI_T *ui, eui_uint32_t tick) {
    /* 必须先更新动画，再查询状态，否则 pending_done 会滞后一帧 */
    anim_update(tick);

    if(anim_is_running()) {

        ui->menu_ctrl.anim_running = 1;
        ui->menu_ctrl.need_refresh = 1;

        if (anim_all_must_complete_done()) {
            ui->menu_ctrl.pending_done = 1;
            anim_must_complete_reset();
        }
        else {
            ui->menu_ctrl.pending_done = 0;
        }
    }
    else {
        ui->menu_ctrl.anim_running = 0;
        ui->menu_ctrl.pending_done = 1;
        anim_must_complete_reset();
    }
}



/**
 * @brief 绑定画布到 UI 系统
 * @param ui       UI 系统指针
 * @param canva    画布实例指针
 * @param canvas_it 条带迭代器指针
 * @param buff     画布显存缓冲区指针
 * @param screen_w 屏幕宽度（像素）
 * @param screen_h 屏幕高度（像素）
 * @param strip_h  每条带高度（像素）
 * @return 无
 *
 * 说明：初始化画布与条带迭代器，初始化动画系统，并将画布迭代器绑定到 ui->draw_data。
 */
void ESGUI_BindCanvas(ESGUI_T *ui,
                        Canvas *canva,
                        CanvasStripIter *canvas_it,
                        eui_uint8_t *buff,
                        eui_uint16_t screen_w,
                        eui_uint16_t screen_h,
                        eui_uint16_t strip_h){

    canvas_it->canvas = canva;
    canvas_init(canvas_it->canvas,buff,screen_w,screen_h);
    canvas_strip_iter_init(canvas_it,canvas_it->canvas,strip_h);
    anim_init();

    ui->draw_ctx = canvas_it;
}