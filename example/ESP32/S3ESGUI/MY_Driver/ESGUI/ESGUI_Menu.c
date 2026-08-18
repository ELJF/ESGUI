//
// Created by E_LJF on 2026/6/4.
//

#include "ESGUI_Menu.h"
#include "string.h"

/**
 * @brief 初始化菜单控制器
 * @param emc 菜单控制器实例指针
 * @return 无
 *
 * 作用：将控制器结构体清零，设置默认按键重复延迟为 300ms，
 * 并使能菜单运行标志。
 */
void ESGUI_MenuCtrlInit(ESGUI_MenuCtrl_T *emc) {
    if (emc == ESGUI_NULL) return;
    memset(emc,0,sizeof(*emc));
    emc->repeat_delay_ms = 300;
    emc->running_en = 1;
    emc->anim_running = 0;
}

/**
 * @brief 将新页面压入菜单栈
 * @param emc  菜单控制器实例指针
 * @param page 待压入的页面指针
 * @return 无
 *
 * 说明：仅当当前栈深度小于 ESGUI_MAX_MENU_DEPTH 且菜单处于运行状态时
 * 才执行压栈操作。压栈后自动标记需要刷新。
 */
void ESGUI_MenuCtrlPushPage(ESGUI_MenuCtrl_T *emc, ESGUI_MenuPage_T *page) {
    if (emc == ESGUI_NULL || page == ESGUI_NULL) return;

    if ((emc->menu_depth < ESGUI_MAX_MENU_DEPTH) && (emc->running_en == 1)) {
        emc->page_stack[emc->menu_depth] = page;
        emc->menu_depth++;
        emc->need_refresh = 1;
    }
}

/**
 * @brief 弹出栈顶页面（返回上一级）
 * @param emc 菜单控制器实例指针
 * @return 无
 *
 * 说明：仅当栈深度大于 1 时执行（保留至少一个页面）。
 * 出栈前调用当前页面的 on_destroy 虚函数进行资源释放。
 */
void ESGUI_MenuCtrlPopPage(ESGUI_MenuCtrl_T *emc) {
    if (emc == ESGUI_NULL || emc->running_en == 0) return;

    if (emc->menu_depth > 1) {
        ESGUI_MenuPage_T *page = emc->page_stack[emc->menu_depth - 1];  //暂存当前页面指针

        if (page->vtbl->on_destroy){
            page->vtbl->on_destroy(page);
        }  //调用析构

        emc->menu_depth --;
        emc->need_refresh = 1;
    }
}

/**
 * @brief 显示模态弹窗
 * @param emc   菜单控制器实例指针
 * @param popup 弹窗页面指针
 * @return 无
 *
 * 说明：弹窗显示后，输入事件优先路由到弹窗处理，形成模态覆盖效果。
 */
void ESGUI_MenuCtrlShowPopWindow(ESGUI_MenuCtrl_T *emc, ESGUI_PopWindow_T *popup) {
    if (emc == ESGUI_NULL || popup == ESGUI_NULL || emc->running_en == 0) return;

    emc->pop_window = popup;
    emc->pop_window_en = 1;
    emc->need_refresh = 1;
}

/**
 * @brief 关闭当前模态弹窗
 * @param emc 菜单控制器实例指针
 * @return 无
 *
 * 说明：清除弹窗指针并禁用弹窗标志，恢复页面正常输入响应。
 */
void ESGUI_MenuCtrlClosePopWindow(ESGUI_MenuCtrl_T *emc) {
    if (emc == ESGUI_NULL || emc->running_en == 0) return;

    if (emc->pop_window && emc->pop_window->vtbl->on_destroy) {
        emc->pop_window->vtbl->on_destroy((ESGUI_MenuPage_T*)emc->pop_window);
    }

    emc->pop_window = ESGUI_NULL;
    emc->pop_window_en = 0;
    emc->need_refresh = 1;
}

/**
 * @brief 执行页面返回的动作指令
 * @param emc 菜单控制器实例指针
 * @param act 动作指令结构体指针
 * @return 无
 *
 * 说明：根据 act->act 枚举值分发到对应的栈操作（压栈/出栈）、
 * 弹窗控制、刷新标记或退出应用等动作。
 */
void ESGUI_MenuCtrlHandleAction(ESGUI_MenuCtrl_T *emc, ESGUI_MenuAction_T *act)
{
    if (emc == ESGUI_NULL || act == ESGUI_NULL || emc->running_en == 0) return;

    switch(act->act) {
        case ACT_NONE:
            break;

        case ACT_PUSH_PAGE:
            if(act->param) ESGUI_MenuCtrlPushPage(emc, (ESGUI_MenuPage_T*)act->param);
            break;

        case ACT_POP_PAGE:
            /* 新增：栈底保护，防止单页面时误触发延迟销毁重建 */
            if (emc->menu_depth <= 1) {
                break;
            }
            if (emc->page_stack[emc->menu_depth-1]->vtbl->on_page_chenge) {
                emc->page_stack[emc->menu_depth-1]->vtbl->on_page_chenge(emc->page_stack[emc->menu_depth-1], act);
                ESGUI_MenuCtrlPreparePopPage(emc);
            }
            else{
                ESGUI_MenuCtrlPopPage(emc);
            }
            break;

        case ACT_SHOW_POPUP:
            if(act->param) {
                ESGUI_MenuCtrlShowPopWindow(emc, (ESGUI_PopWindow_T*)act->param);
            }
            break;

        case ACT_CLOSE_POPUP:
            if (emc->pop_window == ESGUI_NULL) break;
            if (emc->pop_window->vtbl->on_page_chenge) {
                emc->pop_window->vtbl->on_page_chenge((ESGUI_MenuPage_T*)emc->pop_window, act);
                ESGUI_MenuCtrlPreparePopPage(emc);
            }
            else {
                ESGUI_MenuCtrlClosePopWindow(emc);
            }
            break;

        case ACT_REFRESH:
            emc->need_refresh = 1;
            break;

        case ACT_EXIT_APP:
            emc->running_en = 0;  // 主循环根据这个退出
            break;

        default: break;
    }
}


/**
 * @brief 准备弹出页面（延迟销毁，页面保持存活直到动画完成）
 * @param emc 菜单控制器实例指针
 * @return true=成功进入延迟状态；false=条件不满足
 */
bool ESGUI_MenuCtrlPreparePopPage(ESGUI_MenuCtrl_T *emc) {
    if (emc == ESGUI_NULL || emc->running_en == 0) return false;
    if (emc->menu_depth == 0) return false;
    if (emc->pending_pop) return false;  // 已有待处理动作，防止重复

    emc->pending_pop = 1;
    emc->need_refresh = 1;

    if (emc->pop_window_en && emc->pop_window) {
        emc->pending_destroy_page = (ESGUI_MenuPage_T*)emc->pop_window;
        return true;
    }

    emc->pending_destroy_page = emc->page_stack[emc->menu_depth - 1];
    return true;
}

/**
 * @brief 执行待处理的出栈操作（动画完成后调用）
 * @param emc 菜单控制器实例指针
 */
void ESGUI_MenuCtrlExecPendingPop(ESGUI_MenuCtrl_T *emc) {
    if (emc == ESGUI_NULL || !emc->pending_pop) return;

    ESGUI_MenuPage_T *page = emc->pending_destroy_page;
    bool was_popup = (emc->pop_window_en && emc->pop_window &&
                      (ESGUI_MenuPage_T*)emc->pop_window == page);

    if (page && page->vtbl && page->vtbl->on_destroy) {
        page->vtbl->on_destroy(page);
    }

    if (emc->pop_window_en && emc->pop_window) {
        ESGUI_MenuCtrlClosePopWindow(emc);
    }
    else {
        ESGUI_MenuCtrlPopPage(emc);
    }

    if (!was_popup && emc->menu_depth > 0) {
        ESGUI_MenuPage_T *new_top = emc->page_stack[emc->menu_depth - 1];
        if (new_top && new_top->vtbl && new_top->vtbl->on_focus_change) {
            new_top->vtbl->on_focus_change(new_top, new_top->focus_idx, new_top->focus_idx);
        }
    }

    emc->pending_pop = 0;
    emc->pending_done = 0;
}
