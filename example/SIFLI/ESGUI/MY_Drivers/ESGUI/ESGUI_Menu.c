//
// Created by E_LJF on 2026/6/4.
//

#include "ESGUI_Menu.h"
#include "string.h"
#if ESGUI_ENABLE_MENU_RUNTIME_ITEMS
#include <stdlib.h>   /* 运行时增删（动态菜单）：realloc */
#endif

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


/* ==================== 运行时条目增删 ====================
 * 由 ESGUI_ENABLE_MENU_RUNTIME_ITEMS 控制（0=整套剔除，静态条目系统不受影响）。
 * 动态菜单（item_auto_expand=1）支持容量自适应：
 *   增加/插入容量不足 → realloc 翻倍扩容；删除后容量 > 2×条目数 → 缩容。
 * 静态数组（item_auto_expand=0）绝不 realloc。
 */
#if ESGUI_ENABLE_MENU_RUNTIME_ITEMS

/**
 * @brief 条目结构变化后的统一收尾：通知页面重排布局
 * @param page      页面指针
 * @param old_focus 变化前的焦点索引
 * @param new_focus 变化后的焦点索引
 */
static void menu_page_relayout(ESGUI_MenuPage_T *page, eui_uint16_t old_focus, eui_uint16_t new_focus)
{
    if (page == ESGUI_NULL || page->vtbl == ESGUI_NULL) return;
    if (page->vtbl->on_relayout) {
        page->vtbl->on_relayout(page, old_focus, new_focus);
    }
}

/**
 * @brief 扩容条目数组（容量翻倍）
 * @param page 页面指针
 * @return true=扩容成功；false=未启用自动扩容 / realloc 失败 / 已达上限
 * @note  仅动态菜单（item_auto_expand=1）生效；新扩容区域清零。
 */
static bool menu_page_grow(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->items == ESGUI_NULL) return false;
    if (page->item_auto_expand == 0 || page->item_cap == 0) return false;   /* 静态数组/未启用 */
    eui_uint32_t new_cap = (eui_uint32_t)page->item_cap * 2u;
    if (new_cap > 0xFFFFu) new_cap = 0xFFFFu;                               /* item_cap 为 u16，封顶 */
    if (new_cap <= page->item_cap) return false;                            /* 已达上限 */
    ESGUI_MenuItem_T *p = (ESGUI_MenuItem_T *)ESGUI_REALLOC(page->items,
                            (size_t)new_cap * sizeof(ESGUI_MenuItem_T));
    if (p == ESGUI_NULL) return false;                                      /* 失败保持原状态 */
    memset(&p[page->item_cap], 0, ((size_t)new_cap - page->item_cap) * sizeof(ESGUI_MenuItem_T));
    page->items = p;
    page->item_cap = (eui_uint16_t)new_cap;
    return true;
}

/**
 * @brief 缩容条目数组（容量 > 2×条目数 时缩到当前条目数，保底 4 条）
 * @param page 页面指针
 * @note  仅动态菜单（item_auto_expand=1）生效；realloc 失败时保持原容量，不影响功能。
 */
static void menu_page_shrink(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->items == ESGUI_NULL) return;
    if (page->item_auto_expand == 0) return;
    if (page->item_cap <= 4) return;                                        /* 保底容量，避免缩了又扩的抖动 */
    if (page->item_cap <= (eui_uint16_t)(page->item_num * 2u)) return;      /* 未超 2 倍，不缩 */
    eui_uint16_t new_cap = (page->item_num < 4) ? 4 : page->item_num;
    ESGUI_MenuItem_T *p = (ESGUI_MenuItem_T *)ESGUI_REALLOC(page->items,
                            (size_t)new_cap * sizeof(ESGUI_MenuItem_T));
    if (p == ESGUI_NULL) return;                                            /* 失败保持原容量 */
    page->items = p;
    page->item_cap = new_cap;
}

bool ESGUI_MenuPageAddItem(ESGUI_MenuPage_T *page, const ESGUI_MenuItem_T *item)
{
    if (page == ESGUI_NULL || item == ESGUI_NULL || page->items == ESGUI_NULL) return false;
    if (page->item_num >= page->item_cap) {
        if (!menu_page_grow(page)) return false;                            /* 容量不足：静态返回 false，动态自动扩容 */
    }
    page->items[page->item_num] = *item;
    page->item_num++;
    menu_page_relayout(page, page->focus_idx, page->focus_idx);
    return true;
}

bool ESGUI_MenuPageInsertItem(ESGUI_MenuPage_T *page, eui_uint16_t idx, const ESGUI_MenuItem_T *item)
{
    if (page == ESGUI_NULL || item == ESGUI_NULL || page->items == ESGUI_NULL) return false;
    if (idx > page->item_num) idx = page->item_num;                         /* 越界视为尾部插入 */
    if (page->item_num >= page->item_cap) {
        if (!menu_page_grow(page)) return false;                            /* 容量不足：静态返回 false，动态自动扩容 */
    }
    eui_uint16_t old_focus = page->focus_idx;
    memmove(&page->items[idx + 1], &page->items[idx],
            (size_t)(page->item_num - idx) * sizeof(ESGUI_MenuItem_T));
    page->items[idx] = *item;
    page->item_num++;
    /* 插入位置在焦点前/焦点处：焦点后移一位，保持同一逻辑条目被选中 */
    if (idx <= old_focus) page->focus_idx = old_focus + 1;
    menu_page_relayout(page, old_focus, page->focus_idx);
    return true;
}

bool ESGUI_MenuPageRemoveItem(ESGUI_MenuPage_T *page, eui_uint16_t idx)
{
    if (page == ESGUI_NULL || page->items == ESGUI_NULL) return false;
    if (page->item_num <= 1 || idx >= page->item_num) return false;         /* 至少保留 1 条，避免空菜单 */
    eui_uint16_t old_focus = page->focus_idx;
    if (idx < old_focus) {
        page->focus_idx = old_focus - 1;                                    /* 删除项在焦点前：焦点顺移 */
    } else if (idx == old_focus) {
        /* 删除焦点项：焦点落在同下标的后继条目上；若删除的是最后一条则回退 */
        page->focus_idx = old_focus;
        if (page->focus_idx >= page->item_num - 1) {
            page->focus_idx = page->item_num - 2;
        }
    }
    /* else：删除项在焦点后，焦点不变 */
    memmove(&page->items[idx], &page->items[idx + 1],
            (size_t)(page->item_num - 1 - idx) * sizeof(ESGUI_MenuItem_T));
    page->item_num--;
    menu_page_shrink(page);                                                 /* 动态菜单：容量超 2 倍时缩容 */
    menu_page_relayout(page, old_focus, page->focus_idx);
    return true;
}

#endif /* ESGUI_ENABLE_MENU_RUNTIME_ITEMS */
