//
// Created by E_LJF on 2026/5/28.
//

#include "ESGUI.h"
#include "string.h"




void ESGUI_Init(ESGUI_T *ui,
                ESGUI_MenuPage_T *first_page,
                refresh refresh_cb,
                anim_tick anim_tick_cb
                )
{
    if (ui == ESGUI_NULL || first_page == ESGUI_NULL) return;

    memset(ui, 0, sizeof(*ui));

    ui->menu_ctrl.need_refresh = 1;
    ui->refresh_cb = refresh_cb;
    ui->anim_tick_cb = anim_tick_cb;

    ESGUI_MenuCtrlInit(&ui->menu_ctrl);

    //第一页入栈
    ESGUI_MenuCtrlPushPage(&ui->menu_ctrl,first_page);
}




void ESGUI_FeedKey(ESGUI_T *ui, ESGUI_EventCode_t key, uint32_t now_ms) {
    if (ui == ESGUI_NULL) return;

    /* 新增：Push/Pop 过渡动画期间屏蔽按键，防止重复触发 */
    if (ui->menu_ctrl.pending_push || ui->menu_ctrl.pending_pop) return;

    /* 消抖与长按加速（保持不变） */
    if (key == ui->menu_ctrl.last_event && (now_ms - ui->menu_ctrl.last_key_tick) < ui->menu_ctrl.repeat_delay_ms) return;

    ui->menu_ctrl.last_event = key;
    ui->menu_ctrl.last_key_tick = now_ms;
    if (ui->menu_ctrl.repeat_delay_ms > 50) ui->menu_ctrl.repeat_delay_ms -= 40;

    ESGUI_MenuAction_T act = {ACT_NONE, ESGUI_NULL};

    /* 1. 收集动作：发给弹窗或栈顶页面 */
    if (ui->menu_ctrl.pop_window_en && ui->menu_ctrl.pop_window) {
        if (ui->menu_ctrl.pop_window->vtbl->on_input) {
            act = ui->menu_ctrl.pop_window->vtbl->on_input((ESGUI_MenuPage_T*)ui->menu_ctrl.pop_window, key);
        }
    } else if (ui->menu_ctrl.menu_depth > 0) {
        if (ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1]->vtbl->on_input) {
            act = ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1]->vtbl->on_input(
                ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1], key);
        }
    }

    /* 2. 执行动作 */
    if (act.act != ACT_NONE) {
        /* 新增：Push 页面时先让旧页面执行退出动画，再延迟压栈 */
        if (act.act == ACT_PUSH_PAGE && act.param != ESGUI_NULL && ui->menu_ctrl.menu_depth > 0) {
            ESGUI_MenuPage_T *old_top = ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1];
            if (old_top && old_top->vtbl && old_top->vtbl->on_page_chenge) {
                ESGUI_MenuAction_T exit_act = {ACT_POP_PAGE, ESGUI_NULL};
                old_top->vtbl->on_page_chenge(old_top, &exit_act);  /* 启动旧页面退出动画 */
            }
            ui->menu_ctrl.pending_push = 1;
            ui->menu_ctrl.pending_push_page = (ESGUI_MenuPage_T*)act.param;
            ui->menu_ctrl.need_refresh = 1;
        } else {
            ESGUI_MenuCtrlHandleAction(&ui->menu_ctrl, &act);
        }
    } else {
        ui->menu_ctrl.repeat_delay_ms = 300;
    }
}



void ESGUI_Tick(ESGUI_T *ui, uint32_t now_ms) {
    if (ui == ESGUI_NULL) return;

    /* 1. 先更新动画 */
    if (ui->menu_ctrl.menu_depth > 0 && ui->anim_tick_cb) {
        ui->anim_tick_cb(ui, now_ms);
    }

    /* 2. 动画完成后立即切换页面 */
    if (ui->menu_ctrl.pending_push && ui->menu_ctrl.pending_done) {
        ESGUI_MenuAction_T push_act = {ACT_PUSH_PAGE, ui->menu_ctrl.pending_push_page};
        ESGUI_MenuCtrlHandleAction(&ui->menu_ctrl, &push_act);
        ui->menu_ctrl.pending_push = 0;
        ui->menu_ctrl.pending_push_page = ESGUI_NULL;
        ui->menu_ctrl.pending_done = 0;
    }
    else if (ui->menu_ctrl.pending_pop && ui->menu_ctrl.pending_done) {
        ESGUI_MenuCtrlExecPendingPop(&ui->menu_ctrl);
    }

    /* 3. 判断是否需要绘制 */
    uint8_t need = ui->menu_ctrl.need_refresh;
    if (ui->menu_ctrl.menu_depth > 0) {
        if (ui->menu_ctrl.anim_running) {
            need = 1;
        }
    }
    if (ui->menu_ctrl.pending_push || ui->menu_ctrl.pending_pop) {
        need = 1;
    }
    if (!need) {
        ui->menu_ctrl.need_refresh = 0;
        return;
    }

    /* 4. 绘制当前栈顶页面（恢复完整逻辑） */
    if (ui->menu_ctrl.menu_depth > 0 && ui->refresh_cb) {
        ESGUI_MenuPage_T *top = ui->menu_ctrl.page_stack[ui->menu_ctrl.menu_depth - 1];
        ESGUI_MenuAction_T act = {ACT_NONE, ESGUI_NULL};

        /* 绘制弹窗（模态覆盖） */
        if (ui->menu_ctrl.pop_window_en && ui->menu_ctrl.pop_window) {
            if (ui->menu_ctrl.pop_window->render_ctx == ESGUI_NULL && ui->menu_ctrl.pop_window->vtbl->on_create) {
                ui->menu_ctrl.pop_window->render_ctx = ui->draw_data;
                ui->menu_ctrl.pop_window->vtbl->on_create((ESGUI_MenuPage_T*)ui->menu_ctrl.pop_window);

                act.act = ACT_SHOW_POPUP;
                act.param = ui->menu_ctrl.pop_window;
                if (ui->menu_ctrl.pop_window->vtbl->on_page_chenge) {
                    ui->menu_ctrl.pop_window->vtbl->on_page_chenge((ESGUI_MenuPage_T*)ui->menu_ctrl.pop_window, &act);
                }
            } else {
                ui->menu_ctrl.pop_window->render_ctx = ui->draw_data;
            }
            ui->refresh_cb(ui, top, ui->menu_ctrl.pop_window);
        } else {
            /* 页面首次渲染时 render_ctx 为 ESGUI_NULL，注入后调用 on_create */
            if (top->render_ctx == ESGUI_NULL && top->vtbl->on_create) {
                top->render_ctx = ui->draw_data;
                top->vtbl->on_create(top);

                act.act = ACT_PUSH_PAGE;
                act.param = top;
                if (top->vtbl->on_page_chenge) {
                    top->vtbl->on_page_chenge(top, &act);
                }
            } else {
                top->render_ctx = ui->draw_data;
            }
            ui->refresh_cb(ui, top, ESGUI_NULL);
        }
    }

    ui->menu_ctrl.need_refresh = 0;
}