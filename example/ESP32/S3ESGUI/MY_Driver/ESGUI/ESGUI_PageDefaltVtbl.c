//
// Created by E_LJF on 2026/6/6.
// Flash-optimized for MCU: no <complex.h>, no <stdio.h>, no <stdlib.h>, no sprintf, no float
//

/**
 * @file ESGUI_PageDefaltVtbl.c
 * @brief ESGUI 默认页面虚函数表实现
 * @author E_LJF
 * @date 2026/06/06
 *
 * 本文件实现了 ESGUI 框架的默认显示效果，包括：
 *   - 文本菜单（纵向列表，支持焦点框动画、长文本滚动、进度条、特殊标记条目）
 *   - 图形菜单（横向 BMP 图片轮播，支持焦点框生长动画、标签滑入）
 *   - 消息弹窗 / 布尔弹窗 / 值弹窗 / 文本列表弹窗 / BMP 列表弹窗
 *
 * 所有实现均遵循以下设计原则：
 *   1. 零浮点运算：百分比使用千分比（permille，0~1000）
 *   2. 零动态内存：页面/弹窗数据使用静态内存池
 *   3. 模块化裁剪：通过 ESGUI_Config.h 的宏开关剔除不需要的功能
 *   4. 动画驱动：所有视觉变化（位置/尺寸/透明度）均通过 anim_start 驱动
 *   5. 页面切换过渡：Push/Pop 时启动百叶窗遮罩动画，must_complete 阻塞真正销毁
 */

#include "ESGUI_PageDefaltVtbl.h"

#include <string.h>
#include "ESGUI_BSP_Canvas.h"
#include "ESGUI_BSP_draw.h"
#include "ESGUI_BSP_Text.h"
#include "ESGUI_Anim.h"
#include "ESGUI_BSP_BMP.h"
#include "ESGUI_Widget.h"
#include "ESGUI_3D.h"


#ifndef offsetof
/**
 * @brief 标准 offsetof 宏的本地回退实现
 * @note  用于计算结构体成员相对于结构体起始地址的偏移量
 */
#define offsetof(type, member) ((eui_uint32_t)&((type *)0)->member)
#endif


/* ============================================================
 * 一、通用弹窗内存池分配函数（前向声明）
 * ============================================================
 * 由于弹窗同一时间只能存在一个，所有弹窗类型共享一个 Union 内存池。
 * 实际分配/释放函数定义在本文件末尾。
 */

#if (ESGUI_ENABLE_POPUP_MESSAGE || ESGUI_ENABLE_POPUP_BOOL || ESGUI_ENABLE_POPUP_VALUE || ESGUI_ENABLE_POPUP_TEXTLIST || ESGUI_ENABLE_POPUP_BMPLIST)
static void* popup_data_alloc();   /**< 分配通用弹窗数据内存 */
static void  popup_data_free();    /**< 释放通用弹窗数据内存 */
#endif


/* ============================================================
 * 二、统一过渡动画回调（文本菜单 + BMP 菜单共用）
 * ============================================================
 * 页面切换时使用百叶窗遮罩效果。
 * trans_count 取值 0~8，值越大遮罩越密（越黑）。
 * 进入/恢复时：8 → 0（淡入）
 * 退出/Push 前：0 → 8（淡出）
 */

#if ESGUI_ENABLE_BMP_MENU || ESGUI_ENABLE_TEXT_MENU
/**
 * @brief 过渡动画逐帧回调：将放大 1000 倍的动画值映射到 0~8 级遮罩
 * @param var   指向 eui_uint16_t 类型 trans_count 的指针
 * @param value 动画当前值（已放大 1000 倍，范围 0~8000）
 * @note  内部将 value/1000 得到实际遮罩级别，再限制到 0~8
 */
static void anim_cb_trans_level(void *var, eui_int32_t value) {
    if (var) {
        eui_uint16_t v = (eui_uint16_t)(value / 1000);
        if (v > 8) v = 8;
        *((eui_uint16_t *)var) = v;
    }
}
#endif


/* ============================================================
 * 三、轻量整数转字符串（文本菜单专用，替代 sprintf）
 * ============================================================ */

#if ESGUI_ENABLE_TEXT_MENU
/**
 * @brief 将 eui_int16_t 转换为十进制字符串（无 sprintf，零堆栈开销）
 * @param v    待转换的整数（支持负数）
 * @param out  输出缓冲区，需足够容纳结果（最大 6 字节：-32768 + \0）
 * @return     写入的字符数（不含 \0）
 * @note  从高位到低位逐位输出，跳过前导零，确保最小字符串长度
 */
static eui_uint8_t _int16_to_str(eui_int16_t v, char *out)
{
    eui_uint8_t n = 0;
    if (v < 0) { out[n++] = '-'; v = -v; }
    if (v >= 10000) out[n++] = (char)('0' + (v / 10000) % 10);
    if (v >= 1000)  out[n++] = (char)('0' + (v / 1000) % 10);
    if (v >= 100)   out[n++] = (char)('0' + (v / 100) % 10);
    if (v >= 10)    out[n++] = (char)('0' + (v / 10) % 10);
    out[n++] = (char)('0' + v % 10);
    out[n] = '\0';
    return n;
}
#endif


/* ============================================================
 * 四、默认文本菜单页面实现
 * ============================================================ */

#if ESGUI_ENABLE_TEXT_MENU

/** @brief 长文本滚动动画已启动标志 */
#define FLAG_LONG_TEXT_ANIM  0x01
/** @brief 当前焦点条目文本超出显示区域标志 */
#define FLAG_FOCUS_LONG_TEXT 0x02

#ifndef PAGE_DATA_POOL_SIZE
/**
 * @brief 文本菜单页面数据静态内存池大小（槽位数）
 * @note  默认与最大菜单深度相同，保证栈中每层都能有一个文本页面
 */
#define PAGE_DATA_POOL_SIZE  (ESGUI_MAX_MENU_DEPTH)
#endif

/** @brief 文本菜单页面数据静态内存池 */
static ESGUI_DEFALT_TEXT_PAGE_DATA_T s_page_data_pool[PAGE_DATA_POOL_SIZE];
/** @brief 内存池分配位图（0=空闲，1=占用） */
static eui_uint8_t s_text_page_data_alloc_map[PAGE_DATA_POOL_SIZE] = {0};

/**
 * @brief 从静态内存池分配一个文本菜单页面数据实例
 * @return 成功返回指针，失败返回 ESGUI_NULL（池满）
 * @note  自动清零分配的内存，确保初始状态一致
 */
static ESGUI_DEFALT_TEXT_PAGE_DATA_T *text_page_data_alloc(void)
{
    for (eui_uint8_t i = 0; i < PAGE_DATA_POOL_SIZE; i++) {
        if (s_text_page_data_alloc_map[i] == 0) {
            s_text_page_data_alloc_map[i] = 1;
            memset(&s_page_data_pool[i], 0, sizeof(ESGUI_DEFALT_TEXT_PAGE_DATA_T));
            return &s_page_data_pool[i];
        }
    }
    return ESGUI_NULL;
}

/**
 * @brief 将文本菜单页面数据实例归还到静态内存池
 * @param p 待释放的实例指针
 * @note  通过指针算术计算索引，无需额外存储 ID
 */
static void text_page_data_free(ESGUI_DEFALT_TEXT_PAGE_DATA_T *p)
{
    if (p == ESGUI_NULL) return;
    int idx = (int)(p - s_page_data_pool);
    if (idx >= 0 && idx < PAGE_DATA_POOL_SIZE) {
        s_text_page_data_alloc_map[idx] = 0;
    }
}


/* ---------- 4.2 小工具函数（降低与 Canvas 的耦合） ---------- */

/**
 * @brief 获取画布当前条带的宽度
 * @param it 条带迭代器指针
 * @return 画布宽度（像素）
 */
static eui_int16_t canvas_get_width(const CanvasStripIter *it)
{
    return (eui_int16_t)it->canvas->width;
}

/**
 * @brief 获取画布当前条带的高度
 * @param it 条带迭代器指针
 * @return 画布高度（像素）
 */
static eui_int16_t canvas_get_height(const CanvasStripIter *it)
{
    return (eui_int16_t)it->canvas->height;
}


/* ---------- 4.3 纯文本宽度计算（去除标记符后的实际文本宽度） ---------- */

#if (ESGUI_ENABLE_TEXT_MENU || ESGUI_ENABLE_POPUP_TEXTLIST)
/**
 * @brief 计算去除标记符后的纯文本显示宽度
 * @param label 原始文本（可能包含尾部标记符，如 "text\x03/0"）
 * @return 纯文本宽度（像素）
 * @note  若检测到 ESGUI_WIDGET_DEFAULT_MARK 标记，则截取标记前的内容计算宽度
 *        否则直接计算完整字符串宽度。用于焦点框宽度同步和长文本判断。
 */
static eui_uint16_t get_pure_text_width(const char *label)
{
    eui_uint16_t pure_len;
    char marker_type;
    if (ESGUI_WidgetCheckMarker(label, ESGUI_WIDGET_DEFAULT_MARK, &pure_len, &marker_type)) {
        if (pure_len == 0) return 0;
        char tmp[ESGUI_LABEL_TMP_BUF_SIZE];
        eui_uint16_t copy_len = (pure_len < (ESGUI_LABEL_TMP_BUF_SIZE - 1))
                          ? pure_len
                          : (ESGUI_LABEL_TMP_BUF_SIZE - 1);
        memcpy(tmp, label, copy_len);
        tmp[copy_len] = '\0';
        return (eui_uint16_t)eui_get_text_width(&ESGUI_DEFAULT_FONT, tmp);
    }
    return (eui_uint16_t)eui_get_text_width(&ESGUI_DEFAULT_FONT, label);
}
#endif


/* ---------- 4.4 可见区域计算（文本菜单 + 文本列表弹窗共用） ---------- */

/**
 * @brief 计算当前应显示的条目范围 [start, end]
 * @param item_num    总条目数
 * @param buff        屏幕可见条目数
 * @param stay        焦点保持在顶部/中间的阈值
 * @param focus_idx   当前焦点索引
 * @param out_start   输出：可见起始索引
 * @param out_end     输出：可见结束索引
 * @note  算法逻辑：
 *        - 条目数 <= buff：全部显示
 *        - 焦点在顶部区域（< stay）：显示前 stay+1 条
 *        - 焦点在中间区域：以焦点为中心显示 buff 条
 *        - 焦点在底部区域：显示最后 buff 条
 */
static void calc_visible_range(
    eui_uint16_t item_num, eui_uint16_t buff, eui_uint16_t stay, eui_uint16_t focus_idx,
    eui_uint16_t *out_start, eui_uint16_t *out_end)
{
    if (item_num <= buff) {
        *out_start = 0;
        *out_end   = item_num - 1;
        return;
    }
    if (focus_idx < stay) {
        *out_start = 0;
        /* 修复：顶部区域固定显示前 buff 条，避免 stay+1 在 buff=2/3 时越界 */
        *out_end   = buff - 1;
        if (*out_end >= item_num) *out_end = item_num - 1;
    } else if (focus_idx < item_num - (buff / 2)) {
        *out_start = focus_idx - stay + 1;
        *out_end   = *out_start + buff - 1;
        if (*out_end >= item_num) *out_end = item_num - 1;
    } else {
        *out_start = item_num - buff;
        *out_end   = item_num - 1;
    }
}

/**
 * @brief 计算当前焦点下，可见区域的首条索引
 * @return 首条索引（first_visible）
 * @note  与 calc_visible_range 逻辑一致，但只返回 start
 */
static eui_uint16_t calc_first_visible_for_focus(
    eui_uint16_t item_num, eui_uint16_t buff, eui_uint16_t stay, eui_uint16_t focus_idx)
{
    if (item_num <= buff) return 0;
    if (focus_idx < stay) return 0;
    if (focus_idx >= item_num - (buff / 2)) return item_num - buff;
    return focus_idx - stay + 1;
}

/**
 * @brief 计算焦点框在屏幕上的 Y 坐标
 * @param top_y          列表顶部 Y 坐标
 * @param focus_in_view  焦点在可见区域内的相对索引（0-based）
 * @param item_stride    条目步进（像素）
 * @return 焦点框 Y 坐标
 */
static eui_int16_t calc_focus_y(eui_int16_t top_y, eui_uint16_t focus_in_view, eui_uint16_t item_stride)
{
    return top_y + (eui_int16_t)(focus_in_view * item_stride);
}

/**
 * @brief 计算列表基线 Y 坐标（用于整体滚动动画的目标值）
 * @param top_y          列表顶部 Y 坐标
 * @param first_visible  当前可见首条索引
 * @param item_stride    条目步进（像素）
 * @return 列表基线 Y 坐标（items[0].y 的目标值）
 */
static eui_int16_t calc_list_y(eui_int16_t top_y, eui_uint16_t first_visible, eui_uint16_t item_stride)
{
    return top_y - (eui_int16_t)(first_visible * item_stride);
}

/**
 * @brief 计算当前焦点的进度条千分比
 * @param focus_idx  当前焦点索引（0-based）
 * @param item_num   总条目数
 * @return 千分比（0~1000），已做四舍五入
 * @note  公式：((focus_idx + 1) * 1000 + item_num / 2) / item_num
 */
static eui_uint16_t calc_progress_permille(eui_uint16_t focus_idx, eui_uint16_t item_num)
{
    return (eui_uint16_t)(((eui_uint32_t)(focus_idx + 1) * 1000U + item_num / 2U) / item_num);
}
#endif /* 可见区域计算 */


/* ---------- 4.5 通用动画回调函数 ---------- */

/**
 * @brief 通用动画回调：将 eui_int32_t 值写入 eui_uint16_t 变量
 * @param var   指向 eui_uint16_t 的指针
 * @param value 动画当前值
 * @note  用于 progress_bar_permille, line_len, trans_count 等
 */
static void anim_cb_uint16(void *var, eui_int32_t value) {
    if (var) *((eui_uint16_t *)var) = (eui_uint16_t)value;
}

/**
 * @brief 通用动画回调：将 eui_int32_t 值写入 eui_int16_t 变量
 * @param var   指向 eui_int16_t 的指针
 * @param value 动画当前值
 * @note  用于 focus_box_w, focus_box_y, long_text_x 等
 */
static void anim_cb_int16(void *var, eui_int32_t value) {
    if (var) *((eui_int16_t *)var) = (eui_int16_t)value;
}

/**
 * @brief 通用动画回调：将 eui_int32_t 值写入 int 变量
 * @param var   指向 int 的指针
 * @param value 动画当前值
 * @note  用于 items[0].y 等列表整体滚动
 */
static void anim_cb_int(void *var, eui_int32_t value) {
    if (var) *((int *)var) = (int)value;
}


/* ---------- 4.6 文本菜单动画启动辅助函数 ---------- */

#if ESGUI_ENABLE_TEXT_MENU
/**
 * @brief 启动进度条平滑动画
 * @param page      页面指针
 * @param permille  目标千分比（0~1000）
 * @param duration  动画持续时间（毫秒）
 * @note  从当前值平滑过渡到目标值，使用 EASE_OUT 曲线
 */
static void start_progress_bar_anim(ESGUI_MenuPage_T *page, eui_uint16_t permille, eui_uint32_t duration)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *page_data = page->draw_data;
    anim_t anim = {0};
    anim.var       = &page_data->progress_bar_permille;
    anim.start     = (eui_int32_t)page_data->progress_bar_permille;
    anim.end       = (eui_int32_t)permille;
    anim.exec_cb   = anim_cb_uint16;
    anim.duration  = duration;
    anim.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim);
}

/**
 * @brief 启动焦点框尺寸和位置平滑动画
 * @param page      页面指针
 * @param w         目标宽度（像素）
 * @param y         目标 Y 坐标（像素）
 * @param duration  动画持续时间（毫秒）
 * @note  同时启动宽度和 Y 坐标两个独立动画，使用同一缓动曲线
 */
static void start_focus_box_anim(ESGUI_MenuPage_T *page, eui_int16_t w, eui_int16_t y, eui_uint32_t duration)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *page_data = page->draw_data;
    anim_t anim_w = {0};
    anim_t anim_y = {0};
    anim_w.var       = &page_data->focus_box_w;
    anim_w.start     = page_data->focus_box_w;
    anim_w.end       = w;
    anim_w.exec_cb   = anim_cb_int16;
    anim_w.duration  = duration;
    anim_w.path_type = ANIM_PATH_EASE_OUT;
    anim_y.var       = &page_data->focus_box_y;
    anim_y.start     = page_data->focus_box_y;
    anim_y.end       = y;
    anim_y.exec_cb   = anim_cb_int16;
    anim_y.duration  = duration;
    anim_y.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_w);
    anim_start(&anim_y);
}

/**
 * @brief 启动列表整体滚动动画
 * @param page      页面指针
 * @param y         目标基线 Y 坐标（像素，即 items[0].y 的目标值）
 * @param duration  动画持续时间（毫秒）
 * @note  当焦点从顶部区域移入中间区域时，列表整体滚动以保持焦点在屏幕内
 */
static void start_item_scroll_anim(ESGUI_MenuPage_T *page, int y, eui_uint32_t duration)
{
    if (page == ESGUI_NULL) return;
    anim_t anim = {0};
    anim.var      = &page->items[0].y;
    anim.start    = page->items[0].y;
    anim.end      = y;
    anim.exec_cb  = anim_cb_int;
    anim.duration = duration;
    anim.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim);
}

/**
 * @brief 启动长文本环形滚动动画
 * @param page  页面指针
 * @note  从 ESGUI_TEXT_MARGIN_X 开始向左滚动，直到文本完全移出左侧，
 *        然后循环。使用线性曲线保证匀速滚动，延迟 400ms 后开始。
 *        无限循环（repeat_cnt = 0xFFFF），直到焦点切换或页面销毁。
 */
static void start_long_text_anim(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *page_data = page->draw_data;
    anim_t anim = {0};
    anim.var        = &page_data->long_text_x;
    anim.start      = ESGUI_TEXT_MARGIN_X;
    anim.end        = -(eui_int32_t)page_data->text_len - (eui_int32_t)ESGUI_LONG_TEXT_GAP;
    anim.exec_cb    = anim_cb_int16;
    anim.duration   = 7500;         /* 7.5 秒完成一次完整滚动 */
    anim.path_type  = ANIM_PATH_LINEAR;
    anim.repeat_cnt = 0xFFFF;       /* 无限循环 */
    anim.delay      = 400;          /* 停留 400ms 后开始滚动 */
    anim_start(&anim);
}


/* ---------- 4.7 页面切换过渡动画 ---------- */

/**
 * @brief 文本菜单过渡动画结束回调
 * @param a 动画实例指针
 * @note  动画结束后清零 trans_active，解除按键屏蔽
 */
static void text_trans_anim_ready_cb(struct anim_t *a) {
    if (!a || !a->var) return;
    /* 通过成员偏移反推结构体基地址，避免存储额外指针 */
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *pd = (ESGUI_DEFALT_TEXT_PAGE_DATA_T *)
        ((eui_uint8_t *)a->var - offsetof(ESGUI_DEFALT_TEXT_PAGE_DATA_T, trans_count));
    pd->trans_active = 0;
}

/**
 * @brief 启动百叶窗淡入动画（进入/恢复时）：level 8 → 0
 * @param page 页面指针
 * @note  若已有过渡动画在运行则忽略，防止重复启动。
 *        动画结束后通过 ready_cb 自动清零 trans_active。
 */
static void start_page_transition_anim(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *pd = page->draw_data;
    if (pd->trans_active) return;

    anim_t anim = {0};
    anim.var       = &pd->trans_count;
    anim.start     = 8;
    anim.end       = 0;
    anim.exec_cb   = anim_cb_uint16;
    anim.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
    anim.path_type = ANIM_PATH_LINEAR;
    anim.ready_cb  = text_trans_anim_ready_cb;   /* 动画真正结束时清零 */
    anim_start(&anim);

#if ESGUI_PAGE_TRANSITION_TYPE == 1
    /* 缩放模式：进入时条目从 0 放大到目标尺寸 */
    {
        eui_uint16_t focus_idx = page->focus_idx;
        eui_int16_t target_y = pd->title_h + ESGUI_TITLE_LINE_OFFSET;
        eui_uint16_t first_visible = calc_first_visible_for_focus(page->item_num, pd->buff, pd->stay, focus_idx);
        eui_uint16_t focus_in_view = focus_idx - first_visible;
        eui_int16_t focus_y = calc_focus_y(target_y, focus_in_view, pd->item_stride);
        eui_uint16_t text_len = get_pure_text_width(page->items[focus_idx].label);
        eui_int16_t max_text_w = canvas_get_width(page->render_ctx) - (eui_int16_t)pd->text_need_len - 2;
        eui_int16_t focus_w = (eui_int16_t)(text_len + ESGUI_FOCUS_BOX_PAD_X);
        if (focus_w > max_text_w) focus_w = max_text_w;
        if (focus_w < 0) focus_w = 0;

        /* 焦点框从 0 放大 */
        anim_t anim_fw = {0};
        anim_fw.var       = &pd->focus_box_w;
        anim_fw.start     = 0;
        anim_fw.end       = focus_w;
        anim_fw.exec_cb   = anim_cb_int16;
        anim_fw.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
        anim_fw.path_type = ANIM_PATH_EASE_OUT;
        anim_start(&anim_fw);

        /* 焦点框从屏幕中心 Y 移动到目标 Y */
        anim_t anim_fy = {0};
        anim_fy.var       = &pd->focus_box_y;
        anim_fy.start     = (eui_int16_t)(canvas_get_height(page->render_ctx) / 2);
        anim_fy.end       = focus_y;
        anim_fy.exec_cb   = anim_cb_int16;
        anim_fy.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
        anim_fy.path_type = ANIM_PATH_EASE_OUT;
        anim_start(&anim_fy);

        /* 列表从屏幕中心下方滑入 */
        eui_int16_t list_y = calc_list_y(target_y, first_visible, pd->item_stride);
        anim_t anim_ly = {0};
        anim_ly.var       = &page->items[0].y;
        anim_ly.start     = (eui_int16_t)(canvas_get_height(page->render_ctx));
        anim_ly.end       = list_y;
        anim_ly.exec_cb   = anim_cb_int;
        anim_ly.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
        anim_ly.path_type = ANIM_PATH_EASE_OUT;
        anim_start(&anim_ly);
    }
#endif

    pd->trans_active = 1;
}

/**
 * @brief 启动百叶窗退出动画（Pop / Push 切换前）：level 0 → 8
 * @param page 页面指针
 * @note  设置 must_complete=1，阻塞 ESGUI_MenuCtrlExecPendingPop 直到动画完成，
 *        确保用户能看到完整的退出效果后再执行页面销毁。
 */
static void start_page_exit_anim(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *pd = page->draw_data;
    if (pd->trans_active) return;

    anim_t anim = {0};
    anim.var       = &pd->trans_count;
    anim.start     = 0;
    anim.end       = 8;
    anim.exec_cb   = anim_cb_uint16;
    anim.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
    anim.path_type = ANIM_PATH_LINEAR;
    anim_set_must_complete(&anim, 1);
    anim.ready_cb  = text_trans_anim_ready_cb;   /* 动画真正结束时清零 */
    anim_start(&anim);

    pd->trans_active = 1;
}

/**
 * @brief 首次进入页面时的完整入场动画
 * @param page 页面指针
 * @note  包括：
 *        - 标题分割线从 0 延伸到屏幕宽度
 *        - 进度条从 0 到目标值
 *        - 焦点框从 0 宽度和屏幕外 Y 位置移动到首条位置
 *        - 首条条目从屏幕外滑入
 *        仅当 first_push=1 时调用一次。
 */
static void start_first_in_anim(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *page_data = page->draw_data;
    CanvasStripIter *c_it = page->render_ctx;
    anim_t line_anim = {0};
    line_anim.var       = &page_data->line_len;
    line_anim.start     = 0;
    line_anim.end       = canvas_get_width(c_it) - ESGUI_PROGRESS_BAR_W;
    line_anim.exec_cb   = anim_cb_uint16;
    line_anim.duration  = 600;
    line_anim.path_type = ANIM_PATH_EASE_OUT;
    if (page->title && page->title[0]) {
        anim_start(&line_anim);
    }
    eui_uint16_t permille = calc_progress_permille(page->focus_idx, page->item_num);
    start_progress_bar_anim(page, permille, 600);
    eui_int16_t focus_w = (eui_int16_t)get_pure_text_width(page->items[0].label) + ESGUI_FOCUS_BOX_PAD_X;
    eui_int16_t max_text_w = canvas_get_width(c_it) - (eui_int16_t)page_data->text_need_len - 2;
    if (focus_w > max_text_w) focus_w = max_text_w;
    if (focus_w < 0) focus_w = 0;
    eui_int16_t focus_y = page_data->title_h + ESGUI_TITLE_LINE_OFFSET;
    start_focus_box_anim(page, focus_w, focus_y, 600);
    eui_uint16_t text_len = get_pure_text_width(page->items[0].label);
    page_data->text_len = text_len;
    page->items[0].y = -(page_data->title_h * 5);
    start_item_scroll_anim(page, focus_y, 600);
}


/* ---------- 4.8 特殊条目绘制与宽度计算 ---------- */

/**
 * @brief 获取指定索引条目的特殊标记所占宽度
 * @param page  页面指针
 * @param indx  条目索引
 * @return 特殊标记所需宽度（像素），无标记返回 0
 * @note  支持的标记类型：
 *        '0' → 方形复选框（宽 10px）
 *        '1' → 圆形单选框（宽 10px）
 *        '2' → 数值显示（宽 20px）
 */
eui_uint16_t esgui_text_menu_defalt_get_special_item_draw_w(ESGUI_MenuPage_T *page, eui_uint16_t indx)
{
    if (page == ESGUI_NULL) return 0;
    (void)page;
    char c;
    if (ESGUI_WidgetCheckMarker(page->items[indx].label, ESGUI_WIDGET_DEFAULT_MARK, ESGUI_NULL, &c)) {
        switch (c) {
            case '2': return 20;
            default:  return 0;
        }
    }
    return 0;
}

/**
 * @brief 绘制指定索引条目的特殊标记图形
 * @param page  页面指针
 * @param indx  条目索引
 * @return 实际占用的宽度（像素），无标记返回 0
 * @note  在条目右侧（进度条左侧）绘制标记图形。
 *        复选框/单选框状态由标记字符决定，数值由 items[indx].arg 指向的 eui_int16_t 提供。
 */
eui_uint16_t esgui_text_menu_defalt_special_item_draw(ESGUI_MenuPage_T *page, eui_uint16_t indx)
{
    if (page == ESGUI_NULL) return 0;
    CanvasStripIter *c_it = page->render_ctx;
    char c;
    eui_uint16_t pure_len;
    if (!ESGUI_WidgetCheckMarker(page->items[indx].label, ESGUI_WIDGET_DEFAULT_MARK, &pure_len, &c)) {
        return 0;
    }
    eui_int16_t x_base = canvas_get_width(c_it) - ESGUI_PROGRESS_BAR_W;
    switch (c) {
        case '2': {
            char buff[10] = {0};
            _int16_to_str(*(eui_int16_t*)page->items[indx].arg, buff);
            eui_draw_text(c_it->canvas,
                x_base - 15,
                page->items[indx].y,
                &ESGUI_DEFAULT_FONT,
                buff,
                EUI_MODE_SET);
            return 20;
        }
        default:
            return 0;
    }
}


/* ---------- 4.9 文本菜单页面生命周期 ---------- */

/**
 * @brief 文本菜单页面创建回调
 * @param page 页面指针
 * @note  分配页面私有数据，计算字体高度、条目步进、可见条目数等常量。
 *        初始化过渡动画状态（trans_count=0, trans_active=0, first_push=1）。
 *        此函数在页面首次被渲染前由 ESGUI_Tick 调用。
 */
void esgui_text_menu_defalt_on_create(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL) return;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *data = text_page_data_alloc();
    if (data == ESGUI_NULL) return;
    page->draw_data = data;
    if (page->title && page->title[0]) {
        data->title_h = (eui_uint8_t)eui_get_text_height(&ESGUI_DEFAULT_FONT, page->title);
        data->font_height = data->title_h;
    } else {
        data->title_h = 0;
        data->font_height = (eui_uint8_t)eui_get_text_height(&ESGUI_DEFAULT_FONT, page->items[0].label);
    }
    data->item_stride = data->font_height + ESGUI_ITEM_SPACING;
    CanvasStripIter *c_it = page->render_ctx;
    eui_int16_t content_h = canvas_get_height(c_it) - data->title_h - ESGUI_TITLE_LINE_OFFSET;
    data->buff = (eui_uint16_t)(content_h / data->item_stride);
    data->stay = (data->buff + 1) / 2;

    /* 初始化初始焦点条目的文本指标（等效于首次 on_focus_change）：
     * 保证首条即为长文本时（focus_idx=0），进入页面即可识别并启动环形滚动 */
    eui_uint16_t focus_idx = page->focus_idx;
    eui_uint16_t text_len = get_pure_text_width(page->items[focus_idx].label);
    data->text_len = text_len;

    eui_uint16_t need_len = ESGUI_PROGRESS_BAR_W;
    if (page->vtbl->get_special_item_draw_w != ESGUI_NULL) {
        need_len += page->vtbl->get_special_item_draw_w(page, focus_idx);
    }
    data->text_need_len = need_len;

    eui_int16_t max_text_w = canvas_get_width(c_it) - (eui_int16_t)need_len - 2;
    data->flags = (data->flags & ~(FLAG_FOCUS_LONG_TEXT))
                | ((text_len > (eui_uint16_t)max_text_w) ? FLAG_FOCUS_LONG_TEXT : 0);

    /* 过渡动画初始化 */
    data->trans_count = 0;
    data->trans_active = 0;
    data->first_push = 1;
}

/**
 * @brief 文本菜单页面销毁回调
 * @param page 页面指针
 * @note  停止该页面关联的所有动画（防止野指针回调），释放页面私有数据内存池。
 *        清除 render_ctx 防止悬空指针。
 */
void esgui_text_menu_defalt_on_destroy(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL) return;
    if (page->draw_data != ESGUI_NULL) {
        ESGUI_DEFALT_TEXT_PAGE_DATA_T *data = page->draw_data;
        anim_stop_all(&data->long_text_x);
        anim_stop_all(&data->focus_box_w);
        anim_stop_all(&data->focus_box_y);
        anim_stop_all(&data->line_len);
        anim_stop_all(&page->items[0].y);
        anim_stop_all(&data->trans_count);  /* 停止可能正在运行的过渡动画 */
        text_page_data_free(page->draw_data);
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}

/**
 * @brief 文本菜单焦点变化回调
 * @param page     页面指针
 * @param old_idx  原焦点索引
 * @param new_idx  新焦点索引
 * @note  核心逻辑：
 *        1. 计算新焦点条目的纯文本宽度和特殊标记宽度
 *        2. 判断文本是否超长，设置 FLAG_FOCUS_LONG_TEXT
 *        3. 根据焦点位置决定是移动焦点框还是整体滚动列表
 *        4. 启动进度条、焦点框、列表滚动动画
 *        5. 若 old_idx == new_idx（Pop 恢复），启动百叶窗淡入
 */
void esgui_text_menu_defalt_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx)
{
    (void)old_idx;
    (void)new_idx;
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *pd = page->draw_data;
    const esgui_page_vtable_t *vtbl = page->vtbl;
    eui_uint16_t focus_idx = page->focus_idx;
    eui_uint16_t item_num  = page->item_num;
    eui_int16_t  canvas_w  = canvas_get_width(c_it);

    eui_uint16_t text_len = get_pure_text_width(page->items[focus_idx].label);
    pd->text_len = text_len;

    eui_uint16_t need_len = ESGUI_PROGRESS_BAR_W;
    if (vtbl->get_special_item_draw_w != ESGUI_NULL) {
        need_len += vtbl->get_special_item_draw_w(page, focus_idx);
    }
    pd->text_need_len = need_len;

    eui_int16_t max_text_w = canvas_w - (eui_int16_t)need_len - 2;
    pd->flags = (pd->flags & ~(FLAG_FOCUS_LONG_TEXT))
              | ((text_len > (eui_uint16_t)max_text_w) ? FLAG_FOCUS_LONG_TEXT : 0);

    eui_int16_t focus_w = (eui_int16_t)(text_len + ESGUI_FOCUS_BOX_PAD_X);
    if (focus_w > max_text_w) focus_w = max_text_w;
    if (focus_w < 0) focus_w = 0;

    eui_int16_t top_y = pd->title_h + ESGUI_TITLE_LINE_OFFSET;
    eui_uint16_t first_visible = calc_first_visible_for_focus(item_num, pd->buff, pd->stay, focus_idx);
    eui_uint16_t focus_in_view = focus_idx - first_visible;
    eui_int16_t focus_y = calc_focus_y(top_y, focus_in_view, pd->item_stride);

    if (item_num <= pd->buff) {
        /* 条目少，全部可见，只移动焦点框 */
        start_focus_box_anim(page, focus_w, focus_y, 400);
    } else if (focus_idx < pd->stay) {
        /* 焦点在顶部区域，列表回到顶部，焦点框移动 */
        start_item_scroll_anim(page, top_y, 230);
        start_focus_box_anim(page, focus_w, focus_y, 400);
    } else if (focus_idx < item_num - (pd->buff / 2)) {
        /* 焦点在中间区域，列表整体滚动，焦点框位置不变（相对屏幕） */
        eui_int16_t list_y = calc_list_y(top_y, first_visible, pd->item_stride);
        start_item_scroll_anim(page, list_y, 230);
        start_focus_box_anim(page, focus_w, focus_y, 400);
    } else {
        /* 焦点在底部区域，直接修正 items[0].y，避免回退后整体偏移 */
        first_visible = calc_first_visible_for_focus(item_num, pd->buff, pd->stay, focus_idx);
        eui_int16_t list_y = calc_list_y(top_y, first_visible, pd->item_stride);
        page->items[0].y = list_y;
        start_focus_box_anim(page, focus_w, focus_y, 400);
    }

    /* 重置长文本滚动状态 */
    pd->long_text_x = ESGUI_TEXT_MARGIN_X;
    pd->flags &= ~FLAG_LONG_TEXT_ANIM;
    anim_stop_all(&pd->long_text_x);

    eui_uint16_t permille = calc_progress_permille(focus_idx, item_num);
    start_progress_bar_anim(page, permille, 300);

    /* Pop 恢复后（old == new 来自 ExecPendingPop）启动百叶窗淡入 */
    if (old_idx == new_idx) {
        start_page_transition_anim(page);
    }
}

/**
 * @brief 文本菜单默认输入处理
 * @param page 页面指针
 * @param e    事件码
 * @return 动作指令（ACT_NONE / ACT_PUSH_PAGE / ACT_POP_PAGE / ACT_REFRESH）
 * @note  事件映射：UP/RIGHT=焦点下移，DOWN/LEFT=焦点上移，OK/CLICK=触发 on_enter，BACK=返回。
 *        过渡动画期间屏蔽按键，防止长按重复触发 Pop。
 */
ESGUI_MenuAction_T esgui_menu_defalt_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e)
{
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};

    /* 过渡动画期间屏蔽按键，防止长按重复触发 Pop */
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *pd = page->draw_data;
    if (pd && pd->trans_active) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};

    eui_uint16_t old_focus_idx = page->focus_idx;
    switch (e) {
        case EVT_KEY_UP:
        case EVT_KEY_RIGHT:
            FocusUP(page->focus_idx, page->item_num);
            break;
        case EVT_KEY_DOWN:
        case EVT_KEY_LEFT:
            FocusDOWN(page->focus_idx);
            break;
        case EVT_KEY_OK:
        case EVT_CLICKED:
            if (page->items[page->focus_idx].on_enter) {
                return page->items[page->focus_idx].on_enter(page,page->items[page->focus_idx].arg);
            }
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
        case EVT_KEY_BACK:
            return (ESGUI_MenuAction_T){ACT_POP_PAGE, ESGUI_NULL};
        default:
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    }
    if (old_focus_idx != page->focus_idx) {
        if (page->vtbl->on_focus_change) {
            page->vtbl->on_focus_change(page, old_focus_idx, page->focus_idx);
        }
        return (ESGUI_MenuAction_T){ACT_REFRESH, ESGUI_NULL};
    }
    return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
}

/**
 * @brief 文本菜单绘制回调
 * @param page 页面指针
 * @note  绘制顺序：
 *        1. 标题和分割线（带裁剪）
 *        2. 右侧纵向进度条
 *        3. 可见条目文本（带裁剪，支持长文本环形滚动）
 *        4. 焦点框（圆角矩形）
 *        5. 页面切换过渡遮罩（若 trans_active）
 */
void esgui_text_menu_defalt_on_draw(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;

    CanvasStripIter *c_it = (CanvasStripIter *)page->render_ctx;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *pd = (ESGUI_DEFALT_TEXT_PAGE_DATA_T *)page->draw_data;
    const esgui_page_vtable_t *vtbl = page->vtbl;

    eui_int16_t canvas_w = canvas_get_width(c_it);
    eui_int16_t canvas_h = canvas_get_height(c_it);
    eui_int16_t max_text_w = canvas_w - ESGUI_PROGRESS_BAR_W;

    /* 绘制标题和分割线 */
    if (page->title && page->title[0]) {
        eui_draw_text_clip(c_it->canvas, 0, 0, &ESGUI_DEFAULT_FONT, page->title, EUI_MODE_SET, max_text_w);
        eui_draw_hline(c_it->canvas, 0, pd->line_len, pd->title_h, EUI_MODE_SET);
    }

    /* 右侧纵向进度条 */
    ESGUI_WidgetProgrssBarPermille(c_it->canvas, canvas_w - ESGUI_PROGRESS_BAR_W, 0,
        ESGUI_PROGRESS_BAR_W, pd->progress_bar_permille, ESGUI_WIDGET_PROGBAR_DOWN);

    /* 计算可见条目范围 */
    eui_uint16_t start, end;
    calc_visible_range(page->item_num, pd->buff, pd->stay, page->focus_idx, &start, &end);

    /* 压入列表裁剪区，防止文本画出列表区域 */
    Area clip = {
        0,
        pd->title_h + ESGUI_TITLE_LINE_OFFSET,
        canvas_w - ESGUI_PROGRESS_BAR_W,
        canvas_h
    };
    canvas_clip_push(c_it->canvas, &clip);

    eui_int16_t list_base_y = page->items[0].y;
    eui_uint16_t stride = pd->item_stride;
    eui_uint16_t focus_idx = page->focus_idx;
    bool has_special = (vtbl->special_item_draw != ESGUI_NULL);

    /* 逐条绘制可见条目 */
    eui_int32_t item_y_acc = (eui_int32_t)list_base_y + (eui_int32_t)start * (eui_int32_t)stride;
    for (eui_uint16_t i = start; i <= end; i++, item_y_acc += stride) {
        eui_int16_t item_y = (eui_int16_t)item_y_acc;
        page->items[i].y = item_y;

        eui_uint16_t need_len = ESGUI_PROGRESS_BAR_W;
        if (has_special) {
            need_len += vtbl->special_item_draw(page, i);
        }
        eui_int16_t item_max_w = canvas_w - (eui_int16_t)need_len;

        if (i == focus_idx && (pd->flags & FLAG_FOCUS_LONG_TEXT)) {
            /* 长文本焦点条目：绘制两段文本实现环形滚动效果 */
            eui_uint16_t cached_text_len = pd->text_len;
            eui_int16_t long_text_x = pd->long_text_x;

            eui_int16_t abs_x = (long_text_x < 0) ? -long_text_x : long_text_x;
            eui_int16_t w1 = item_max_w + abs_x - ESGUI_TEXT_MARGIN_X;
            if (w1 > (eui_int16_t)cached_text_len) w1 = (eui_int16_t)cached_text_len;
            if (w1 < 0) w1 = 0;

            eui_draw_text_clip(c_it->canvas, long_text_x, item_y,
                &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, w1);

            eui_int32_t text_plus_x = (eui_int32_t)cached_text_len + (eui_int32_t)long_text_x;
            eui_int16_t text_area_right = canvas_w - (eui_int16_t)need_len;
            eui_int16_t remain = text_area_right - (eui_int16_t)text_plus_x;
            if (remain >= ESGUI_LONG_TEXT_GAP) {
                eui_int16_t X2 = long_text_x + (eui_int16_t)cached_text_len + ESGUI_LONG_TEXT_GAP + 2;
                eui_int16_t w2 = text_area_right - X2;
                if (w2 > (eui_int16_t)cached_text_len) w2 = (eui_int16_t)cached_text_len;
                if (w2 < 0) w2 = 0;
                eui_draw_text_clip(c_it->canvas, X2, item_y,
                    &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, w2);
            }

            if (!(pd->flags & FLAG_LONG_TEXT_ANIM)) {
                pd->flags |= FLAG_LONG_TEXT_ANIM;
                start_long_text_anim(page);
            }
        } else {
            /* 普通条目：直接绘制，按纯文本宽度裁剪 */
            eui_uint16_t pure_text_w = get_pure_text_width(page->items[i].label);
            eui_int16_t draw_max_w = (item_max_w < (eui_int16_t)pure_text_w) ? item_max_w : (eui_int16_t)pure_text_w;
            if (draw_max_w < 0) draw_max_w = 0;
            eui_draw_text_clip(c_it->canvas, ESGUI_TEXT_MARGIN_X, item_y,
                &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, (int)draw_max_w);
        }
    }

    canvas_clip_pop(c_it->canvas);

    /* 绘制焦点框 */
    ESGUI_WidgetTextFocusBox(c_it->canvas, 0, pd->focus_box_y,
        pd->font_height, (eui_uint8_t)pd->focus_box_w);

    /* 页面切换过渡动画遮罩 */
    if (pd->trans_active) {
#if ESGUI_PAGE_TRANSITION_TYPE == 0
        canvas_apply_transition_mask(c_it->canvas, (eui_uint8_t)pd->trans_count);
#elif ESGUI_PAGE_TRANSITION_TYPE == 1
        canvas_apply_zoom_mask(c_it->canvas, (eui_uint8_t)pd->trans_count);
#endif
    }
}

/**
 * @brief 文本菜单页面切换回调
 * @param page   页面指针
 * @param action 动作指令指针
 * @note  ACT_PUSH_PAGE：首次 Push 启动完整入场动画，后续 Push 只启动百叶窗淡入
 *        ACT_POP_PAGE：启动百叶窗退出动画（must_complete 阻塞真正 Pop）
 */
void esgui_text_menu_default_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action) {
    if (page == ESGUI_NULL || action == ESGUI_NULL) return;
    ESGUI_DEFALT_TEXT_PAGE_DATA_T *pd = page->draw_data;
    switch (action->act) {
        case ACT_PUSH_PAGE:
            /* 首次创建才启动完整滑入动画；Pop 恢复时只启动百叶窗淡入 */
            if (pd && pd->first_push) {
                pd->first_push = 0;
                start_first_in_anim(page);
            }
            start_page_transition_anim(page);
            break;
        case ACT_POP_PAGE:
            /* 页面退出：启动退出遮罩，must_complete 阻塞真正 Pop */
            start_page_exit_anim(page);
            break;
        default:
            break;
    }
}


/* ---------- 4.10 默认文本菜单虚函数表与构造函数 ---------- */

/**
 * @brief 文本菜单默认虚函数表
 * @note  所有函数指针均指向本文件内的静态实现。
 *        用户可通过自定义 vtable 覆盖其中任意函数以修改行为。
 */
static const esgui_page_vtable_t s_default_text_vtable = {
    .on_create                = esgui_text_menu_defalt_on_create,
    .on_destroy               = esgui_text_menu_defalt_on_destroy,
    .on_draw                  = esgui_text_menu_defalt_on_draw,
    .on_focus_change          = esgui_text_menu_defalt_on_focus_change,
    .on_input                 = esgui_menu_defalt_on_input,
    .special_item_draw        = esgui_text_menu_defalt_special_item_draw,
    .get_special_item_draw_w  = esgui_text_menu_defalt_get_special_item_draw_w,
    .on_page_chenge           = esgui_text_menu_default_on_page_change,
};

/**
 * @brief 创建默认文本菜单页面
 * @param page      页面结构体指针（由调用者分配）
 * @param items     条目数组指针
 * @param title     页面标题（可为 ESGUI_NULL 或空字符串）
 * @param item_num  条目数量
 * @note  清零页面结构体，绑定默认虚函数表，设置条目和标题。
 *        实际的 on_create 在首次渲染时由 ESGUI_Tick 调用。
 */
void ESGUI_DefaltTextMenuCreate(ESGUI_MenuPage_T *page,
                                ESGUI_MenuItem_T *items, const char *title,
                                eui_uint32_t item_num)
{
    if (page == ESGUI_NULL || items == ESGUI_NULL || item_num == 0) return;
    memset(page, 0, sizeof(ESGUI_MenuPage_T));
    page->vtbl      = &s_default_text_vtable;
    page->items     = items;
    page->title     = title;
    page->item_num  = (eui_uint16_t)item_num;
}
#endif /* ESGUI_ENABLE_TEXT_MENU */


/* ============================================================
 * 五、默认图形（BMP）菜单页面实现
 * ============================================================ */

#if (ESGUI_ENABLE_BMP_MENU || ESGUI_ENABLE_POPUP_BMPLIST || ESGUI_ENABLE_3D_MENU)
/**
 * @brief 获取 BMP 条目相对于 items[0].x 的相对 X 坐标
 * @param page 页面指针
 * @param idx  条目索引
 * @return 相对 X 坐标（像素）
 * @note  items[0] 的相对坐标恒为 0，后续条目累加前一张图片宽度 + 间距
 */
static eui_int16_t bmp_item_rel_x(ESGUI_MenuPage_T *page, eui_uint16_t idx) {
    return (idx == 0) ? 0 : page->items[idx].x;
}
#endif


#if ESGUI_ENABLE_BMP_MENU

/* ---------- 5.1 BMP 菜单静态内存池 ---------- */

static ESGUI_DEFAULT_BMP_MENU_DAT s_bmp_page_data_pool[BMP_PAGE_DATA_POOL_SIZE];
static eui_uint8_t s_bmp_page_data_alloc_map[BMP_PAGE_DATA_POOL_SIZE] = {0};

/**
 * @brief 从静态内存池分配一个 BMP 菜单页面数据实例
 * @return 成功返回指针，失败返回 ESGUI_NULL
 */
static ESGUI_DEFAULT_BMP_MENU_DAT *bmp_page_data_alloc(void)
{
    for (eui_uint8_t i = 0; i < BMP_PAGE_DATA_POOL_SIZE; i++) {
        if (s_bmp_page_data_alloc_map[i] == 0) {
            s_bmp_page_data_alloc_map[i] = 1;
            memset(&s_bmp_page_data_pool[i], 0, sizeof(ESGUI_DEFAULT_BMP_MENU_DAT));
            return &s_bmp_page_data_pool[i];
        }
    }
    return ESGUI_NULL;
}

/**
 * @brief 将 BMP 菜单页面数据实例归还到静态内存池
 * @param p 待释放的实例指针
 */
static void bmp_page_data_free(ESGUI_DEFAULT_BMP_MENU_DAT *p)
{
    if (p == ESGUI_NULL) return;
    int idx = (int)(p - s_bmp_page_data_pool);
    if (idx >= 0 && idx < BMP_PAGE_DATA_POOL_SIZE) {
        s_bmp_page_data_alloc_map[idx] = 0;
    }
}


/* ---------- 5.2 BMP 菜单页面生命周期 ---------- */

/**
 * @brief BMP 菜单页面创建回调
 * @param page 页面指针
 * @note  计算图片布局：
 *        - 顶部进度条高度 + 边距
 *        - 图片垂直居中于进度条和标签之间的区域
 *        - 标签位于屏幕底部
 *        - 所有图片水平排列，items[i].x 存储相对坐标
 */
void esgui_bmp_menu_defalt_on_create(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = bmp_page_data_alloc();
    if (dat == ESGUI_NULL) return;
    page->draw_data = dat;
    CanvasStripIter *c_it = page->render_ctx;
    eui_uint16_t canvas_w = canvas_get_width(c_it);
    eui_uint16_t canvas_h = canvas_get_height(c_it);
    dat->font_height = (eui_uint8_t)eui_get_text_height(&ESGUI_DEFAULT_FONT, "0");
    dat->progress_bar_h = ESGUI_PROGRESS_BAR_W;
    if (dat->progress_bar_h < 2) dat->progress_bar_h = 3;
    eui_uint16_t top_margin = dat->progress_bar_h + 4;
    dat->label_y = canvas_h - dat->font_height - 2;
    dat->label_anim_y = dat->label_y;
    eui_uint16_t max_bmp_h = 0;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        const Bitmap *bmp = page->items[i].icon;
        if (bmp && bmp->h > max_bmp_h) max_bmp_h = bmp->h;
    }
    eui_uint16_t separator_y = dat->label_y - 2;
    eui_uint16_t mid_h = (separator_y > top_margin) ? (separator_y - top_margin) : 0;
    dat->bmp_y = top_margin + (mid_h > max_bmp_h ? (mid_h - max_bmp_h) / 2 : 0);
    page->items[0].x = 0;
    eui_int16_t rel_x = 0;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        const Bitmap *bmp = page->items[i].icon;
        if (bmp) {
            page->items[i].y = dat->bmp_y + (max_bmp_h - bmp->h) / 2;
        } else {
            page->items[i].y = dat->bmp_y;
        }
        if (i > 0) {
            const Bitmap *prev_bmp = page->items[i - 1].icon;
            if (prev_bmp) rel_x += prev_bmp->w + ESGUI_BMP_ITEM_GAP;
            page->items[i].x = rel_x;
        }
    }
    dat->progress_bar_per = 0;
    dat->line_len = 0;
    dat->box_permille = 0;
    dat->box_start_w  = 0;
    dat->box_start_h  = 0;
    dat->box_target_w = 0;
    dat->box_target_h = 0;

    /* 过渡动画初始化 */
    dat->trans_count = 0;
    dat->trans_active = 0;
    dat->first_push = 1;
}

/**
 * @brief BMP 菜单页面销毁回调
 * @param page 页面指针
 * @note  停止所有关联动画，释放内存池，清除 render_ctx
 */
void esgui_bmp_menu_defalt_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = page->draw_data;
    if (dat != ESGUI_NULL) {
        anim_stop_all(&page->items[0].x);
        anim_stop_all(&dat->progress_bar_per);
        anim_stop_all(&dat->line_len);
        anim_stop_all(&dat->label_anim_y);
        anim_stop_all(&dat->box_permille);
        anim_stop_all(&dat->trans_count);  /* 停止过渡动画 */
        bmp_page_data_free(dat);
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}


/* ---------- 5.3 BMP 菜单过渡动画 ---------- */

/**
 * @brief BMP 菜单过渡动画结束回调
 * @param a 动画实例指针
 */
static void bmp_trans_anim_ready_cb(struct anim_t *a) {
    if (!a || !a->var) return;
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = (ESGUI_DEFAULT_BMP_MENU_DAT *)
        ((eui_uint8_t *)a->var - offsetof(ESGUI_DEFAULT_BMP_MENU_DAT, trans_count));
    dat->trans_active = 0;
}

/**
 * @brief 启动 BMP 菜单百叶窗淡入动画（进入/恢复时）：level 8 → 0
 * @param page 页面指针
 */
static void start_bmp_page_transition_anim(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = page->draw_data;
    if (dat->trans_active) return;

    anim_t anim = {0};
    anim.var       = &dat->trans_count;
    anim.start     = 8;
    anim.end       = 0;
    anim.exec_cb   = anim_cb_uint16;
    anim.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
    anim.path_type = ANIM_PATH_LINEAR;
    anim.ready_cb  = bmp_trans_anim_ready_cb;
    anim_start(&anim);

    dat->trans_active = 1;
}

/**
 * @brief 启动 BMP 菜单百叶窗退出动画（Pop / Push 切换前）：level 0 → 8
 * @param page 页面指针
 * @note  must_complete 阻塞真正 Pop
 */
static void start_bmp_page_exit_anim(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = page->draw_data;
    if (dat->trans_active) return;

    anim_t anim = {0};
    anim.var       = &dat->trans_count;
    anim.start     = 0;
    anim.end       = 8;
    anim.exec_cb   = anim_cb_uint16;
    anim.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
    anim.path_type = ANIM_PATH_LINEAR;
    anim_set_must_complete(&anim, 1);
    anim.ready_cb  = bmp_trans_anim_ready_cb;
    anim_start(&anim);

    dat->trans_active = 1;
}


/* ---------- 5.4 BMP 菜单输入与焦点变化 ---------- */

/**
 * @brief BMP 菜单默认输入处理
 * @param page 页面指针
 * @param e    事件码
 * @return 动作指令
 * @note  事件映射与文本菜单相同。过渡动画期间屏蔽按键。
 */
ESGUI_MenuAction_T esgui_bmp_defalt_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e)
{
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};

    /* 过渡动画期间屏蔽按键 */
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = page->draw_data;
    if (dat && dat->trans_active) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};

    eui_uint16_t old_focus_idx = page->focus_idx;
    switch (e) {
        case EVT_KEY_UP:
        case EVT_KEY_RIGHT:
            FocusUP(page->focus_idx, page->item_num);
            break;
        case EVT_KEY_DOWN:
        case EVT_KEY_LEFT:
            FocusDOWN(page->focus_idx);
            break;
        case EVT_KEY_OK:
        case EVT_CLICKED:
            if (page->items[page->focus_idx].on_enter) {
                return page->items[page->focus_idx].on_enter(page, page->items[page->focus_idx].arg);
            }
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
        case EVT_KEY_BACK:
            return (ESGUI_MenuAction_T){ACT_POP_PAGE, ESGUI_NULL};
        default:
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    }
    if (old_focus_idx != page->focus_idx) {
        if (page->vtbl->on_focus_change) {
            page->vtbl->on_focus_change(page, old_focus_idx, page->focus_idx);
        }
        return (ESGUI_MenuAction_T){ACT_REFRESH, ESGUI_NULL};
    }
    return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
}

/**
 * @brief BMP 菜单焦点变化回调
 * @param page     页面指针
 * @param old_idx  原焦点索引
 * @param new_idx  新焦点索引
 * @note  核心逻辑：
 *        1. 计算新焦点图片应在屏幕正中的位置，得到 items[0].x 的目标值
 *        2. 启动图片横向滚动动画（EASE_OUT）
 *        3. 启动顶部进度条动画
 *        4. 记录当前焦点框尺寸作为起点，目标尺寸为新图片尺寸 + 4px 边距
 *        5. 启动焦点框生长动画（0~1000）
 *        6. 启动标签从屏幕底部滑入动画
 *        7. 若 old_idx == new_idx（Pop 恢复），启动百叶窗淡入
 */
void esgui_bmp_menu_defalt_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx) {
    (void)old_idx;
    (void)new_idx;
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = page->draw_data;
    CanvasStripIter *c_it = page->render_ctx;
    eui_uint16_t canvas_w = canvas_get_width(c_it);
    eui_uint16_t canvas_h = canvas_get_height(c_it);
    eui_uint16_t focus_idx = page->focus_idx;
    eui_int16_t focus_rel_x = bmp_item_rel_x(page, focus_idx);
    const Bitmap *focus_bmp = page->items[focus_idx].icon;
    eui_int16_t focus_w = focus_bmp ? focus_bmp->w : 0;
    eui_int16_t target_base = (canvas_w - focus_w) / 2 - focus_rel_x;
    anim_t anim = {0};
    anim.var       = &page->items[0].x;
    anim.start     = page->items[0].x;
    anim.end       = target_base;
    anim.exec_cb   = anim_cb_int;
    anim.duration  = 300;
    anim.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim);
    eui_uint16_t target_per = (eui_uint16_t)(((eui_uint32_t)(focus_idx + 1) * 1000U + page->item_num / 2U) / page->item_num);
    if (target_per > 1000) target_per = 1000;
    anim_t anim_p = {0};
    anim_p.var       = &dat->progress_bar_per;
    anim_p.start     = dat->progress_bar_per;
    anim_p.end       = target_per;
    anim_p.exec_cb   = anim_cb_uint16;
    anim_p.duration  = 300;
    anim_p.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_p);
    anim_stop_all(&dat->box_permille);
    eui_int32_t delta_w = (eui_int32_t)dat->box_target_w - (eui_int32_t)dat->box_start_w;
    eui_int32_t delta_h = (eui_int32_t)dat->box_target_h - (eui_int32_t)dat->box_start_h;
    eui_uint16_t current_w = (eui_uint16_t)((eui_int32_t)dat->box_start_w + delta_w * dat->box_permille / 1000);
    eui_uint16_t current_h = (eui_uint16_t)((eui_int32_t)dat->box_start_h + delta_h * dat->box_permille / 1000);
    const Bitmap *new_bmp = page->items[focus_idx].icon;
    eui_uint16_t new_w = new_bmp ? new_bmp->w + 4 : 0;
    eui_uint16_t new_h = new_bmp ? new_bmp->h + 4 : 0;
    dat->box_start_w  = current_w;
    dat->box_start_h  = current_h;
    dat->box_target_w = new_w;
    dat->box_target_h = new_h;
    dat->box_permille = 0;
    anim_t anim_box = {0};
    anim_box.var       = &dat->box_permille;
    anim_box.start     = 0;
    anim_box.end       = 1000;
    anim_box.exec_cb   = anim_cb_uint16;
    anim_box.duration  = 400;
    anim_box.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_box);
    anim_stop_all(&dat->label_anim_y);
    anim_t anim_label = {0};
    anim_label.var       = &dat->label_anim_y;
    anim_label.start     = (eui_int16_t)canvas_h;
    anim_label.end       = (eui_int16_t)dat->label_y;
    anim_label.exec_cb   = anim_cb_int16;
    anim_label.duration  = 600;
    anim_label.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_label);

    /* Pop 恢复后启动百叶窗淡入 */
    if (old_idx == new_idx) {
        start_bmp_page_transition_anim(page);
    }
}

/**
 * @brief BMP 菜单页面切换回调
 * @param page   页面指针
 * @param action 动作指令指针
 * @note  ACT_PUSH_PAGE：首次 Push 启动完整入场动画（图片从右侧滑入、
 *        进度条从 0 增长、分割线延伸、焦点框生长、标签滑入）
 *        ACT_POP_PAGE：启动百叶窗退出动画
 */
void esgui_bmp_menu_default_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action) {
    if (page == ESGUI_NULL || action == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = page->draw_data;
    CanvasStripIter *c_it = page->render_ctx;
    eui_uint16_t canvas_w = canvas_get_width(c_it);
    eui_uint16_t canvas_h = canvas_get_height(c_it);
    if (action->act == ACT_PUSH_PAGE) {
        if (dat->first_push) {
            dat->first_push = 0;
            eui_uint16_t focus_idx = page->focus_idx;
            eui_int16_t focus_rel_x = bmp_item_rel_x(page, focus_idx);
            const Bitmap *focus_bmp = page->items[focus_idx].icon;
            eui_int16_t focus_w = focus_bmp ? focus_bmp->w : 0;
            eui_int16_t target_base = (canvas_w - focus_w) / 2 - focus_rel_x;
            eui_int16_t start_base = canvas_w;
            page->items[0].x = start_base;
            anim_t anim = {0};
            anim.var       = &page->items[0].x;
            anim.start     = start_base;
            anim.end       = target_base;
            anim.exec_cb   = anim_cb_int;
            anim.duration  = 400;
            anim.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim);
            eui_uint16_t target_per = (eui_uint16_t)(((eui_uint32_t)(focus_idx + 1) * 1000U + page->item_num / 2U) / page->item_num);
            if (target_per > 1000) target_per = 1000;
            dat->progress_bar_per = 0;
            anim_t anim_p = {0};
            anim_p.var       = &dat->progress_bar_per;
            anim_p.start     = 0;
            anim_p.end       = target_per;
            anim_p.exec_cb   = anim_cb_uint16;
            anim_p.duration  = 400;
            anim_p.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim_p);
            dat->line_len = 0;
            anim_t anim_line = {0};
            anim_line.var       = &dat->line_len;
            anim_line.start     = 0;
            anim_line.end       = canvas_w - 1;
            anim_line.exec_cb   = anim_cb_uint16;
            anim_line.duration  = 1000;
            anim_line.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim_line);
            const Bitmap *new_bmp = page->items[focus_idx].icon;
            dat->box_start_w  = 0;
            dat->box_start_h  = 0;
            dat->box_target_w = new_bmp ? new_bmp->w + 4 : 0;
            dat->box_target_h = new_bmp ? new_bmp->h + 4 : 0;
            dat->box_permille = 0;
            anim_t anim_box = {0};
            anim_box.var       = &dat->box_permille;
            anim_box.start     = 0;
            anim_box.end       = 1000;
            anim_box.exec_cb   = anim_cb_uint16;
            anim_box.duration  = 400;
            anim_box.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim_box);
            anim_stop_all(&dat->label_anim_y);
            dat->label_anim_y = (eui_int16_t)canvas_h;
            anim_t anim_label = {0};
            anim_label.var       = &dat->label_anim_y;
            anim_label.start     = (eui_int16_t)canvas_h;
            anim_label.end       = (eui_int16_t)dat->label_y;
            anim_label.exec_cb   = anim_cb_int16;
            anim_label.duration  = 400;
            anim_label.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim_label);
        }
        start_bmp_page_transition_anim(page);
    }
    else if (action->act == ACT_POP_PAGE) {
        start_bmp_page_exit_anim(page);
    }
}

/**
 * @brief BMP 菜单绘制回调
 * @param page 页面指针
 * @note  绘制顺序：
 *        1. 顶部横向进度条
 *        2. 图片（带裁剪，只绘制在图片区域内，跳过屏幕外图片）
 *        3. 焦点框（四角框，根据 box_permille 插值当前尺寸）
 *        4. 分割线（标签上方横线）
 *        5. 标签（支持标题在左下角，标签在剩余区域居中）
 *        6. 页面切换过渡遮罩
 */
void esgui_bmp_menu_defalt_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_DEFAULT_BMP_MENU_DAT *dat = page->draw_data;
    eui_uint16_t canvas_w = canvas_get_width(c_it);
    if (page->item_num > 0) {
        ESGUI_WidgetProgrssBarChangeLenPermille(c_it->canvas,
            2, 2, dat->progress_bar_h, canvas_w - 4,
            dat->progress_bar_per, ESGUI_WIDGET_PROGBAR_RIGHT);
    }
    Area bmp_clip = {
        0, (int)(dat->bmp_y - 2),
        (int)(canvas_w - 1), (int)(dat->label_y - 4)
    };
    canvas_clip_push(c_it->canvas, &bmp_clip);
    eui_int16_t base_x = page->items[0].x;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        const Bitmap *bmp = page->items[i].icon;
        if (!bmp) continue;
        eui_int16_t rel_x = bmp_item_rel_x(page, i);
        eui_int16_t x = base_x + rel_x;
        eui_int16_t y = page->items[i].y;
        eui_int16_t w = bmp->w;
        eui_int16_t h = bmp->h;
        if (x + w < 0 || x > (eui_int16_t)canvas_w) continue;
        eui_draw_bitmap(c_it->canvas, x, y, bmp, 1);
        if (i == page->focus_idx) {
            eui_int32_t d_w = (eui_int32_t)dat->box_target_w - (eui_int32_t)dat->box_start_w;
            eui_int32_t d_h = (eui_int32_t)dat->box_target_h - (eui_int32_t)dat->box_start_h;
            eui_uint16_t cur_w = (eui_uint16_t)((eui_int32_t)dat->box_start_w + d_w * dat->box_permille / 1000);
            eui_uint16_t cur_h = (eui_uint16_t)((eui_int32_t)dat->box_start_h + d_h * dat->box_permille / 1000);
            int fx = ((int)canvas_w - (int)cur_w) / 2;
            const Bitmap *focus_bmp = page->items[i].icon;
            int center_y = (int)page->items[i].y + (focus_bmp ? focus_bmp->h : 0) / 2;
            int fy = center_y - (int)cur_h / 2;
            ESGUI_WidgetBmpFocusBoxAnim(c_it->canvas, fx, fy, cur_w, cur_h);
        }
    }
    canvas_clip_pop(c_it->canvas);
    if (dat->line_len > 0) {
        eui_uint16_t sep_y = dat->label_y - 2;
        if (sep_y > dat->progress_bar_h + 2) {
            eui_draw_hline(c_it->canvas, 0, dat->line_len, sep_y, EUI_MODE_SET);
        }
    }
    {
        int label_y = dat->label_anim_y;
        int label_area_x1 = 2;
        int label_area_x2 = (int)canvas_w - 2;
        if (page->title && page->title[0]) {
            int title_w = eui_get_text_width(&ESGUI_DEFAULT_FONT, page->title);
            int title_x = 2;
            eui_draw_text_clip(c_it->canvas, title_x, dat->label_y,
                &ESGUI_DEFAULT_FONT, page->title, 1, title_w);
            label_area_x1 = title_x + title_w + 4;
            if (label_area_x1 > label_area_x2) label_area_x1 = label_area_x2;
        }
        if (page->items[page->focus_idx].label) {
            const char *label = page->items[page->focus_idx].label;
            int text_w = eui_get_text_width(&ESGUI_DEFAULT_FONT, label);
            int avail_w = label_area_x2 - label_area_x1;
            if (avail_w < 0) avail_w = 0;
            int text_x = label_area_x1 + (avail_w - text_w) / 2;
            if (text_x < label_area_x1) text_x = label_area_x1;
            eui_draw_text_clip(c_it->canvas, text_x, label_y,
                &ESGUI_DEFAULT_FONT, label, 1, avail_w);
        }
    }

    /* 页面切换过渡动画遮罩 */
    if (dat->trans_active) {
#if ESGUI_PAGE_TRANSITION_TYPE == 0
        canvas_apply_transition_mask(c_it->canvas, (eui_uint8_t)dat->trans_count);
#elif ESGUI_PAGE_TRANSITION_TYPE == 1
        canvas_apply_zoom_mask(c_it->canvas, (eui_uint8_t)dat->trans_count);
#endif
    }
}

/**
 * @brief BMP 菜单默认虚函数表
 */
static const esgui_page_vtable_t esgui_default_bmp_menu_vtable = {
    .on_create                = esgui_bmp_menu_defalt_on_create,
    .on_destroy               = esgui_bmp_menu_defalt_on_destroy,
    .on_draw                  = esgui_bmp_menu_defalt_on_draw,
    .special_item_draw        = ESGUI_NULL,
    .get_special_item_draw_w  = ESGUI_NULL,
    .on_input                 = esgui_bmp_defalt_on_input,
    .on_focus_change          = esgui_bmp_menu_defalt_on_focus_change,
    .on_page_chenge           = esgui_bmp_menu_default_on_page_change,
};

/**
 * @brief 创建默认 BMP 菜单页面
 * @param page      页面结构体指针
 * @param title     页面标题
 * @param items     条目数组（icon 字段需指向 Bitmap）
 * @param item_num  条目数量
 */
void ESGUI_DefaultBMPMenuCreate(ESGUI_MenuPage_T *page, const char *title,
                                ESGUI_MenuItem_T *items, eui_uint32_t item_num) {
    if (page == ESGUI_NULL || items == ESGUI_NULL || item_num == 0) return;
    memset(page, 0, sizeof(ESGUI_MenuPage_T));
    page->items    = items;
    page->title    = (title == ESGUI_NULL) ? "" : title;
    page->item_num = (eui_uint16_t)item_num;
    page->vtbl     = &esgui_default_bmp_menu_vtable;
}
#endif /* ESGUI_ENABLE_BMP_MENU */


/* ============================================================
 * 五.5 默认 3D 菜单
 * ============================================================
 * 仿造 BMP 菜单：布局、进度条、分割线、标签、焦点框、过渡动画一致，
 * 仅把 BMP 图片替换为 3D 线框模型；焦点模型绕 Z 轴持续旋转，
 * 模型尺寸根据屏幕自适应缩放。
 */

#if (ESGUI_ENABLE_3D_MENU && ESGUI_ENABLE_3D)

/* ---------- 5.5.1 3D 菜单静态内存池 ---------- */

static ESGUI_DEFAULT_3D_MENU_DAT s_3d_page_data_pool[ESGUI_3D_MENU_DATA_POOL_SIZE];
static eui_uint8_t s_3d_page_data_alloc_map[ESGUI_3D_MENU_DATA_POOL_SIZE] = {0};

static ESGUI_DEFAULT_3D_MENU_DAT *three_d_page_data_alloc(void)
{
    for (eui_uint8_t i = 0; i < ESGUI_3D_MENU_DATA_POOL_SIZE; i++) {
        if (s_3d_page_data_alloc_map[i] == 0) {
            s_3d_page_data_alloc_map[i] = 1;
            memset(&s_3d_page_data_pool[i], 0, sizeof(ESGUI_DEFAULT_3D_MENU_DAT));
            return &s_3d_page_data_pool[i];
        }
    }
    return ESGUI_NULL;
}

static void three_d_page_data_free(ESGUI_DEFAULT_3D_MENU_DAT *p)
{
    if (p == ESGUI_NULL) return;
    int idx = (int)(p - s_3d_page_data_pool);
    if (idx >= 0 && idx < ESGUI_3D_MENU_DATA_POOL_SIZE) {
        s_3d_page_data_alloc_map[idx] = 0;
    }
}

/* 通用动画回调：写入 eui_int32_t（焦点模型旋转角） */
static void anim_cb_int32(void *var, eui_int32_t value) {
    if (var) *((eui_int32_t *)var) = value;
}

/* 整数开平方（牛顿迭代，向下取整），供面积归一化使用 */
static eui_int32_t esgui_isqrt(eui_int32_t n)
{
    if (n <= 0) return 0;
    eui_int32_t x = n;
    eui_int32_t y = (x + 1) / 2;
    while (y < x) {
        x = y;
        y = (x + n / x) / 2;
    }
    return x;
}

/* 计算模型包围盒的“面积特征尺寸” = √(宽 × 高)（屏幕平面 x/z）
 * 使各模型屏幕包围盒面积基本一致（正方形与细长形都近似等面积） */
static eui_int32_t three_d_model_area_size(const ESGUI_3D_T *model)
{
    if (model == ESGUI_NULL || model->point_list == ESGUI_NULL || model->num_points == 0) return 0;
    eui_int32_t min_x = model->point_list[0].x, max_x = model->point_list[0].x;
    eui_int32_t min_z = model->point_list[0].z, max_z = model->point_list[0].z;
    for (eui_uint16_t i = 1; i < model->num_points; i++) {
        eui_int32_t x = model->point_list[i].x;
        eui_int32_t z = model->point_list[i].z;
        if (x < min_x) min_x = x;
        if (x > max_x) max_x = x;
        if (z < min_z) min_z = z;
        if (z > max_z) max_z = z;
    }
    eui_int32_t dim_x = max_x - min_x;
    eui_int32_t dim_z = max_z - min_z;
    return esgui_isqrt(dim_x * dim_z);
}

/* ---------- 5.5.2 过渡动画 ---------- */

static void three_d_trans_anim_ready_cb(struct anim_t *a) {
    if (!a || !a->var) return;
    ESGUI_DEFAULT_3D_MENU_DAT *dat = (ESGUI_DEFAULT_3D_MENU_DAT *)
        ((eui_uint8_t *)a->var - offsetof(ESGUI_DEFAULT_3D_MENU_DAT, trans_count));
    dat->trans_active = 0;
}

static void start_three_d_page_transition_anim(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFAULT_3D_MENU_DAT *dat = page->draw_data;
    if (dat->trans_active) return;
    anim_t anim = {0};
    anim.var       = &dat->trans_count;
    anim.start     = 8;
    anim.end       = 0;
    anim.exec_cb   = anim_cb_uint16;
    anim.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
    anim.path_type = ANIM_PATH_LINEAR;
    anim.ready_cb  = three_d_trans_anim_ready_cb;
    anim_start(&anim);
    dat->trans_active = 1;
}

static void start_three_d_page_exit_anim(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFAULT_3D_MENU_DAT *dat = page->draw_data;
    if (dat->trans_active) return;
    anim_t anim = {0};
    anim.var       = &dat->trans_count;
    anim.start     = 0;
    anim.end       = 8;
    anim.exec_cb   = anim_cb_uint16;
    anim.duration  = ESGUI_PAGE_TRANSITION_ANIM_TIME;
    anim.path_type = ANIM_PATH_LINEAR;
    anim_set_must_complete(&anim, 1);
    anim.ready_cb  = three_d_trans_anim_ready_cb;
    anim_start(&anim);
    dat->trans_active = 1;
}

/* 焦点模型绕 Z 轴持续旋转（无限循环动画） */
static void start_three_d_focus_rot_anim(ESGUI_DEFAULT_3D_MENU_DAT *dat)
{
    if (dat == ESGUI_NULL) return;
    if (anim_is_running_var(&dat->focus_rot_z)) return;  /* 已在旋转 */
    anim_t anim = {0};
    anim.var       = &dat->focus_rot_z;
    anim.start     = dat->focus_rot_z;
    anim.end       = 360;
    anim.exec_cb   = anim_cb_int32;
    anim.duration  = ESGUI_3D_DURATION;
    anim.path_type = ANIM_PATH_LINEAR;
    anim_set_repeat(&anim, 0xFFFF, false);  /* 无限单向循环 */
    anim_start(&anim);
}

/* ---------- 5.5.3 生命周期 ---------- */

void esgui_3d_menu_defalt_on_create(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    ESGUI_DEFAULT_3D_MENU_DAT *dat = three_d_page_data_alloc();
    if (dat == ESGUI_NULL) return;
    page->draw_data = dat;
    CanvasStripIter *c_it = page->render_ctx;
    eui_uint16_t canvas_h = canvas_get_height(c_it);
    dat->font_height = (eui_uint8_t)eui_get_text_height(&ESGUI_DEFAULT_FONT, "0");
    dat->progress_bar_h = ESGUI_PROGRESS_BAR_W;
    if (dat->progress_bar_h < 2) dat->progress_bar_h = 3;
    eui_uint16_t top_margin = dat->progress_bar_h + 4;
    dat->label_y = canvas_h - dat->font_height - 2;
    dat->label_anim_y = dat->label_y;
    eui_uint16_t separator_y = dat->label_y - 2;
    eui_uint16_t mid_h = (separator_y > top_margin) ? (separator_y - top_margin) : 0;
    dat->model_y = top_margin;
    dat->model_center_y = top_margin + mid_h / 2;
    dat->focal = ESGUI_3D_MENU_FOCAL;
    if (dat->focal <= 0) dat->focal = 1;
    dat->model_depth = ESGUI_3D_MENU_DEPTH;
    if (dat->model_depth <= 0) dat->model_depth = 1;
    /* 焦点框距上下分界线各 FOCUS_MARGIN px，尺寸随屏幕高度自适应；
       模型按 MODEL_SCALE% 缩放到焦点框内 */
    dat->focus_box_h = (mid_h > 2 * ESGUI_3D_MENU_FOCUS_MARGIN)
        ? (eui_uint16_t)(mid_h - 2 * ESGUI_3D_MENU_FOCUS_MARGIN)
        : mid_h;
    dat->model_display_h = (dat->focus_box_h > 0)
        ? (eui_uint16_t)((eui_uint32_t)dat->focus_box_h * ESGUI_3D_MENU_MODEL_SCALE / 100)
        : dat->focus_box_h;
    dat->slot_w = dat->model_display_h + ESGUI_3D_MENU_ITEM_GAP;
    page->items[0].x = 0;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        if (i >= ESGUI_3D_MENU_MAX_ITEMS) break;
        const ESGUI_3D_T *model = (const ESGUI_3D_T *)page->items[i].icon;
        eui_int32_t model_size = three_d_model_area_size(model);
        eui_int32_t scale = 256;
        if (model_size > 0 && dat->model_display_h > 0) {
            scale = (eui_int32_t)(((int64_t)dat->model_display_h * 256 * dat->model_depth) /
                                  ((int64_t)model_size * dat->focal));
            if (scale <= 0) scale = 256;
        }
        dat->item_scale_q8[i] = scale;
        page->items[i].y = dat->model_y;
        if (i > 0) {
            page->items[i].x = (int)i * (int)dat->slot_w;
        }
    }
    dat->progress_bar_per = 0;
    dat->line_len = 0;
    dat->box_permille = 0;
    dat->box_start_w = 0;
    dat->box_start_h = 0;
    dat->box_target_w = 0;
    dat->box_target_h = 0;
    dat->trans_count = 0;
    dat->trans_active = 0;
    dat->first_push = 1;
    dat->focus_rot_z = 0;
}

void esgui_3d_menu_defalt_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_DEFAULT_3D_MENU_DAT *dat = page->draw_data;
    if (dat != ESGUI_NULL) {
        anim_stop_all(&page->items[0].x);
        anim_stop_all(&dat->progress_bar_per);
        anim_stop_all(&dat->line_len);
        anim_stop_all(&dat->label_anim_y);
        anim_stop_all(&dat->box_permille);
        anim_stop_all(&dat->trans_count);
        anim_stop_all(&dat->focus_rot_z);
        three_d_page_data_free(dat);
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}

/* ---------- 5.5.4 输入与焦点变化 ---------- */

ESGUI_MenuAction_T esgui_3d_menu_defalt_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e)
{
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    ESGUI_DEFAULT_3D_MENU_DAT *dat = page->draw_data;
    if (dat && dat->trans_active) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};

    eui_uint16_t old_focus_idx = page->focus_idx;
    switch (e) {
        case EVT_KEY_UP:
        case EVT_KEY_RIGHT:
            FocusUP(page->focus_idx, page->item_num);
            break;
        case EVT_KEY_DOWN:
        case EVT_KEY_LEFT:
            FocusDOWN(page->focus_idx);
            break;
        case EVT_KEY_OK:
        case EVT_CLICKED:
            if (page->items[page->focus_idx].on_enter) {
                return page->items[page->focus_idx].on_enter(page, page->items[page->focus_idx].arg);
            }
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
        case EVT_KEY_BACK:
            return (ESGUI_MenuAction_T){ACT_POP_PAGE, ESGUI_NULL};
        default:
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    }
    if (old_focus_idx != page->focus_idx) {
        if (page->vtbl->on_focus_change) {
            page->vtbl->on_focus_change(page, old_focus_idx, page->focus_idx);
        }
        return (ESGUI_MenuAction_T){ACT_REFRESH, ESGUI_NULL};
    }
    return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
}

void esgui_3d_menu_defalt_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx) {
    (void)old_idx;
    (void)new_idx;
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    ESGUI_DEFAULT_3D_MENU_DAT *dat = page->draw_data;
    CanvasStripIter *c_it = page->render_ctx;
    eui_uint16_t canvas_w = canvas_get_width(c_it);
    eui_uint16_t canvas_h = canvas_get_height(c_it);
    eui_uint16_t focus_idx = page->focus_idx;
    eui_int16_t focus_rel_x = bmp_item_rel_x(page, focus_idx);
    eui_int16_t target_base = (canvas_w - (eui_int16_t)dat->slot_w) / 2 - focus_rel_x;
    anim_t anim = {0};
    anim.var       = &page->items[0].x;
    anim.start     = page->items[0].x;
    anim.end       = target_base;
    anim.exec_cb   = anim_cb_int;
    anim.duration  = 300;
    anim.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim);
    eui_uint16_t target_per = (eui_uint16_t)(((eui_uint32_t)(focus_idx + 1) * 1000U + page->item_num / 2U) / page->item_num);
    if (target_per > 1000) target_per = 1000;
    anim_t anim_p = {0};
    anim_p.var       = &dat->progress_bar_per;
    anim_p.start     = dat->progress_bar_per;
    anim_p.end       = target_per;
    anim_p.exec_cb   = anim_cb_uint16;
    anim_p.duration  = 300;
    anim_p.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_p);
    anim_stop_all(&dat->box_permille);
    eui_int32_t delta_w = (eui_int32_t)dat->box_target_w - (eui_int32_t)dat->box_start_w;
    eui_int32_t delta_h = (eui_int32_t)dat->box_target_h - (eui_int32_t)dat->box_start_h;
    eui_uint16_t current_w = (eui_uint16_t)((eui_int32_t)dat->box_start_w + delta_w * dat->box_permille / 1000);
    eui_uint16_t current_h = (eui_uint16_t)((eui_int32_t)dat->box_start_h + delta_h * dat->box_permille / 1000);
    eui_uint16_t new_w = dat->focus_box_h;
    eui_uint16_t new_h = dat->focus_box_h;
    dat->box_start_w  = current_w;
    dat->box_start_h  = current_h;
    dat->box_target_w = new_w;
    dat->box_target_h = new_h;
    dat->box_permille = 0;
    anim_t anim_box = {0};
    anim_box.var       = &dat->box_permille;
    anim_box.start     = 0;
    anim_box.end       = 1000;
    anim_box.exec_cb   = anim_cb_uint16;
    anim_box.duration  = 400;
    anim_box.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_box);
    anim_stop_all(&dat->label_anim_y);
    anim_t anim_label = {0};
    anim_label.var       = &dat->label_anim_y;
    anim_label.start     = (eui_int16_t)canvas_h;
    anim_label.end       = (eui_int16_t)dat->label_y;
    anim_label.exec_cb   = anim_cb_int16;
    anim_label.duration  = 600;
    anim_label.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_label);

    /* 焦点模型绕 Z 轴持续旋转 */
    start_three_d_focus_rot_anim(dat);

    if (old_idx == new_idx) {
        start_three_d_page_transition_anim(page);
    }
}

void esgui_3d_menu_default_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action) {
    if (page == ESGUI_NULL || action == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    ESGUI_DEFAULT_3D_MENU_DAT *dat = page->draw_data;
    CanvasStripIter *c_it = page->render_ctx;
    eui_uint16_t canvas_w = canvas_get_width(c_it);
    eui_uint16_t canvas_h = canvas_get_height(c_it);
    if (action->act == ACT_PUSH_PAGE) {
        if (dat->first_push) {
            dat->first_push = 0;
            eui_uint16_t focus_idx = page->focus_idx;
            eui_int16_t focus_rel_x = bmp_item_rel_x(page, focus_idx);
            eui_int16_t target_base = (canvas_w - (eui_int16_t)dat->slot_w) / 2 - focus_rel_x;
            eui_int16_t start_base = canvas_w;
            page->items[0].x = start_base;
            anim_t anim = {0};
            anim.var       = &page->items[0].x;
            anim.start     = start_base;
            anim.end       = target_base;
            anim.exec_cb   = anim_cb_int;
            anim.duration  = 400;
            anim.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim);
            eui_uint16_t target_per = (eui_uint16_t)(((eui_uint32_t)(focus_idx + 1) * 1000U + page->item_num / 2U) / page->item_num);
            if (target_per > 1000) target_per = 1000;
            dat->progress_bar_per = 0;
            anim_t anim_p = {0};
            anim_p.var       = &dat->progress_bar_per;
            anim_p.start     = 0;
            anim_p.end       = target_per;
            anim_p.exec_cb   = anim_cb_uint16;
            anim_p.duration  = 400;
            anim_p.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim_p);
            dat->line_len = 0;
            anim_t anim_line = {0};
            anim_line.var       = &dat->line_len;
            anim_line.start     = 0;
            anim_line.end       = canvas_w - 1;
            anim_line.exec_cb   = anim_cb_uint16;
            anim_line.duration  = 1000;
            anim_line.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim_line);
            dat->box_start_w  = 0;
            dat->box_start_h  = 0;
            dat->box_target_w = dat->focus_box_h;
            dat->box_target_h = dat->focus_box_h;
            dat->box_permille = 0;
            anim_t anim_box = {0};
            anim_box.var       = &dat->box_permille;
            anim_box.start     = 0;
            anim_box.end       = 1000;
            anim_box.exec_cb   = anim_cb_uint16;
            anim_box.duration  = 400;
            anim_box.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim_box);
            anim_stop_all(&dat->label_anim_y);
            dat->label_anim_y = (eui_int16_t)canvas_h;
            anim_t anim_label = {0};
            anim_label.var       = &dat->label_anim_y;
            anim_label.start     = (eui_int16_t)canvas_h;
            anim_label.end       = (eui_int16_t)dat->label_y;
            anim_label.exec_cb   = anim_cb_int16;
            anim_label.duration  = 400;
            anim_label.path_type = ANIM_PATH_EASE_OUT;
            anim_start(&anim_label);
        }
        start_three_d_page_transition_anim(page);
        start_three_d_focus_rot_anim(dat);
    }
    else if (action->act == ACT_POP_PAGE) {
        start_three_d_page_exit_anim(page);
    }
}

/* ---------- 5.5.5 绘制 ---------- */

void esgui_3d_menu_defalt_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_DEFAULT_3D_MENU_DAT *dat = page->draw_data;
    eui_uint16_t canvas_w = canvas_get_width(c_it);
    eui_uint16_t canvas_h = canvas_get_height(c_it);
    if (page->item_num > 0) {
        ESGUI_WidgetProgrssBarChangeLenPermille(c_it->canvas,
            2, 2, dat->progress_bar_h, canvas_w - 4,
            dat->progress_bar_per, ESGUI_WIDGET_PROGBAR_RIGHT);
    }
    Area bmp_clip = {
        0, (int)(dat->model_y - 2),
        (int)(canvas_w - 1), (int)(dat->label_y - 4)
    };
    canvas_clip_push(c_it->canvas, &bmp_clip);
    eui_int16_t base_x = page->items[0].x;
    eui_int32_t cx = canvas_w / 2;
    eui_int32_t cy = canvas_h / 2;
    eui_int32_t depth = dat->model_depth;
    eui_int32_t focal = dat->focal;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        const ESGUI_3D_T *model = (const ESGUI_3D_T *)page->items[i].icon;
        if (model == ESGUI_NULL) continue;
        eui_int16_t rel_x = bmp_item_rel_x(page, i);
        eui_int16_t x = base_x + rel_x;
        eui_int32_t target_x = (eui_int32_t)x + dat->slot_w / 2;
        eui_int32_t target_y = dat->model_center_y;
        /* 透视反算平移量（模型中心 → 屏幕目标位置） */
        eui_int32_t tx = (eui_int32_t)(((int64_t)(target_x - cx) * depth) / focal);
        eui_int32_t tz = (eui_int32_t)(((int64_t)(cy - target_y) * depth) / focal);
        ESGUI_3DTransform_T t;
        ESGUI_3DTransformInit(&t);
        t.tx = tx;
        t.ty = depth;
        t.tz = tz;
        t.scale_q8 = (i < ESGUI_3D_MENU_MAX_ITEMS) ? dat->item_scale_q8[i] : 256;
        if (i == page->focus_idx) {
            ESGUI_3DTransformSetRot(&t, ESGUI_3D_AXIS_Z, dat->focus_rot_z);
        }
        ESGUI_3DWireframeDiagram(c_it->canvas, model, &t, focal, canvas_w, canvas_h, EUI_MODE_SET);
        if (i == page->focus_idx) {
            eui_int32_t d_w = (eui_int32_t)dat->box_target_w - (eui_int32_t)dat->box_start_w;
            eui_int32_t d_h = (eui_int32_t)dat->box_target_h - (eui_int32_t)dat->box_start_h;
            eui_uint16_t cur_w = (eui_uint16_t)((eui_int32_t)dat->box_start_w + d_w * dat->box_permille / 1000);
            eui_uint16_t cur_h = (eui_uint16_t)((eui_int32_t)dat->box_start_h + d_h * dat->box_permille / 1000);
            int fx = ((int)canvas_w - (int)cur_w) / 2;
            int fy = (int)dat->model_center_y - (int)cur_h / 2;
            ESGUI_WidgetBmpFocusBoxAnim(c_it->canvas, fx, fy, cur_w, cur_h);
        }
    }
    canvas_clip_pop(c_it->canvas);
    if (dat->line_len > 0) {
        eui_uint16_t sep_y = dat->label_y - 2;
        if (sep_y > dat->progress_bar_h + 2) {
            eui_draw_hline(c_it->canvas, 0, dat->line_len, sep_y, EUI_MODE_SET);
        }
    }
    {
        int label_y = dat->label_anim_y;
        int label_area_x1 = 2;
        int label_area_x2 = (int)canvas_w - 2;
        if (page->title && page->title[0]) {
            int title_w = eui_get_text_width(&ESGUI_DEFAULT_FONT, page->title);
            int title_x = 2;
            eui_draw_text_clip(c_it->canvas, title_x, dat->label_y,
                &ESGUI_DEFAULT_FONT, page->title, 1, title_w);
            label_area_x1 = title_x + title_w + 4;
            if (label_area_x1 > label_area_x2) label_area_x1 = label_area_x2;
        }
        if (page->items[page->focus_idx].label) {
            const char *label = page->items[page->focus_idx].label;
            int text_w = eui_get_text_width(&ESGUI_DEFAULT_FONT, label);
            int avail_w = label_area_x2 - label_area_x1;
            if (avail_w < 0) avail_w = 0;
            int text_x = label_area_x1 + (avail_w - text_w) / 2;
            if (text_x < label_area_x1) text_x = label_area_x1;
            eui_draw_text_clip(c_it->canvas, text_x, label_y,
                &ESGUI_DEFAULT_FONT, label, 1, avail_w);
        }
    }
    if (dat->trans_active) {
#if ESGUI_PAGE_TRANSITION_TYPE == 0
        canvas_apply_transition_mask(c_it->canvas, (eui_uint8_t)dat->trans_count);
#elif ESGUI_PAGE_TRANSITION_TYPE == 1
        canvas_apply_zoom_mask(c_it->canvas, (eui_uint8_t)dat->trans_count);
#endif
    }
}

/* ---------- 5.5.6 虚函数表与创建 ---------- */

static const esgui_page_vtable_t esgui_default_3d_menu_vtable = {
    .on_create                = esgui_3d_menu_defalt_on_create,
    .on_destroy               = esgui_3d_menu_defalt_on_destroy,
    .on_draw                  = esgui_3d_menu_defalt_on_draw,
    .special_item_draw        = ESGUI_NULL,
    .get_special_item_draw_w  = ESGUI_NULL,
    .on_input                 = esgui_3d_menu_defalt_on_input,
    .on_focus_change          = esgui_3d_menu_defalt_on_focus_change,
    .on_page_chenge           = esgui_3d_menu_default_on_page_change,
};

void ESGUI_Default3DMenuCreate(ESGUI_MenuPage_T *page, const char *title,
                               ESGUI_MenuItem_T *items, eui_uint32_t item_num) {
    if (page == ESGUI_NULL || items == ESGUI_NULL || item_num == 0) return;
    memset(page, 0, sizeof(ESGUI_MenuPage_T));
    page->items    = items;
    page->title    = (title == ESGUI_NULL) ? "" : title;
    page->item_num = (eui_uint16_t)item_num;
    page->vtbl     = &esgui_default_3d_menu_vtable;
}

#endif /* (ESGUI_ENABLE_3D_MENU && ESGUI_ENABLE_3D) */


/* ============================================================
 * 六、弹窗部分
 * ============================================================
 * 所有弹窗共享一个 Union 内存池（同一时间只能显示一个弹窗）。
 * 弹窗支持 must_complete 的窗口位移动画，确保动画完成前不销毁。
 */

#if (ESGUI_ENABLE_POPUP_MESSAGE || ESGUI_ENABLE_POPUP_BOOL || ESGUI_ENABLE_POPUP_VALUE || ESGUI_ENABLE_POPUP_TEXTLIST || ESGUI_ENABLE_POPUP_BMPLIST)
/**
 * @brief 启动弹窗窗口位移动画
 * @param window    弹窗指针
 * @param y_sta     起始 Y 坐标
 * @param y_end     目标 Y 坐标
 * @param duration  动画持续时间（毫秒）
 * @param path_type 缓动曲线类型
 * @note  设置 must_complete=1，确保动画完成前页面控制器不销毁弹窗。
 *        用于弹窗的入场（从屏幕上方滑入）和退场（滑出屏幕上方）。
 */
static void start_popwindow_window_anim(ESGUI_PopWindow_T *window,int y_sta,int y_end,eui_uint32_t duration,anim_path_type_t path_type) {
    if (window == ESGUI_NULL) return;
    anim_t anim = {0};
    anim.var       = &window->window_y;
    anim.start     = y_sta;
    anim.end       = y_end;
    anim.exec_cb   = anim_cb_int;
    anim.duration  = duration;
    anim.path_type = path_type;
    anim_set_must_complete(&anim,1);
    anim_start(&anim);
}
#endif


/* ---------- 6.1 消息弹窗 ---------- */

#if ESGUI_ENABLE_POPUP_MESSAGE

/**
 * @brief 消息弹窗私有数据
 */
typedef struct esgui_default_message_window_dat {
    eui_uint16_t text_len;      /**< OK 按钮文本宽度 */
    eui_uint16_t font_height;   /**< 字体高度 */
    eui_uint8_t button_en;      /**< 是否显示 OK 按钮 */
    eui_uint16_t title_len;     /**< 标题文本宽度（滚动标题用） */
    eui_int16_t  title_scroll_x;/**< 标题滚动当前 X 偏移（滚动标题用） */
} ESGUI_DEFAULT_MESSAGE_WINDOW_DAT;

/**
 * @brief 消息弹窗创建回调
 * @param page 页面指针（实际为 ESGUI_PopWindow_T*）
 * @note  计算窗口水平居中位置，测量 OK 按钮文本宽度。
 */
void esgui_default_message_popwindow_on_create(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_DEFAULT_MESSAGE_WINDOW_DAT *data = (ESGUI_DEFAULT_MESSAGE_WINDOW_DAT*)window->draw_data;
    if (data == ESGUI_NULL) return;
    data->font_height = eui_get_text_height(&ESGUI_DEFAULT_FONT,"0");
    window->window_x = (canvas_get_width(c_it) - window->window_w) / 2;
    data->text_len = eui_get_text_width(&ESGUI_DEFAULT_FONT,"OK");
}

/**
 * @brief 消息弹窗销毁回调
 * @param page 页面指针
 */
void esgui_default_message_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    if (window->draw_data != ESGUI_NULL){
        popup_data_free();
        window->draw_data = ESGUI_NULL;
    }
    window->render_ctx = ESGUI_NULL;
}

/**
 * @brief 消息弹窗绘制回调
 * @param page 页面指针
 * @note  绘制圆角矩形边框、标题文本、可选的 OK 按钮和焦点框。
 */
void esgui_default_message_popwindow_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_MESSAGE_WINDOW_DAT *data = window->draw_data;
    if (data == ESGUI_NULL) return;
    Area a = {window->window_x, window->window_y,window->window_x+window->window_w,window->window_y+window->window_h};
    canvas_clip_push(c_it->canvas,&a);
    eui_draw_round_rect_box(c_it->canvas,window->window_x, window->window_y,window->window_x+window->window_w,window->window_y+window->window_h,5,EUI_MODE_SET);
    eui_draw_text(c_it->canvas,window->window_x+5,window->window_y+5,&ESGUI_DEFAULT_FONT,window->title,EUI_MODE_SET);
    if (data->button_en) {
        int x = (window->window_w - data->text_len) / 2 + window->window_x;
        int y = window->window_y + window->window_h - 15;
        eui_draw_text(c_it->canvas,x,y,
            &ESGUI_DEFAULT_FONT,"OK",EUI_MODE_SET);
        ESGUI_WidgetTextFocusBox(c_it->canvas,x,y,data->font_height,data->text_len);
    }
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief 消息弹窗输入处理
 * @param page 页面指针
 * @param e    事件码
 * @return ACT_CLOSE_POPUP（任何按键都关闭弹窗）
 */
ESGUI_MenuAction_T esgui_default_message_popwindow_on_input(ESGUI_MenuPage_T *page,ESGUI_EventCode_t e) {
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    switch (e) {
        case EVT_KEY_OK:
        case EVT_CLICKED:
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        case EVT_KEY_BACK:
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        default:
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    }
}

/**
 * @brief 消息弹窗页面切换回调
 * @param page   页面指针
 * @param action 动作指令
 * @note  SHOW：从屏幕上方 Overshoot 滑入
 *        CLOSE：向屏幕上方 EaseInOut 滑出
 */
void esgui_default_message_popwindow_on_page_change(ESGUI_MenuPage_T *page,ESGUI_MenuAction_T *action) {
    if (page == ESGUI_NULL || action == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    CanvasStripIter *c_it = window->render_ctx;
    switch (action->act) {
        case ACT_SHOW_POPUP:
            start_popwindow_window_anim(window,0 - window->window_h - 10,(canvas_get_height(c_it) - window->window_h) / 2,400,ANIM_PATH_OVERSHOOT);
            break;
        case ACT_CLOSE_POPUP:
            start_popwindow_window_anim(window,window->window_y,0 - window->window_h - 10,400,ANIM_PATH_EASE_IN_OUT);
            break;
        default:
            break;
    }
}

/**
 * @brief 消息弹窗默认虚函数表
 */
static const esgui_page_vtable_t message_popwindow_vtable = {
    .on_create = esgui_default_message_popwindow_on_create,
    .on_destroy = esgui_default_message_popwindow_on_destroy,
    .on_draw = esgui_default_message_popwindow_on_draw,
    .special_item_draw = ESGUI_NULL,
    .get_special_item_draw_w = ESGUI_NULL,
    .on_input = esgui_default_message_popwindow_on_input,
    .on_focus_change = ESGUI_NULL,
    .on_page_chenge = esgui_default_message_popwindow_on_page_change,
};

/**
 * @brief 创建消息弹窗
 * @param window     弹窗结构体指针
 * @param message    消息文本（标题）
 * @param window_w   弹窗宽度
 * @param window_h   弹窗高度
 * @param button_en  是否显示 OK 按钮
 */
void ESGUI_DefaultMessagePopWindowCreate(ESGUI_PopWindow_T *window,const char* message,eui_uint16_t window_w,eui_uint16_t window_h,bool button_en) {
    if (window == ESGUI_NULL) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl = &message_popwindow_vtable;
    window->title = (message == ESGUI_NULL) ? "" : message;
    window->window_w = window_w;
    window->window_h = window_h;
    ESGUI_DEFAULT_MESSAGE_WINDOW_DAT *dat = popup_data_alloc();
    if (dat != ESGUI_NULL) {
        dat->button_en = button_en;
    }
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_MESSAGE */






#if ESGUI_ENABLE_POPUP_MESSAGE_SCROLL_TITLE || ESGUI_ENABLE_POPUP_BOOL_SCROLL_TITLE ||  \
    ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE || ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE   ||\
ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE
/**
 * @brief 启动弹窗标题水平滚动动画
 * @param window         弹窗指针
 * @param title_scroll_x 指向标题滚动 X 偏移的指针
 * @param title_len      标题文本宽度（像素）
 * @note  当标题长度超过弹窗宽度减去 2*ESGUI_POPUP_TITLE_SCROLL_MARGIN 时启动。
 *        使用线性曲线，无限循环，延迟 400ms 后开始。
 */
static void start_popup_title_scroll_anim(ESGUI_PopWindow_T *window, eui_int16_t *title_scroll_x, eui_uint16_t title_len)
{
    if (window == ESGUI_NULL || title_scroll_x == ESGUI_NULL) return;
    eui_int16_t max_w = (eui_int16_t)window->window_w - 2 * (eui_int16_t)ESGUI_POPUP_TITLE_SCROLL_MARGIN;
    if (max_w <= 0 || (eui_int16_t)title_len <= max_w) return;
    anim_t anim = {0};
    anim.var        = title_scroll_x;
    anim.start      = ESGUI_POPUP_TITLE_SCROLL_MARGIN;
    anim.end        = -(eui_int32_t)title_len - (eui_int32_t)ESGUI_LONG_TEXT_GAP;
    anim.exec_cb    = anim_cb_int16;
    anim.duration   = 4500;
    anim.path_type  = ANIM_PATH_LINEAR;
    anim.repeat_cnt = 0xFFFF;
    anim.delay      = 400;
    anim_start(&anim);
}

/**
 * @brief 绘制弹窗滚动标题（两段循环实现）
 * @param c_it      Canvas 迭代器指针
 * @param window    弹窗指针
 * @param data      弹窗私有数据（需包含 title_len 和 title_scroll_x）
 * @param title_len 标题文本宽度
 * @param title_scroll_x 标题滚动当前 X 偏移
 * @note  在弹窗裁剪区内绘制，支持超长标题循环滚动。
 */
static void draw_popup_scrolling_title(CanvasStripIter *c_it, ESGUI_PopWindow_T *window,
    eui_uint16_t title_len, eui_int16_t title_scroll_x)
{
    if (c_it == ESGUI_NULL || window == ESGUI_NULL || !window->title || !window->title[0]) return;
    eui_int16_t margin = ESGUI_POPUP_TITLE_SCROLL_MARGIN;
    eui_int16_t y = window->window_y + margin;
    eui_int16_t max_w = (eui_int16_t)window->window_w - 2 * margin;

    if (max_w <= 0) return;

    if ((eui_int16_t)title_len <= max_w) {
        /* 标题不需要滚动：左对齐绘制 */
        eui_draw_text_clip(c_it->canvas,
            window->window_x + margin, y,
            &ESGUI_DEFAULT_FONT, window->title, EUI_MODE_SET, max_w);
        return;
    }

    /* 第一段文本 */
    eui_int16_t abs_x = (title_scroll_x < 0) ? -title_scroll_x : title_scroll_x;
    eui_int16_t w1 = max_w + abs_x - margin;
    if (w1 > (eui_int16_t)title_len) w1 = (eui_int16_t)title_len;
    if (w1 < 0) w1 = 0;
    eui_draw_text_clip(c_it->canvas,
        window->window_x + title_scroll_x, y,
        &ESGUI_DEFAULT_FONT, window->title, EUI_MODE_SET, w1);

    /* 第二段（循环衔接） */
    eui_int32_t text_plus_x = (eui_int32_t)title_len + (eui_int32_t)title_scroll_x;
    eui_int16_t text_area_right = (eui_int16_t)window->window_w - margin;
    eui_int16_t remain = text_area_right - (eui_int16_t)text_plus_x;
    if (remain >= (eui_int16_t)ESGUI_LONG_TEXT_GAP) {
        eui_int16_t X2 = title_scroll_x + (eui_int16_t)title_len + (eui_int16_t)ESGUI_LONG_TEXT_GAP + 2;
        eui_int16_t w2 = text_area_right - X2;
        if (w2 > (eui_int16_t)title_len) w2 = (eui_int16_t)title_len;
        if (w2 < 0) w2 = 0;
        eui_draw_text_clip(c_it->canvas,
            window->window_x + X2, y,
            &ESGUI_DEFAULT_FONT, window->title, EUI_MODE_SET, w2);
    }
}

#endif






/* ---------- 6.1b 消息弹窗滚动标题版本 ---------- */

#if ESGUI_ENABLE_POPUP_MESSAGE_SCROLL_TITLE

/**
 * @brief 消息弹窗滚动标题版本创建回调
 * @note  复用原版创建逻辑，额外计算标题宽度并启动滚动动画。
 */
void esgui_default_message_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page) {
    esgui_default_message_popwindow_on_create(page);
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_MESSAGE_WINDOW_DAT *data = window->draw_data;
    if (data == ESGUI_NULL || !window->title || !window->title[0]) return;
    data->title_len = (eui_uint16_t)eui_get_text_width(&ESGUI_DEFAULT_FONT, window->title);
    data->title_scroll_x = ESGUI_POPUP_TITLE_SCROLL_MARGIN;
    start_popup_title_scroll_anim(window, &data->title_scroll_x, data->title_len);
}

/**
 * @brief 消息弹窗滚动标题版本绘制回调
 * @note  使用 draw_popup_scrolling_title 替代固定文本绘制，其余与原版一致。
 */
void esgui_default_message_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_MESSAGE_WINDOW_DAT *data = window->draw_data;
    if (data == ESGUI_NULL) return;
    Area a = {window->window_x, window->window_y, window->window_x + window->window_w, window->window_y + window->window_h};
    canvas_clip_push(c_it->canvas, &a);
    eui_draw_round_rect_box(c_it->canvas, window->window_x, window->window_y,
        window->window_x + window->window_w, window->window_y + window->window_h, 5, EUI_MODE_SET);
    draw_popup_scrolling_title(c_it, window, data->title_len, data->title_scroll_x);
    if (data->button_en) {
        int x = (window->window_w - data->text_len) / 2 + window->window_x;
        int y = window->window_y + window->window_h - 15;
        eui_draw_text(c_it->canvas, x, y, &ESGUI_DEFAULT_FONT, "OK", EUI_MODE_SET);
        ESGUI_WidgetTextFocusBox(c_it->canvas, x, y, data->font_height, data->text_len);
    }
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief 消息弹窗滚动标题版本销毁回调
 * @note  先停止标题滚动动画，再释放弹窗数据，防止动画写入已释放内存。
 */
void esgui_default_message_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    if (window->draw_data != ESGUI_NULL) {
        ESGUI_DEFAULT_MESSAGE_WINDOW_DAT *dat = window->draw_data;
        anim_stop_all(&dat->title_scroll_x);
        popup_data_free();
        window->draw_data = ESGUI_NULL;
    }
    window->render_ctx = ESGUI_NULL;
}

static const esgui_page_vtable_t message_scroll_title_popwindow_vtable = {
    .on_create = esgui_default_message_scroll_title_popwindow_on_create,
    .on_destroy = esgui_default_message_scroll_title_popwindow_on_destroy,
    .on_draw = esgui_default_message_scroll_title_popwindow_on_draw,
    .special_item_draw = ESGUI_NULL,
    .get_special_item_draw_w = ESGUI_NULL,
    .on_input = esgui_default_message_popwindow_on_input,
    .on_focus_change = ESGUI_NULL,
    .on_page_chenge = esgui_default_message_popwindow_on_page_change,
};

/**
 * @brief 创建消息弹窗滚动标题版本
 */
void ESGUI_DefaultMessageScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char* message,
    eui_uint16_t window_w, eui_uint16_t window_h, bool button_en) {
    if (window == ESGUI_NULL) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl = &message_scroll_title_popwindow_vtable;
    window->title = (message == ESGUI_NULL) ? "" : message;
    window->window_w = window_w;
    window->window_h = window_h;
    ESGUI_DEFAULT_MESSAGE_WINDOW_DAT *dat = popup_data_alloc();
    if (dat != ESGUI_NULL) {
        dat->button_en = button_en;
    }
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_MESSAGE_SCROLL_TITLE */


/* ---------- 6.2 布尔弹窗 ---------- */

#if ESGUI_ENABLE_POPUP_BOOL

/**
 * @brief 布尔弹窗私有数据
 */
typedef struct esgui_default_bool_wondow_dat {
    bool *val;              /**< 绑定的布尔变量指针 */
    eui_uint16_t text1_len;     /**< OK 文本宽度 */
    eui_uint16_t text2_len;     /**< Cancel 文本宽度 */
    eui_uint16_t font_height;   /**< 字体高度 */
    eui_uint16_t focus_x;       /**< 焦点框当前 X 坐标 */
    eui_uint16_t focus_w;       /**< 焦点框当前宽度 */
    eui_uint16_t title_len;     /**< 标题文本宽度（滚动标题用） */
    eui_int16_t  title_scroll_x;/**< 标题滚动当前 X 偏移（滚动标题用） */
} ESGUI_DEFAULT_BOOL_WONDOW_DAT;

/**
 * @brief 启动布尔弹窗焦点框动画
 * @param page     弹窗指针
 * @param w        目标宽度
 * @param x        目标 X 坐标
 * @param duration 动画持续时间
 */
static void start_popxindow_focus_box_anim(ESGUI_PopWindow_T *page, eui_int16_t w, eui_int16_t x, eui_uint32_t duration)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT* data = page->draw_data;
    anim_t anim_w = {0};
    anim_t anim_x = {0};
    anim_w.var       = &data->focus_w;
    anim_w.start     = data->focus_w;
    anim_w.end       = w;
    anim_w.exec_cb   = anim_cb_int16;
    anim_w.duration  = duration;
    anim_w.path_type = ANIM_PATH_EASE_OUT;
    anim_x.var       = &data->focus_x;
    anim_x.start     = data->focus_x;
    anim_x.end       = x;
    anim_x.exec_cb   = anim_cb_int16;
    anim_x.duration  = duration;
    anim_x.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_w);
    anim_start(&anim_x);
}

/**
 * @brief 布尔弹窗确定回调
 * @param page 页面指针
 * @param arg  用户参数（未使用）
 * @return ACT_NONE（由 on_input 负责关闭弹窗）
 * @note  根据 focus_idx 设置 *val：0=OK(1)，1=Cancel(0)
 */
static ESGUI_MenuAction_T esgui_default_bool_popwindow_on_enter(ESGUI_MenuPage_T *page, void *arg) {
    (void)arg;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *data = (ESGUI_DEFAULT_BOOL_WONDOW_DAT*)window->draw_data;
    if (data && data->val) {
        *data->val = (window->focus_idx == 0) ? 1 : 0;
    }
    return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
}

/**
 * @brief 布尔弹窗默认条目（OK / Cancel）
 * @note  静态全局数组，所有布尔弹窗共享同一组条目。
 *        实际文本在 on_create 中重新测量。
 */
static ESGUI_MenuItem_T bool_popwindow_items[] = {
    {0,0,"OK",ESGUI_NULL,esgui_default_bool_popwindow_on_enter,ESGUI_NULL},
    {0,0,"Cancel ",ESGUI_NULL,esgui_default_bool_popwindow_on_enter,ESGUI_NULL},
};

/**
 * @brief 布尔弹窗创建回调
 * @param page 页面指针
 * @note  计算窗口居中、按钮位置、文本宽度。
 */
void esgui_default_bool_popwindow_on_create(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *data = (ESGUI_DEFAULT_BOOL_WONDOW_DAT*)window->draw_data;
    if (data == ESGUI_NULL) return;
    data->font_height = eui_get_text_height(&ESGUI_DEFAULT_FONT,"0");
    data->text1_len = eui_get_text_width(&ESGUI_DEFAULT_FONT,page->items[0].label);
    data->text2_len = eui_get_text_width(&ESGUI_DEFAULT_FONT,page->items[1].label);
    window->window_x = (canvas_get_width(c_it) - window->window_w) / 2;
    window->items[0].x = (window->window_w - data->text1_len - data->text2_len - ESGUI_BOOL_POPWINDOW_TEXT_GAP) / 2 + window->window_x;
    window->items[1].x = window->items[0].x + data->text1_len + ESGUI_BOOL_POPWINDOW_TEXT_GAP;
}

/**
 * @brief 布尔弹窗销毁回调
 * @param page 页面指针
 */
void esgui_default_bool_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    if (window->draw_data != ESGUI_NULL){
        ESGUI_DEFAULT_BOOL_WONDOW_DAT *dat = window->draw_data;
        anim_stop_all(&dat->focus_w);
        anim_stop_all(&dat->focus_x);
        popup_data_free();
        window->draw_data = ESGUI_NULL;
    }
    window->render_ctx = ESGUI_NULL;
}

/**
 * @brief 布尔弹窗输入处理
 * @param page 页面指针
 * @param e    事件码
 * @return 动作指令
 * @note  左右切换焦点，OK 触发 on_enter 后关闭弹窗，BACK 直接关闭。
 */
ESGUI_MenuAction_T esgui_default_bool_popwindow_on_input(ESGUI_MenuPage_T *page,ESGUI_EventCode_t e) {
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    eui_uint16_t old_focus_idx = page->focus_idx;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *data = (ESGUI_DEFAULT_BOOL_WONDOW_DAT*)page->draw_data;
    switch (e) {
        case EVT_KEY_UP:
        case EVT_KEY_RIGHT:
            FocusUP(page->focus_idx, page->item_num);
            break;
        case EVT_KEY_DOWN:
        case EVT_KEY_LEFT:
            FocusDOWN(page->focus_idx);
            break;
        case EVT_KEY_OK:
        case EVT_CLICKED:
            if (page->items[page->focus_idx].on_enter) {
                page->items[page->focus_idx].on_enter(page, page->items[page->focus_idx].arg);
            }
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        case EVT_KEY_BACK:
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        default:
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    }
    if (old_focus_idx != page->focus_idx) {
        if (page->vtbl->on_focus_change) {
            page->vtbl->on_focus_change(page, old_focus_idx, page->focus_idx);
        }
        return (ESGUI_MenuAction_T){ACT_REFRESH, ESGUI_NULL};
    }
    return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
}

/**
 * @brief 布尔弹窗焦点变化回调
 * @param page     页面指针
 * @param old_idx  原焦点索引
 * @param new_idx  新焦点索引
 * @note  根据新焦点启动焦点框尺寸和位置动画。
 */
void esgui_default_bool_popwindow_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx) {
    (void)old_idx;
    (void)new_idx;
    if (page == ESGUI_NULL) return;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *data = (ESGUI_DEFAULT_BOOL_WONDOW_DAT*)page->draw_data;
    if (page->focus_idx) {
        start_popxindow_focus_box_anim((ESGUI_PopWindow_T*)page,data->text2_len,page->items[1].x,400);
    } else {
        start_popxindow_focus_box_anim((ESGUI_PopWindow_T*)page,data->text1_len,page->items[0].x,400);
    }
}

/**
 * @brief 布尔弹窗绘制回调
 * @param page 页面指针
 */
void esgui_default_bool_popwindow_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *data = window->draw_data;
    if (data == ESGUI_NULL || window->item_num < 2) return;
    window->items[0].y = window->window_y + window->window_h - 15;
    Area a = {window->window_x, window->window_y,window->window_x+window->window_w,window->window_y+window->window_h};
    canvas_clip_push(c_it->canvas,&a);
    eui_draw_round_rect_box(c_it->canvas,window->window_x, window->window_y,window->window_x+window->window_w,window->window_y+window->window_h,5,EUI_MODE_SET);
    eui_draw_text(c_it->canvas,window->window_x+5,window->window_y+5,&ESGUI_DEFAULT_FONT,window->title,EUI_MODE_SET);
    eui_draw_text(c_it->canvas,window->items[0].x,window->items[0].y,
        &ESGUI_DEFAULT_FONT,window->items[0].label,EUI_MODE_SET);
    eui_draw_text(c_it->canvas,window->items[0].x + data->text1_len + ESGUI_BOOL_POPWINDOW_TEXT_GAP,window->items[0].y,
        &ESGUI_DEFAULT_FONT,window->items[1].label,EUI_MODE_SET);
    ESGUI_WidgetTextFocusBox(c_it->canvas,data->focus_x,window->items[0].y,data->font_height,data->focus_w);
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief 布尔弹窗页面切换回调
 * @param page   页面指针
 * @param action 动作指令
 */
void esgui_default_bool_popwindow_on_page_change(ESGUI_MenuPage_T *page,ESGUI_MenuAction_T *action) {
    if (page == ESGUI_NULL || action == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    CanvasStripIter *c_it = window->render_ctx;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *data = window->draw_data;
    switch (action->act) {
        case ACT_SHOW_POPUP:
            start_popxindow_focus_box_anim(window,data->text1_len,page->items[0].x,400);
            start_popwindow_window_anim(window,0 - window->window_h - 10,(canvas_get_height(c_it) - window->window_h) / 2,400,ANIM_PATH_OVERSHOOT);
            break;
        case ACT_CLOSE_POPUP:
            start_popwindow_window_anim(window,window->window_y,0 - window->window_h - 10,400,ANIM_PATH_EASE_IN_OUT);
            break;
        default:
            break;
    }
}

/**
 * @brief 布尔弹窗默认虚函数表
 */
static const esgui_page_vtable_t boo_popwindow_vtable = {
    .on_create = esgui_default_bool_popwindow_on_create,
    .on_destroy = esgui_default_bool_popwindow_on_destroy,
    .on_draw = esgui_default_bool_popwindow_on_draw,
    .special_item_draw = ESGUI_NULL,
    .get_special_item_draw_w = ESGUI_NULL,
    .on_input = esgui_default_bool_popwindow_on_input,
    .on_focus_change = esgui_default_bool_popwindow_on_focus_change,
    .on_page_chenge = esgui_default_bool_popwindow_on_page_change,
};

/**
 * @brief 创建布尔弹窗
 * @param window    弹窗结构体指针
 * @param message   消息文本（标题）
 * @param window_w  弹窗宽度
 * @param window_h  弹窗高度
 * @param boo_val   绑定的布尔变量指针（结果写入此处）
 */
void ESGUI_DefaultBoolPopWindowCreate(ESGUI_PopWindow_T *window,const char* message,eui_uint16_t window_w,eui_uint16_t window_h,bool *boo_val) {
    if (window == ESGUI_NULL) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl = &boo_popwindow_vtable;
    window->title = (message == ESGUI_NULL) ? "" : message;
    window->window_w = window_w;
    window->window_h = window_h;
    window->item_num = ESGUI_ITEM_NUM_COUNT(bool_popwindow_items);
    window->items = bool_popwindow_items;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *dat = popup_data_alloc();
    if (dat != ESGUI_NULL) {
        dat->val = boo_val;
    }
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_BOOL */


/* ---------- 6.2b 布尔弹窗滚动标题版本 ---------- */

#if ESGUI_ENABLE_POPUP_BOOL_SCROLL_TITLE

/**
 * @brief 布尔弹窗滚动标题版本创建回调
 */
void esgui_default_bool_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page) {
    esgui_default_bool_popwindow_on_create(page);
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *data = window->draw_data;
    if (data == ESGUI_NULL || !window->title || !window->title[0]) return;
    data->title_len = (eui_uint16_t)eui_get_text_width(&ESGUI_DEFAULT_FONT, window->title);
    data->title_scroll_x = ESGUI_POPUP_TITLE_SCROLL_MARGIN;
    start_popup_title_scroll_anim(window, &data->title_scroll_x, data->title_len);
}

/**
 * @brief 布尔弹窗滚动标题版本绘制回调
 */
void esgui_default_bool_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *data = window->draw_data;
    if (data == ESGUI_NULL || window->item_num < 2) return;
    window->items[0].y = window->window_y + window->window_h - 15;
    Area a = {window->window_x, window->window_y, window->window_x + window->window_w, window->window_y + window->window_h};
    canvas_clip_push(c_it->canvas, &a);
    eui_draw_round_rect_box(c_it->canvas, window->window_x, window->window_y,
        window->window_x + window->window_w, window->window_y + window->window_h, 5, EUI_MODE_SET);
    draw_popup_scrolling_title(c_it, window, data->title_len, data->title_scroll_x);
    eui_draw_text(c_it->canvas, window->items[0].x, window->items[0].y,
        &ESGUI_DEFAULT_FONT, window->items[0].label, EUI_MODE_SET);
    eui_draw_text(c_it->canvas, window->items[0].x + data->text1_len + ESGUI_BOOL_POPWINDOW_TEXT_GAP, window->items[0].y,
        &ESGUI_DEFAULT_FONT, window->items[1].label, EUI_MODE_SET);
    ESGUI_WidgetTextFocusBox(c_it->canvas, data->focus_x, window->items[0].y, data->font_height, data->focus_w);
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief 布尔弹窗滚动标题版本销毁回调
 */
void esgui_default_bool_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    if (window->draw_data != ESGUI_NULL) {
        ESGUI_DEFAULT_BOOL_WONDOW_DAT *dat = window->draw_data;
        anim_stop_all(&dat->title_scroll_x);
        anim_stop_all(&dat->focus_w);
        anim_stop_all(&dat->focus_x);
        popup_data_free();
        window->draw_data = ESGUI_NULL;
    }
    window->render_ctx = ESGUI_NULL;
}

static const esgui_page_vtable_t bool_scroll_title_popwindow_vtable = {
    .on_create = esgui_default_bool_scroll_title_popwindow_on_create,
    .on_destroy = esgui_default_bool_scroll_title_popwindow_on_destroy,
    .on_draw = esgui_default_bool_scroll_title_popwindow_on_draw,
    .special_item_draw = ESGUI_NULL,
    .get_special_item_draw_w = ESGUI_NULL,
    .on_input = esgui_default_bool_popwindow_on_input,
    .on_focus_change = esgui_default_bool_popwindow_on_focus_change,
    .on_page_chenge = esgui_default_bool_popwindow_on_page_change,
};

/**
 * @brief 创建布尔弹窗滚动标题版本
 */
void ESGUI_DefaultBoolScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char* message,
    eui_uint16_t window_w, eui_uint16_t window_h, bool *boo_val) {
    if (window == ESGUI_NULL) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl = &bool_scroll_title_popwindow_vtable;
    window->title = (message == ESGUI_NULL) ? "" : message;
    window->window_w = window_w;
    window->window_h = window_h;
    window->item_num = ESGUI_ITEM_NUM_COUNT(bool_popwindow_items);
    window->items = bool_popwindow_items;
    ESGUI_DEFAULT_BOOL_WONDOW_DAT *dat = popup_data_alloc();
    if (dat != ESGUI_NULL) {
        dat->val = boo_val;
    }
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_BOOL_SCROLL_TITLE */


/* ---------- 6.3 值弹窗 ---------- */

#if ESGUI_ENABLE_POPUP_VALUE

/**
 * @brief 值弹窗私有数据
 */
typedef struct {
    ESGUI_ValueDesc_T *value_desc;  /**< 值描述符指针（包含 get_permille / to_string / step） */
    int text_x;                     /**< 值文本当前 X 坐标（居中） */
    eui_uint16_t font_height;           /**< 字体高度 */
    eui_uint16_t text_len;              /**< 值文本宽度 */
    eui_uint16_t bar_per;               /**< 进度条千分比（0~1000） */
    char value_str[15];             /**< 值文本缓冲区 */
    eui_uint16_t title_len;             /**< 标题文本宽度（滚动标题用） */
    eui_int16_t  title_scroll_x;        /**< 标题滚动当前 X 偏移（滚动标题用） */
} ESGUI_DEFAULT_VALUE_WINDOW_DAT;

/**
 * @brief 启动值弹窗进度条动画
 * @param page      弹窗指针
 * @param target_per 目标千分比
 * @param duration  动画持续时间
 * @note  先停止旧动画防止竞争，若当前值等于目标值则跳过。
 */
static void start_value_popindow_progrss_bar_anim(ESGUI_PopWindow_T *page, eui_uint16_t target_per, eui_uint32_t duration)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT* data = page->draw_data;

    /* 先停止旧动画，防止多动画竞争同一变量导致抖动 */
    anim_stop_all(&data->bar_per);

    /* 已到达目标，无需浪费动画槽位 */
    if (data->bar_per == target_per) return;

    anim_t anim_w = {0};
    anim_w.var       = &data->bar_per;
    anim_w.start     = data->bar_per;   /* 从当前显示值开始 */
    anim_w.end       = target_per;       /* 目标值 */
    anim_w.exec_cb   = anim_cb_uint16;
    anim_w.duration  = duration;
    anim_w.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_w);
}

/**
 * @brief 值弹窗创建回调
 * @param page 页面指针
 * @note  初始化值文本和进度条初始值。
 */
void esgui_default_value_popwindow_on_create(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *data = (ESGUI_DEFAULT_VALUE_WINDOW_DAT*)window->draw_data;
    if (data == ESGUI_NULL) return;
    data->font_height = eui_get_text_height(&ESGUI_DEFAULT_FONT,"0");
    window->window_x = (canvas_get_width(c_it) - window->window_w) / 2;
    if (data->value_desc != ESGUI_NULL && data->value_desc->get_permille != ESGUI_NULL && data->value_desc->to_string != ESGUI_NULL) {
        data->value_desc->to_string(data->value_desc->ctx,data->value_str,sizeof(data->value_str));
        data->text_len = eui_get_text_width(&ESGUI_DEFAULT_FONT,data->value_str);
        data->bar_per = data->value_desc->get_permille(data->value_desc->ctx);
    }
    data->text_x = (window->window_w - data->text_len)/2 + window->window_x;
}

/**
 * @brief 值弹窗销毁回调
 * @param page 页面指针
 */
void esgui_default_value_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    if (page->draw_data != ESGUI_NULL) {
        ESGUI_DEFAULT_VALUE_WINDOW_DAT *dat = page->draw_data;
        anim_stop_all(&dat->bar_per);
        popup_data_free();
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}

/**
 * @brief 值弹窗输入处理
 * @param page 页面指针
 * @param e    事件码
 * @return 动作指令
 * @note  上下/左右调节数值（调用 value_desc->step），OK/BACK 关闭弹窗。
 */
ESGUI_MenuAction_T esgui_default_value_popwindow_on_input(ESGUI_MenuPage_T *page,ESGUI_EventCode_t e) {
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *data = (ESGUI_DEFAULT_VALUE_WINDOW_DAT*)page->draw_data;
    switch (e) {
        case EVT_KEY_UP:
        case EVT_KEY_RIGHT:
            if (data->value_desc && data->value_desc->step) {
                data->value_desc->step(data->value_desc->ctx,1);
            }
            if (page->vtbl->on_focus_change) {
                page->vtbl->on_focus_change(page, 0, 0);
            }
            return (ESGUI_MenuAction_T){ACT_REFRESH, ESGUI_NULL};
        case EVT_KEY_DOWN:
        case EVT_KEY_LEFT:
            if (data->value_desc && data->value_desc->step) {
                data->value_desc->step(data->value_desc->ctx,-1);
            }
            if (page->vtbl->on_focus_change) {
                page->vtbl->on_focus_change(page, 0, 0);
            }
            return (ESGUI_MenuAction_T){ACT_REFRESH, ESGUI_NULL};
        case EVT_KEY_OK:
        case EVT_CLICKED:
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        case EVT_KEY_BACK:
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        default:
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    }
}

/**
 * @brief 值弹窗焦点变化回调（值变化时触发）
 * @param page     页面指针
 * @param old_idx  原焦点索引（未使用，值弹窗只有一项）
 * @param new_idx  新焦点索引（未使用）
 * @note  更新值文本，重新计算居中位置，启动进度条平滑动画。
 */
void esgui_default_value_popwindow_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx) {
    (void)old_idx;
    (void)new_idx;
    if (page == ESGUI_NULL) return;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *data = (ESGUI_DEFAULT_VALUE_WINDOW_DAT*)page->draw_data;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;

    /* 更新文字（瞬间切换，不需要动画） */
    if (data != ESGUI_NULL && data->value_desc != ESGUI_NULL
        && data->value_desc->get_permille != ESGUI_NULL
        && data->value_desc->to_string != ESGUI_NULL) {
        data->value_desc->to_string(data->value_desc->ctx, data->value_str, sizeof(data->value_str));
        data->text_len = eui_get_text_width(&ESGUI_DEFAULT_FONT, data->value_str);
        /* 注意：不再直接写 data->bar_per，由动画回调负责平滑更新 */
        }
    data->text_x = (window->window_w - data->text_len) / 2 + window->window_x;

    /* 启动进度条平滑动画：从当前值 → 新目标值 */
    eui_uint16_t target_per = 0;
    if (data->value_desc && data->value_desc->get_permille) {
        target_per = data->value_desc->get_permille(data->value_desc->ctx);
    }
    start_value_popindow_progrss_bar_anim(window, target_per, 400);
}

/**
 * @brief 值弹窗页面切换回调
 * @param page   页面指针
 * @param action 动作指令
 */
void esgui_default_value_popwindow_on_page_change(ESGUI_MenuPage_T *page,ESGUI_MenuAction_T *action) {
    if (page == ESGUI_NULL || action == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *data = (ESGUI_DEFAULT_VALUE_WINDOW_DAT*)page->draw_data;
    CanvasStripIter *c_it = window->render_ctx;
    switch (action->act) {
        case ACT_SHOW_POPUP:
            start_value_popindow_progrss_bar_anim(window,data->bar_per,400);
            start_popwindow_window_anim(window,0 - window->window_h - 10,(canvas_get_height(c_it) - window->window_h) / 2,400,ANIM_PATH_OVERSHOOT);
            break;
        case ACT_CLOSE_POPUP:
            start_popwindow_window_anim(window,window->window_y,0 - window->window_h - 10,400,ANIM_PATH_EASE_IN_OUT);
            break;
        default:
            break;
    }
}

/**
 * @brief 值弹窗绘制回调
 * @param page 页面指针
 * @note  绘制圆角矩形、标题、居中值文本、底部横向进度条。
 */
void esgui_default_value_popwindow_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *data = (ESGUI_DEFAULT_VALUE_WINDOW_DAT*)page->draw_data;
    Area a = {window->window_x, window->window_y,window->window_x+window->window_w,window->window_y+window->window_h};
    canvas_clip_push(c_it->canvas,&a);
    eui_draw_round_rect_box(c_it->canvas,window->window_x, window->window_y,window->window_x+window->window_w,window->window_y+window->window_h,5,EUI_MODE_SET);
    eui_draw_text(c_it->canvas,window->window_x+5,window->window_y+5,&ESGUI_DEFAULT_FONT,window->title,EUI_MODE_SET);
    if (data->value_desc) {
        if (data->value_desc->to_string) {
            eui_draw_text_clip(c_it->canvas,data->text_x,window->window_y+window->window_h /2,&ESGUI_DEFAULT_FONT,data->value_str,EUI_MODE_SET,data->text_len);
        }
        if (data->value_desc->get_permille) {
            ESGUI_WidgetProgrssBarChangeLenPermille(c_it->canvas,window->window_x + 2,window->window_y+window->window_h /2+data->font_height+3,3,window->window_w - 4,data->bar_per,ESGUI_WIDGET_PROGBAR_RIGHT);
        }
    }
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief 值弹窗默认虚函数表
 */
static const esgui_page_vtable_t value_popwindow_vtable = {
    .on_create = esgui_default_value_popwindow_on_create,
    .on_destroy = esgui_default_value_popwindow_on_destroy,
    .on_draw = esgui_default_value_popwindow_on_draw,
    .special_item_draw = ESGUI_NULL,
    .get_special_item_draw_w = ESGUI_NULL,
    .on_input = esgui_default_value_popwindow_on_input,
    .on_focus_change = esgui_default_value_popwindow_on_focus_change,
    .on_page_chenge = esgui_default_value_popwindow_on_page_change,
};

/**
 * @brief 创建值弹窗
 * @param window     弹窗结构体指针
 * @param message    标题文本
 * @param window_w   弹窗宽度
 * @param window_h   弹窗高度
 * @param value_desc 值描述符指针（包含数值操作回调）
 */
void ESGUI_DefaultValuePopWindowCreate(ESGUI_PopWindow_T *window,const char* message,eui_uint16_t window_w,eui_uint16_t window_h,ESGUI_ValueDesc_T *value_desc) {
    if (window == ESGUI_NULL) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl = &value_popwindow_vtable;
    window->title = (message == ESGUI_NULL) ? "" : message;
    window->window_w = window_w;
    window->window_h = window_h;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *dat = popup_data_alloc();
    if (dat != ESGUI_NULL) {
        dat->value_desc = value_desc;
    }
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_VALUE */


/* ---------- 6.3b 值弹窗滚动标题版本 ---------- */

#if ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE

/**
 * @brief 值弹窗滚动标题版本创建回调
 */
void esgui_default_value_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page) {
    esgui_default_value_popwindow_on_create(page);
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *data = window->draw_data;
    if (data == ESGUI_NULL || !window->title || !window->title[0]) return;
    data->title_len = (eui_uint16_t)eui_get_text_width(&ESGUI_DEFAULT_FONT, window->title);
    data->title_scroll_x = ESGUI_POPUP_TITLE_SCROLL_MARGIN;
    start_popup_title_scroll_anim(window, &data->title_scroll_x, data->title_len);
}

/**
 * @brief 值弹窗滚动标题版本绘制回调
 */
void esgui_default_value_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *data = page->draw_data;
    Area a = {window->window_x, window->window_y, window->window_x + window->window_w, window->window_y + window->window_h};
    canvas_clip_push(c_it->canvas, &a);
    eui_draw_round_rect_box(c_it->canvas, window->window_x, window->window_y,
        window->window_x + window->window_w, window->window_y + window->window_h, 5, EUI_MODE_SET);
    draw_popup_scrolling_title(c_it, window, data->title_len, data->title_scroll_x);
    if (data->value_desc) {
        if (data->value_desc->to_string) {
            eui_draw_text_clip(c_it->canvas, data->text_x, window->window_y + window->window_h / 2,
                &ESGUI_DEFAULT_FONT, data->value_str, EUI_MODE_SET, data->text_len);
        }
        if (data->value_desc->get_permille) {
            ESGUI_WidgetProgrssBarChangeLenPermille(c_it->canvas, window->window_x + 2,
                window->window_y + window->window_h / 2 + data->font_height + 3,
                3, window->window_w - 4, data->bar_per, ESGUI_WIDGET_PROGBAR_RIGHT);
        }
    }
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief 值弹窗滚动标题版本销毁回调
 */
void esgui_default_value_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    if (page->draw_data != ESGUI_NULL) {
        ESGUI_DEFAULT_VALUE_WINDOW_DAT *dat = page->draw_data;
        anim_stop_all(&dat->title_scroll_x);
        anim_stop_all(&dat->bar_per);
        popup_data_free();
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}

static const esgui_page_vtable_t value_scroll_title_popwindow_vtable = {
    .on_create = esgui_default_value_scroll_title_popwindow_on_create,
    .on_destroy = esgui_default_value_scroll_title_popwindow_on_destroy,
    .on_draw = esgui_default_value_scroll_title_popwindow_on_draw,
    .special_item_draw = ESGUI_NULL,
    .get_special_item_draw_w = ESGUI_NULL,
    .on_input = esgui_default_value_popwindow_on_input,
    .on_focus_change = esgui_default_value_popwindow_on_focus_change,
    .on_page_chenge = esgui_default_value_popwindow_on_page_change,
};

/**
 * @brief 创建值弹窗滚动标题版本
 */
void ESGUI_DefaultValueScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char* message,
    eui_uint16_t window_w, eui_uint16_t window_h, ESGUI_ValueDesc_T *value_desc) {
    if (window == ESGUI_NULL) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl = &value_scroll_title_popwindow_vtable;
    window->title = (message == ESGUI_NULL) ? "" : message;
    window->window_w = window_w;
    window->window_h = window_h;
    ESGUI_DEFAULT_VALUE_WINDOW_DAT *dat = popup_data_alloc();
    if (dat != ESGUI_NULL) {
        dat->value_desc = value_desc;
    }
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE */


/* ---------- 6.4 文本列表弹窗 ---------- */

#if ESGUI_ENABLE_POPUP_TEXTLIST

/**
 * @brief 文本列表弹窗私有数据
 */
typedef struct {
    eui_int16_t  focus_box_w;   /**< 焦点框当前宽度 */
    eui_int16_t  focus_box_y;   /**< 焦点框当前 Y 坐标（相对弹窗内容区） */
    eui_int16_t  long_text_x;   /**< 长文本滚动当前 X 偏移 */
    eui_uint16_t text_len;      /**< 当前焦点条目的纯文本宽度 */
    eui_uint16_t buff;          /**< 弹窗可见条目数 */
    eui_uint16_t stay;          /**< 焦点保持阈值 */
    eui_uint16_t item_stride;   /**< 条目步进 */
    eui_uint8_t  font_height;   /**< 字体高度 */
    eui_uint8_t  flags;         /**< 状态标志位 */
    eui_uint16_t title_len;     /**< 标题文本宽度（滚动标题用） */
    eui_int16_t  title_scroll_x;/**< 标题滚动当前 X 偏移（滚动标题用） */
} ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT;

#define TXTLIST_FLAG_ANIM  0x01  /**< 长文本滚动动画已启动 */
#define TXTLIST_FLAG_LONG  0x02  /**< 当前焦点条目是长文本 */

/**
 * @brief 启动文本列表弹窗焦点框动画
 * @param window   弹窗指针
 * @param w        目标宽度
 * @param y        目标 Y 坐标
 * @param duration 动画持续时间
 */
static void start_textlist_focus_box_anim(ESGUI_PopWindow_T *window, eui_int16_t w, eui_int16_t y, eui_uint32_t duration)
{
    if (window == ESGUI_NULL || window->draw_data == ESGUI_NULL) return;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *data = window->draw_data;
    anim_t anim_w = {0};
    anim_t anim_y = {0};
    anim_w.var       = &data->focus_box_w;
    anim_w.start     = data->focus_box_w;
    anim_w.end       = w;
    anim_w.exec_cb   = anim_cb_int16;
    anim_w.duration  = duration;
    anim_w.path_type = ANIM_PATH_EASE_OUT;
    anim_y.var       = &data->focus_box_y;
    anim_y.start     = data->focus_box_y;
    anim_y.end       = y;
    anim_y.exec_cb   = anim_cb_int16;
    anim_y.duration  = duration;
    anim_y.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_w);
    anim_start(&anim_y);
}

/**
 * @brief 启动文本列表弹窗列表滚动动画
 * @param window   弹窗指针
 * @param y        目标基线 Y 坐标
 * @param duration 动画持续时间
 */
static void start_textlist_item_scroll_anim(ESGUI_PopWindow_T *window, int y, eui_uint32_t duration)
{
    if (window == ESGUI_NULL || window->items == ESGUI_NULL) return;
    anim_t anim = {0};
    anim.var      = &window->items[0].y;
    anim.start    = window->items[0].y;
    anim.end      = y;
    anim.exec_cb  = anim_cb_int;
    anim.duration = duration;
    anim.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim);
}

/**
 * @brief 启动文本列表弹窗长文本滚动动画
 * @param window 弹窗指针
 */
static void start_textlist_long_text_anim(ESGUI_PopWindow_T *window)
{
    if (window == ESGUI_NULL || window->draw_data == ESGUI_NULL) return;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *data = window->draw_data;
    anim_t anim = {0};
    anim.var        = &data->long_text_x;
    anim.start      = ESGUI_TEXT_MARGIN_X;
    anim.end        = -(eui_int32_t)data->text_len - (eui_int32_t)ESGUI_LONG_TEXT_GAP;
    anim.exec_cb    = anim_cb_int16;
    anim.duration   = 7500;
    anim.path_type  = ANIM_PATH_LINEAR;
    anim.repeat_cnt = 0xFFFF;
    anim.delay      = 400;
    anim_start(&anim);
}

/**
 * @brief 文本列表弹窗创建回调
 * @param page 页面指针
 * @note  计算弹窗内可见条目数、字体高度、条目步进，初始化焦点框位置。
 */
void esgui_default_text_list_popwindow_on_create(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T *)page;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *data = page->draw_data;
    if (data == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    page->items[0].y = 0;
    data->font_height = (eui_uint8_t)eui_get_text_height(&ESGUI_DEFAULT_FONT, page->items[0].label);
    data->item_stride = data->font_height + ESGUI_ITEM_SPACING;
    data->buff = (eui_uint16_t)(window->window_h / data->item_stride);
    if (data->buff == 0) data->buff = 1;
    data->stay = (data->buff + 1) / 2;
    window->window_x = (canvas_get_width(c_it) - window->window_w) / 2;
    eui_uint16_t text_len = eui_get_text_width(&ESGUI_DEFAULT_FONT, page->items[0].label);
    data->text_len = text_len;
    eui_int16_t max_text_w = window->window_w - 6;
    data->flags = (text_len > (eui_uint16_t)max_text_w) ? TXTLIST_FLAG_LONG : 0;
    eui_int16_t focus_w = (eui_int16_t)(text_len + ESGUI_FOCUS_BOX_PAD_X);
    if (focus_w > max_text_w) focus_w = max_text_w;
    if (focus_w < 0) focus_w = 0;
    data->focus_box_w = focus_w;
    data->focus_box_y = 0;
    data->long_text_x = ESGUI_TEXT_MARGIN_X;
}

/**
 * @brief 文本列表弹窗销毁回调
 * @param page 页面指针
 */
void esgui_default_text_list_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    if (page->draw_data != ESGUI_NULL) {
        ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *dat = page->draw_data;
        anim_stop_all(&dat->long_text_x);
        anim_stop_all(&dat->focus_box_w);
        anim_stop_all(&dat->focus_box_y);
        popup_data_free();
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}

/**
 * @brief 文本列表弹窗输入处理
 * @param page 页面指针
 * @param e    事件码
 * @return 动作指令
 */
ESGUI_MenuAction_T esgui_default_text_list_popwindow_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e)
{
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    eui_uint16_t old_focus_idx = page->focus_idx;
    switch (e) {
        case EVT_KEY_UP:
        case EVT_KEY_RIGHT:
            FocusUP(page->focus_idx, page->item_num);
            break;
        case EVT_KEY_DOWN:
        case EVT_KEY_LEFT:
            FocusDOWN(page->focus_idx);
            break;
        case EVT_KEY_OK:
        case EVT_CLICKED:
            if (page->items[page->focus_idx].on_enter) {
                return page->items[page->focus_idx].on_enter(page, page->items[page->focus_idx].arg);
            }
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        case EVT_KEY_BACK:
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        default:
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    }
    if (old_focus_idx != page->focus_idx) {
        if (page->vtbl->on_focus_change) {
            page->vtbl->on_focus_change(page, old_focus_idx, page->focus_idx);
        }
        return (ESGUI_MenuAction_T){ACT_REFRESH, ESGUI_NULL};
    }
    return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
}

/**
 * @brief 文本列表弹窗焦点变化回调
 * @param page     页面指针
 * @param old_idx  原焦点索引
 * @param new_idx  新焦点索引
 * @note  逻辑与文本菜单焦点变化类似，但坐标系基于弹窗内部。
 */
void esgui_default_text_list_popwindow_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx)
{
    (void)old_idx;
    (void)new_idx;
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T *)page;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *data = page->draw_data;
    eui_uint16_t focus_idx = page->focus_idx;
    eui_uint16_t item_num  = page->item_num;
    eui_uint16_t text_len = get_pure_text_width(page->items[focus_idx].label);
    data->text_len = text_len;
    eui_int16_t max_text_w = window->window_w - 6;
    data->flags = (data->flags & ~TXTLIST_FLAG_LONG)
                | ((text_len > (eui_uint16_t)max_text_w) ? TXTLIST_FLAG_LONG : 0);
    eui_int16_t focus_w = (eui_int16_t)(text_len + ESGUI_FOCUS_BOX_PAD_X);
    if (focus_w > max_text_w) focus_w = max_text_w;
    if (focus_w < 0) focus_w = 0;
    eui_int16_t top_y = 0;
    eui_uint16_t first_visible = calc_first_visible_for_focus(item_num, data->buff, data->stay, focus_idx);
    eui_uint16_t focus_in_view = focus_idx - first_visible;
    eui_int16_t focus_y = calc_focus_y(top_y, focus_in_view, data->item_stride);

    if (item_num <= data->buff) {
        start_textlist_focus_box_anim(window, focus_w, focus_y, 400);
    } else if (focus_idx < data->stay) {
        start_textlist_item_scroll_anim(window, top_y, 230);
        start_textlist_focus_box_anim(window, focus_w, focus_y, 400);
    } else if (focus_idx < item_num - (data->buff / 2)) {
        eui_int16_t list_y = calc_list_y(top_y, first_visible, data->item_stride);
        start_textlist_item_scroll_anim(window, list_y, 230);
        start_textlist_focus_box_anim(window, focus_w, focus_y, 400);
    } else {
        /* 修复：底部区域直接修正 items[0].y，避免旧动画目标导致列表偏移 */
        first_visible = calc_first_visible_for_focus(item_num, data->buff, data->stay, focus_idx);
        eui_int16_t list_y = calc_list_y(top_y, first_visible, data->item_stride);
        page->items[0].y = list_y;
        start_textlist_focus_box_anim(window, focus_w, focus_y, 400);
    }

    data->long_text_x = ESGUI_TEXT_MARGIN_X;
    data->flags &= ~TXTLIST_FLAG_ANIM;
    anim_stop_all(&data->long_text_x);
}

/**
 * @brief 文本列表弹窗页面切换回调
 * @param page   页面指针
 * @param action 动作指令
 */
void esgui_text_list_popwindow_default_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action) {
    if (page == ESGUI_NULL || action == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T *)page;
    CanvasStripIter *c_it = page->render_ctx;
    switch (action->act) {
        case ACT_SHOW_POPUP:
            start_popwindow_window_anim(window, 0 - window->window_h - 10,
                (canvas_get_height(c_it) - window->window_h) / 2, 400, ANIM_PATH_OVERSHOOT);
            break;
        case ACT_CLOSE_POPUP:
            start_popwindow_window_anim(window, window->window_y,
                0 - window->window_h - 10, 400, ANIM_PATH_EASE_IN_OUT);
            break;
        default:
            break;
    }
}

/**
 * @brief 文本列表弹窗绘制回调
 * @param page 页面指针
 * @note  绘制逻辑与文本菜单类似，但坐标系基于弹窗内部，
 *        并增加了弹窗圆角矩形边框和裁剪区。
 */
void esgui_default_text_list_popwindow_on_draw(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    CanvasStripIter *c_it = (CanvasStripIter *)page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *data = (ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *)page->draw_data;
    eui_uint16_t start, end;
    calc_visible_range(page->item_num, data->buff, data->stay, page->focus_idx, &start, &end);
    Area clip = {
        window->window_x,
        window->window_y,
        window->window_x + window->window_w,
        window->window_y + window->window_h,
    };
    canvas_clip_push(c_it->canvas, &clip);
    eui_draw_round_rect_box(c_it->canvas,
        window->window_x, window->window_y,
        window->window_x + window->window_w,
        window->window_y + window->window_h, 5, EUI_MODE_SET);
    eui_int16_t list_base_y = window->window_y + 3 + page->items[0].y;
    eui_uint16_t stride = data->item_stride;
    eui_uint16_t focus_idx = page->focus_idx;
    eui_int16_t max_text_w = window->window_w - 6;
    eui_int32_t item_y_acc = (eui_int32_t)list_base_y + (eui_int32_t)start * (eui_int32_t)stride;
    for (eui_uint16_t i = start; i <= end; i++, item_y_acc += stride) {
        eui_int16_t item_y = (eui_int16_t)item_y_acc;
        if (i == focus_idx && (data->flags & TXTLIST_FLAG_LONG)) {
            eui_uint16_t cached_text_len = data->text_len;
            eui_int16_t long_text_x = data->long_text_x;
            eui_int16_t abs_x = (long_text_x < 0) ? -long_text_x : long_text_x;
            eui_int16_t w1 = max_text_w + abs_x - ESGUI_TEXT_MARGIN_X;
            if (w1 > (eui_int16_t)cached_text_len) w1 = (eui_int16_t)cached_text_len;
            if (w1 < 0) w1 = 0;
            eui_draw_text_clip(c_it->canvas,
                window->window_x + long_text_x, item_y,
                &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, w1);
            eui_int32_t text_plus_x = (eui_int32_t)cached_text_len + (eui_int32_t)long_text_x;
            eui_int16_t text_area_right = window->window_w - 3;
            eui_int16_t remain = text_area_right - (eui_int16_t)text_plus_x;
            if (remain >= ESGUI_LONG_TEXT_GAP) {
                eui_int16_t X2 = long_text_x + (eui_int16_t)cached_text_len + ESGUI_LONG_TEXT_GAP + 2;
                eui_int16_t w2 = text_area_right - X2;
                if (w2 > (eui_int16_t)cached_text_len) w2 = (eui_int16_t)cached_text_len;
                if (w2 < 0) w2 = 0;
                eui_draw_text_clip(c_it->canvas,
                    window->window_x + X2, item_y,
                    &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, w2);
            }
            if (!(data->flags & TXTLIST_FLAG_ANIM)) {
                data->flags |= TXTLIST_FLAG_ANIM;
                start_textlist_long_text_anim(window);
            }
        }else {
            eui_uint16_t pure_w = get_pure_text_width(page->items[i].label);
            eui_int16_t draw_w = (max_text_w < (eui_int16_t)pure_w) ? max_text_w : (eui_int16_t)pure_w;
            if (draw_w < 0) draw_w = 0;
            eui_draw_text_clip(c_it->canvas,
                window->window_x + ESGUI_TEXT_MARGIN_X, item_y,
                &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, (int)draw_w);
        }
    }
    eui_int16_t abs_focus_y = window->window_y + 3 + data->focus_box_y;
    ESGUI_WidgetTextFocusBox(c_it->canvas,
        window->window_x,
        abs_focus_y,
        data->font_height,
        (eui_uint8_t)data->focus_box_w);
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief 文本列表弹窗默认虚函数表
 */
static const esgui_page_vtable_t text_list_popwindow_vtable = {
    .on_create = esgui_default_text_list_popwindow_on_create,
    .on_destroy = esgui_default_text_list_popwindow_on_destroy,
    .on_draw = esgui_default_text_list_popwindow_on_draw,
    .special_item_draw = ESGUI_NULL,
    .get_special_item_draw_w = ESGUI_NULL,
    .on_input = esgui_default_text_list_popwindow_on_input,
    .on_focus_change = esgui_default_text_list_popwindow_on_focus_change,
    .on_page_chenge = esgui_text_list_popwindow_default_on_page_change,
};

/**
 * @brief 创建文本列表弹窗
 * @param window     弹窗结构体指针
 * @param window_w   弹窗宽度
 * @param window_h   弹窗高度
 * @param items      条目数组
 * @param item_num   条目数量
 */
void ESGUI_DefaultTextListPopWindowCreate(ESGUI_PopWindow_T *window, eui_uint16_t window_w, eui_uint16_t window_h,
                                          ESGUI_MenuItem_T *items, eui_uint32_t item_num) {
    if (window == ESGUI_NULL || items == ESGUI_NULL || item_num == 0) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl = &text_list_popwindow_vtable;
    window->window_w = window_w;
    window->window_h = window_h;
    window->items = items;
    window->item_num = (eui_uint16_t)item_num;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *dat = popup_data_alloc();
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_TEXTLIST */


/* ---------- 6.4b 文本列表弹窗滚动标题版本 ---------- */

#if ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE

/**
 * @brief 文本列表弹窗滚动标题版本创建回调
 * @note  复用原版逻辑，但额外计算标题高度并调整可见区域。
 */
void esgui_default_text_list_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T *)page;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *data = page->draw_data;
    if (data == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    page->items[0].y = 0;
    data->font_height = (eui_uint8_t)eui_get_text_height(&ESGUI_DEFAULT_FONT, page->items[0].label);
    data->item_stride = data->font_height + ESGUI_ITEM_SPACING;
    eui_uint16_t title_h = 0;
    if (page->title && page->title[0]) {
        title_h = data->font_height + 2 * ESGUI_POPUP_TITLE_SCROLL_MARGIN;
        data->title_len = (eui_uint16_t)eui_get_text_width(&ESGUI_DEFAULT_FONT, page->title);
        data->title_scroll_x = ESGUI_POPUP_TITLE_SCROLL_MARGIN;
        start_popup_title_scroll_anim(window, &data->title_scroll_x, data->title_len);
    }
    eui_int16_t content_h = (eui_int16_t)window->window_h - (eui_int16_t)title_h;
    if (content_h < 0) content_h = 0;
    data->buff = (eui_uint16_t)(content_h / data->item_stride);
    if (data->buff == 0) data->buff = 1;
    data->stay = (data->buff + 1) / 2;
    window->window_x = (canvas_get_width(c_it) - window->window_w) / 2;
    eui_uint16_t text_len = eui_get_text_width(&ESGUI_DEFAULT_FONT, page->items[0].label);
    data->text_len = text_len;
    eui_int16_t max_text_w = window->window_w - 6;
    data->flags = (text_len > (eui_uint16_t)max_text_w) ? TXTLIST_FLAG_LONG : 0;
    eui_int16_t focus_w = (eui_int16_t)(text_len + ESGUI_FOCUS_BOX_PAD_X);
    if (focus_w > max_text_w) focus_w = max_text_w;
    if (focus_w < 0) focus_w = 0;
    data->focus_box_w = focus_w;
    data->focus_box_y = 0;
    data->long_text_x = ESGUI_TEXT_MARGIN_X;
}

/**
 * @brief 文本列表弹窗滚动标题版本销毁回调
 */
void esgui_default_text_list_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    if (page->draw_data != ESGUI_NULL) {
        ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *dat = page->draw_data;
        anim_stop_all(&dat->title_scroll_x);
        anim_stop_all(&dat->long_text_x);
        anim_stop_all(&dat->focus_box_w);
        anim_stop_all(&dat->focus_box_y);
        popup_data_free();
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}

/**
 * @brief 文本列表弹窗滚动标题版本绘制回调
 * @note  在顶部增加标题滚动绘制，列表内容区域下移。
 */
void esgui_default_text_list_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page)
{
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL) return;
    CanvasStripIter *c_it = (CanvasStripIter *)page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *data = (ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *)page->draw_data;
    eui_uint16_t start, end;
    calc_visible_range(page->item_num, data->buff, data->stay, page->focus_idx, &start, &end);
    Area clip = {
        window->window_x, window->window_y,
        window->window_x + window->window_w,
        window->window_y + window->window_h,
    };
    canvas_clip_push(c_it->canvas, &clip);
    eui_draw_round_rect_box(c_it->canvas,
        window->window_x, window->window_y,
        window->window_x + window->window_w,
        window->window_y + window->window_h, 5, EUI_MODE_SET);

    eui_uint16_t title_h = 0;
    if (page->title && page->title[0]) {
        draw_popup_scrolling_title(c_it, window, data->title_len, data->title_scroll_x);
        title_h = data->font_height + 2 * ESGUI_POPUP_TITLE_SCROLL_MARGIN;
    }

    eui_int16_t list_base_y = window->window_y + 3 + title_h + page->items[0].y;
    eui_uint16_t stride = data->item_stride;
    eui_uint16_t focus_idx = page->focus_idx;
    eui_int16_t max_text_w = window->window_w - 6;
    eui_int32_t item_y_acc = (eui_int32_t)list_base_y + (eui_int32_t)start * (eui_int32_t)stride;
    for (eui_uint16_t i = start; i <= end; i++, item_y_acc += stride) {
        eui_int16_t item_y = (eui_int16_t)item_y_acc;
        if (i == focus_idx && (data->flags & TXTLIST_FLAG_LONG)) {
            eui_uint16_t cached_text_len = data->text_len;
            eui_int16_t long_text_x = data->long_text_x;
            eui_int16_t abs_x = (long_text_x < 0) ? -long_text_x : long_text_x;
            eui_int16_t w1 = max_text_w + abs_x - ESGUI_TEXT_MARGIN_X;
            if (w1 > (eui_int16_t)cached_text_len) w1 = (eui_int16_t)cached_text_len;
            if (w1 < 0) w1 = 0;
            eui_draw_text_clip(c_it->canvas,
                window->window_x + long_text_x, item_y,
                &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, w1);
            eui_int32_t text_plus_x = (eui_int32_t)cached_text_len + (eui_int32_t)long_text_x;
            eui_int16_t text_area_right = window->window_w - 3;
            eui_int16_t remain = text_area_right - (eui_int16_t)text_plus_x;
            if (remain >= ESGUI_LONG_TEXT_GAP) {
                eui_int16_t X2 = long_text_x + (eui_int16_t)cached_text_len + ESGUI_LONG_TEXT_GAP + 2;
                eui_int16_t w2 = text_area_right - X2;
                if (w2 > (eui_int16_t)cached_text_len) w2 = (eui_int16_t)cached_text_len;
                if (w2 < 0) w2 = 0;
                eui_draw_text_clip(c_it->canvas,
                    window->window_x + X2, item_y,
                    &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, w2);
            }
            if (!(data->flags & TXTLIST_FLAG_ANIM)) {
                data->flags |= TXTLIST_FLAG_ANIM;
                start_textlist_long_text_anim(window);
            }
        } else {
            eui_uint16_t pure_w = get_pure_text_width(page->items[i].label);
            eui_int16_t draw_w = (max_text_w < (eui_int16_t)pure_w) ? max_text_w : (eui_int16_t)pure_w;
            if (draw_w < 0) draw_w = 0;
            eui_draw_text_clip(c_it->canvas,
                window->window_x + ESGUI_TEXT_MARGIN_X, item_y,
                &ESGUI_DEFAULT_FONT, page->items[i].label, EUI_MODE_SET, (int)draw_w);
        }
    }
    eui_int16_t abs_focus_y = window->window_y + 3 + title_h + data->focus_box_y;
    ESGUI_WidgetTextFocusBox(c_it->canvas,
        window->window_x,
        abs_focus_y,
        data->font_height,
        (eui_uint8_t)data->focus_box_w);
    canvas_clip_pop(c_it->canvas);
}

static const esgui_page_vtable_t text_list_scroll_title_popwindow_vtable = {
    .on_create = esgui_default_text_list_scroll_title_popwindow_on_create,
    .on_destroy = esgui_default_text_list_scroll_title_popwindow_on_destroy,
    .on_draw = esgui_default_text_list_scroll_title_popwindow_on_draw,
    .special_item_draw = ESGUI_NULL,
    .get_special_item_draw_w = ESGUI_NULL,
    .on_input = esgui_default_text_list_popwindow_on_input,
    .on_focus_change = esgui_default_text_list_popwindow_on_focus_change,
    .on_page_chenge = esgui_text_list_popwindow_default_on_page_change,
};

/**
 * @brief 创建文本列表弹窗滚动标题版本
 */
void ESGUI_DefaultTextListScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char *title, eui_uint16_t window_w, eui_uint16_t window_h,
    ESGUI_MenuItem_T *items, eui_uint32_t item_num) {
    if (window == ESGUI_NULL || items == ESGUI_NULL || item_num == 0) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl = &text_list_scroll_title_popwindow_vtable;
    window->title = (title == ESGUI_NULL) ? "" : title;
    window->window_w = window_w;
    window->window_h = window_h;
    window->items = items;
    window->item_num = (eui_uint16_t)item_num;
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT *dat = popup_data_alloc();
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE */


/* ---------- 6.5 BMP 列表弹窗 ---------- */

#if ESGUI_ENABLE_POPUP_BMPLIST

/**
 * @brief BMP 列表弹窗私有数据
 */
typedef struct {
    eui_uint16_t font_height;       /**< 字体高度 */
    eui_uint16_t label_y;           /**< 标签基准 Y 坐标 */
    eui_int16_t  label_anim_y;      /**< 标签动画当前 Y */
    eui_uint16_t bmp_y;             /**< 图片区域基准 Y */
    eui_uint16_t content_padding;   /**< 内容区内边距 */
    eui_uint16_t box_start_w;       /**< 焦点框起始宽度 */
    eui_uint16_t box_start_h;       /**< 焦点框起始高度 */
    eui_uint16_t box_target_w;      /**< 焦点框目标宽度 */
    eui_uint16_t box_target_h;      /**< 焦点框目标高度 */
    eui_uint16_t box_permille;      /**< 焦点框生长进度 */
    eui_uint16_t title_len;         /**< 标题文本宽度（滚动标题用） */
    eui_int16_t  title_scroll_x;    /**< 标题滚动当前 X 偏移（滚动标题用） */
} ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT;

/**
 * @brief BMP 列表弹窗创建回调
 * @param page 页面指针
 * @note  计算弹窗内图片布局、标签位置，初始化焦点框尺寸。
 */
void esgui_default_bmp_list_popwindow_on_create(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = page->draw_data;
    if (dat == ESGUI_NULL) return;
    dat->font_height = (eui_uint8_t)eui_get_text_height(&ESGUI_DEFAULT_FONT, "0");
    dat->content_padding = 5;
    eui_uint16_t content_w = window->window_w - 2 * dat->content_padding;
    eui_uint16_t title_h = 0;
    if (page->title && page->title[0]) {
        title_h = dat->font_height + 4;
    }
    eui_uint16_t max_bmp_h = 0;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        const Bitmap *bmp = page->items[i].icon;
        if (bmp && bmp->h > max_bmp_h) max_bmp_h = bmp->h;
    }
    dat->label_y = window->window_h - dat->font_height - 5;
    dat->label_anim_y = dat->label_y;
    eui_uint16_t top_margin = title_h + 5;
    eui_uint16_t bottom_margin = dat->font_height + 8;
    eui_uint16_t mid_h = (window->window_h > top_margin + bottom_margin)
                     ? (window->window_h - top_margin - bottom_margin) : 0;
    dat->bmp_y = top_margin + (mid_h > max_bmp_h ? (mid_h - max_bmp_h) / 2 : 0);
    page->items[0].x = 0;
    eui_int16_t rel_x = 0;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        const Bitmap *bmp = page->items[i].icon;
        if (bmp) {
            page->items[i].y = dat->bmp_y + (max_bmp_h - bmp->h) / 2;
        } else {
            page->items[i].y = dat->bmp_y;
        }
        if (i > 0) {
            const Bitmap *prev_bmp = page->items[i - 1].icon;
            if (prev_bmp) rel_x += prev_bmp->w + ESGUI_BMP_ITEM_GAP;
            page->items[i].x = rel_x;
        }
    }
    dat->box_permille = 0;
    dat->box_start_w  = 0;
    dat->box_start_h  = 0;
    const Bitmap *first_bmp = page->items[0].icon;
    dat->box_target_w = first_bmp ? first_bmp->w + 4 : 0;
    dat->box_target_h = first_bmp ? first_bmp->h + 4 : 0;
    window->window_x = (canvas_get_width(c_it) - window->window_w) / 2;
}

/**
 * @brief BMP 列表弹窗销毁回调
 * @param page 页面指针
 */
void esgui_default_bmp_list_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = page->draw_data;
    if (dat != ESGUI_NULL) {
        anim_stop_all(&page->items[0].x);
        anim_stop_all(&dat->box_permille);
        anim_stop_all(&dat->label_anim_y);
        popup_data_free();
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}

/**
 * @brief BMP 列表弹窗输入处理
 * @param page 页面指针
 * @param e    事件码
 * @return 动作指令
 */
ESGUI_MenuAction_T esgui_default_bmp_list_popwindow_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e) {
    if (page == ESGUI_NULL) return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    eui_uint16_t old_focus_idx = page->focus_idx;
    switch (e) {
        case EVT_KEY_UP:
        case EVT_KEY_RIGHT:
            FocusUP(page->focus_idx, page->item_num);
            break;
        case EVT_KEY_DOWN:
        case EVT_KEY_LEFT:
            FocusDOWN(page->focus_idx);
            break;
        case EVT_KEY_OK:
        case EVT_CLICKED:
            if (page->items[page->focus_idx].on_enter) {
                return page->items[page->focus_idx].on_enter(page, page->items[page->focus_idx].arg);
            }
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        case EVT_KEY_BACK:
            return (ESGUI_MenuAction_T){ACT_CLOSE_POPUP, ESGUI_NULL};
        default:
            return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
    }
    if (old_focus_idx != page->focus_idx) {
        if (page->vtbl->on_focus_change) {
            page->vtbl->on_focus_change(page, old_focus_idx, page->focus_idx);
        }
        return (ESGUI_MenuAction_T){ACT_REFRESH, ESGUI_NULL};
    }
    return (ESGUI_MenuAction_T){ACT_NONE, ESGUI_NULL};
}

/**
 * @brief BMP 列表弹窗焦点变化回调
 * @param page     页面指针
 * @param old_idx  原焦点索引
 * @param new_idx  新焦点索引
 * @note  逻辑与 BMP 菜单焦点变化类似，但布局在弹窗内部。
 */
void esgui_default_bmp_list_popwindow_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx) {
    (void)old_idx; (void)new_idx;
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = page->draw_data;
    eui_uint16_t focus_idx = page->focus_idx;
    eui_uint16_t content_w = window->window_w - 2 * dat->content_padding;
    eui_int16_t focus_rel_x = bmp_item_rel_x(page, focus_idx);
    const Bitmap *focus_bmp = page->items[focus_idx].icon;
    eui_int16_t focus_w = focus_bmp ? focus_bmp->w : 0;
    eui_int16_t target_base = (content_w - focus_w) / 2 - focus_rel_x;
    anim_t anim = {0};
    anim.var       = &page->items[0].x;
    anim.start     = page->items[0].x;
    anim.end       = target_base;
    anim.exec_cb   = anim_cb_int;
    anim.duration  = 300;
    anim.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim);
    anim_stop_all(&dat->box_permille);
    eui_int32_t delta_w = (eui_int32_t)dat->box_target_w - (eui_int32_t)dat->box_start_w;
    eui_int32_t delta_h = (eui_int32_t)dat->box_target_h - (eui_int32_t)dat->box_start_h;
    eui_uint16_t current_w = (eui_uint16_t)((eui_int32_t)dat->box_start_w + delta_w * dat->box_permille / 1000);
    eui_uint16_t current_h = (eui_uint16_t)((eui_int32_t)dat->box_start_h + delta_h * dat->box_permille / 1000);
    const Bitmap *new_bmp = page->items[focus_idx].icon;
    eui_uint16_t new_w = new_bmp ? new_bmp->w + 4 : 0;
    eui_uint16_t new_h = new_bmp ? new_bmp->h + 4 : 0;
    dat->box_start_w  = current_w;
    dat->box_start_h  = current_h;
    dat->box_target_w = new_w;
    dat->box_target_h = new_h;
    dat->box_permille = 0;
    anim_t anim_box = {0};
    anim_box.var       = &dat->box_permille;
    anim_box.start     = 0;
    anim_box.end       = 1000;
    anim_box.exec_cb   = anim_cb_uint16;
    anim_box.duration  = 400;
    anim_box.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_box);
    anim_stop_all(&dat->label_anim_y);
    anim_t anim_label = {0};
    anim_label.var       = &dat->label_anim_y;
    anim_label.start     = (eui_int16_t)(window->window_h + dat->font_height);
    anim_label.end       = (eui_int16_t)dat->label_y;
    anim_label.exec_cb   = anim_cb_int16;
    anim_label.duration  = 400;
    anim_label.path_type = ANIM_PATH_EASE_OUT;
    anim_start(&anim_label);
}

/**
 * @brief BMP 列表弹窗页面切换回调
 * @param page   页面指针
 * @param action 动作指令
 */
void esgui_default_bmp_list_popwindow_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action) {
    if (page == ESGUI_NULL || action == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = page->draw_data;
    CanvasStripIter *c_it = page->render_ctx;
    eui_uint16_t content_w = window->window_w - 2 * dat->content_padding;
    if (action->act == ACT_SHOW_POPUP) {
        eui_uint16_t focus_idx = page->focus_idx;
        eui_int16_t focus_rel_x = bmp_item_rel_x(page, focus_idx);
        const Bitmap *focus_bmp = page->items[focus_idx].icon;
        eui_int16_t focus_w = focus_bmp ? focus_bmp->w : 0;
        eui_int16_t target_base = (content_w - focus_w) / 2 - focus_rel_x;
        eui_int16_t start_base = content_w;
        page->items[0].x = start_base;
        anim_t anim = {0};
        anim.var       = &page->items[0].x;
        anim.start     = start_base;
        anim.end       = target_base;
        anim.exec_cb   = anim_cb_int;
        anim.duration  = 400;
        anim.path_type = ANIM_PATH_EASE_OUT;
        anim_start(&anim);
        dat->box_permille = 0;
        dat->box_start_w  = 0;
        dat->box_start_h  = 0;
        const Bitmap *new_bmp = page->items[focus_idx].icon;
        dat->box_target_w = new_bmp ? new_bmp->w + 4 : 0;
        dat->box_target_h = new_bmp ? new_bmp->h + 4 : 0;
        anim_t anim_box = {0};
        anim_box.var       = &dat->box_permille;
        anim_box.start     = 0;
        anim_box.end       = 1000;
        anim_box.exec_cb   = anim_cb_uint16;
        anim_box.duration  = 400;
        anim_box.path_type = ANIM_PATH_EASE_OUT;
        anim_start(&anim_box);
        anim_stop_all(&dat->label_anim_y);
        dat->label_anim_y = (eui_int16_t)(window->window_h + dat->font_height);
        anim_t anim_label = {0};
        anim_label.var       = &dat->label_anim_y;
        anim_label.start     = (eui_int16_t)(window->window_h + dat->font_height);
        anim_label.end       = (eui_int16_t)dat->label_y;
        anim_label.exec_cb   = anim_cb_int16;
        anim_label.duration  = 400;
        anim_label.path_type = ANIM_PATH_EASE_OUT;
        anim_start(&anim_label);
        start_popwindow_window_anim(window, 0 - window->window_h - 10,
            (canvas_get_height(c_it) - window->window_h) / 2, 400, ANIM_PATH_OVERSHOOT);
    }
    else if (action->act == ACT_CLOSE_POPUP) {
        start_popwindow_window_anim(window, window->window_y,
            0 - window->window_h - 10, 400, ANIM_PATH_EASE_IN_OUT);
    }
}

/**
 * @brief BMP 列表弹窗绘制回调
 * @param page 页面指针
 */
void esgui_default_bmp_list_popwindow_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = page->draw_data;
    Area a = {
        window->window_x, window->window_y,
        window->window_x + window->window_w,
        window->window_y + window->window_h
    };
    canvas_clip_push(c_it->canvas, &a);
    eui_draw_round_rect_box(c_it->canvas,
        window->window_x, window->window_y,
        window->window_x + window->window_w,
        window->window_y + window->window_h, 5, EUI_MODE_SET);
    if (page->title && page->title[0]) {
        eui_draw_text_clip(c_it->canvas,
            window->window_x + 5, window->window_y + 3,
            &ESGUI_DEFAULT_FONT, page->title, EUI_MODE_SET,
            window->window_w - 10);
    }
    eui_uint16_t title_h = (page->title && page->title[0]) ? (dat->font_height + 4) : 0;
    Area bmp_clip = {
        window->window_x + dat->content_padding,
        window->window_y + title_h + 2,
        window->window_x + window->window_w - dat->content_padding,
        window->window_y + dat->label_y - 2
    };
    canvas_clip_push(c_it->canvas, &bmp_clip);
    eui_int16_t base_x = window->window_x + dat->content_padding + page->items[0].x;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        const Bitmap *bmp = page->items[i].icon;
        if (!bmp) continue;
        eui_int16_t rel_x = bmp_item_rel_x(page, i);
        eui_int16_t x = base_x + rel_x;
        eui_int16_t y = window->window_y + page->items[i].y;
        eui_int16_t w = bmp->w;
        eui_int16_t h = bmp->h;
        eui_int16_t clip_left = (eui_int16_t)(window->window_x + dat->content_padding);
        eui_int16_t clip_right = (eui_int16_t)(window->window_x + window->window_w - dat->content_padding);
        if (x + w < clip_left || x > clip_right) continue;
        eui_draw_bitmap(c_it->canvas, x, y, bmp, 1);
        if (i == page->focus_idx) {
            eui_int32_t d_w = (eui_int32_t)dat->box_target_w - (eui_int32_t)dat->box_start_w;
            eui_int32_t d_h = (eui_int32_t)dat->box_target_h - (eui_int32_t)dat->box_start_h;
            eui_uint16_t cur_w = (eui_uint16_t)((eui_int32_t)dat->box_start_w + d_w * dat->box_permille / 1000);
            eui_uint16_t cur_h = (eui_uint16_t)((eui_int32_t)dat->box_start_h + d_h * dat->box_permille / 1000);
            eui_int16_t content_w = window->window_w - 2 * dat->content_padding;
            int fx = window->window_x + dat->content_padding + (content_w - (eui_int16_t)cur_w) / 2;
            int center_y = (int)y + (bmp->h) / 2;
            int fy = center_y - (int)cur_h / 2;
            ESGUI_WidgetBmpFocusBoxAnim(c_it->canvas, fx, fy, cur_w, cur_h);
        }
    }
    canvas_clip_pop(c_it->canvas);
    if (page->items[page->focus_idx].label) {
        const char *label = page->items[page->focus_idx].label;
        int text_w = eui_get_text_width(&ESGUI_DEFAULT_FONT, label);
        int max_w = window->window_w - 10;
        int text_x = (int)window->window_x + ((int)window->window_w - text_w) / 2;
        if (text_x < (int)(window->window_x + 5)) text_x = (int)(window->window_x + 5);
        eui_draw_text_clip(c_it->canvas, text_x,
            window->window_y + dat->label_anim_y,
            &ESGUI_DEFAULT_FONT, label, EUI_MODE_SET, max_w);
    }
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief BMP 列表弹窗默认虚函数表
 */
static const esgui_page_vtable_t bmp_list_popwindow_vtable = {
    .on_create                = esgui_default_bmp_list_popwindow_on_create,
    .on_destroy               = esgui_default_bmp_list_popwindow_on_destroy,
    .on_draw                  = esgui_default_bmp_list_popwindow_on_draw,
    .special_item_draw        = ESGUI_NULL,
    .get_special_item_draw_w  = ESGUI_NULL,
    .on_input                 = esgui_default_bmp_list_popwindow_on_input,
    .on_focus_change          = esgui_default_bmp_list_popwindow_on_focus_change,
    .on_page_chenge           = esgui_default_bmp_list_popwindow_on_page_change,
};

/**
 * @brief 创建 BMP 列表弹窗
 * @param window     弹窗结构体指针
 * @param title      弹窗标题
 * @param window_w   弹窗宽度
 * @param window_h   弹窗高度
 * @param items      条目数组（icon 需指向 Bitmap）
 * @param item_num   条目数量
 */
void ESGUI_DefaultBMPListPopWindowCreate(ESGUI_PopWindow_T *window, const char *title,
                                         eui_uint16_t window_w, eui_uint16_t window_h,
                                         ESGUI_MenuItem_T *items, eui_uint32_t item_num) {
    if (window == ESGUI_NULL || items == ESGUI_NULL || item_num == 0) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl     = &bmp_list_popwindow_vtable;
    window->title    = (title == ESGUI_NULL) ? "" : title;
    window->window_w = window_w;
    window->window_h = window_h;
    window->items    = items;
    window->item_num = (eui_uint16_t)item_num;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = popup_data_alloc();
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_BMPLIST */


/* ---------- 6.5b BMP 列表弹窗滚动标题版本 ---------- */

#if ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE

/**
 * @brief BMP 列表弹窗滚动标题版本创建回调
 */
void esgui_default_bmp_list_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page) {
    esgui_default_bmp_list_popwindow_on_create(page);
    if (page == ESGUI_NULL) return;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = page->draw_data;
    if (dat == ESGUI_NULL || !window->title || !window->title[0]) return;
    dat->title_len = (eui_uint16_t)eui_get_text_width(&ESGUI_DEFAULT_FONT, window->title);
    dat->title_scroll_x = ESGUI_POPUP_TITLE_SCROLL_MARGIN;
    start_popup_title_scroll_anim(window, &dat->title_scroll_x, dat->title_len);
}

/**
 * @brief BMP 列表弹窗滚动标题版本绘制回调
 */
void esgui_default_bmp_list_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL || page->draw_data == ESGUI_NULL || page->render_ctx == ESGUI_NULL) return;
    CanvasStripIter *c_it = page->render_ctx;
    ESGUI_PopWindow_T *window = (ESGUI_PopWindow_T*)page;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = page->draw_data;
    Area a = {
        window->window_x, window->window_y,
        window->window_x + window->window_w,
        window->window_y + window->window_h
    };
    canvas_clip_push(c_it->canvas, &a);
    eui_draw_round_rect_box(c_it->canvas,
        window->window_x, window->window_y,
        window->window_x + window->window_w,
        window->window_y + window->window_h, 5, EUI_MODE_SET);
    draw_popup_scrolling_title(c_it, window, dat->title_len, dat->title_scroll_x);
    eui_uint16_t title_h = (page->title && page->title[0]) ? (dat->font_height + 4) : 0;
    Area bmp_clip = {
        window->window_x + dat->content_padding,
        window->window_y + title_h + 2,
        window->window_x + window->window_w - dat->content_padding,
        window->window_y + dat->label_y - 2
    };
    canvas_clip_push(c_it->canvas, &bmp_clip);
    eui_int16_t base_x = window->window_x + dat->content_padding + page->items[0].x;
    for (eui_uint16_t i = 0; i < page->item_num; i++) {
        const Bitmap *bmp = page->items[i].icon;
        if (!bmp) continue;
        eui_int16_t rel_x = bmp_item_rel_x(page, i);
        eui_int16_t x = base_x + rel_x;
        eui_int16_t y = window->window_y + page->items[i].y;
        eui_int16_t w = bmp->w;
        eui_int16_t h = bmp->h;
        eui_int16_t clip_left = (eui_int16_t)(window->window_x + dat->content_padding);
        eui_int16_t clip_right = (eui_int16_t)(window->window_x + window->window_w - dat->content_padding);
        if (x + w < clip_left || x > clip_right) continue;
        eui_draw_bitmap(c_it->canvas, x, y, bmp, 1);
        if (i == page->focus_idx) {
            eui_int32_t d_w = (eui_int32_t)dat->box_target_w - (eui_int32_t)dat->box_start_w;
            eui_int32_t d_h = (eui_int32_t)dat->box_target_h - (eui_int32_t)dat->box_start_h;
            eui_uint16_t cur_w = (eui_uint16_t)((eui_int32_t)dat->box_start_w + d_w * dat->box_permille / 1000);
            eui_uint16_t cur_h = (eui_uint16_t)((eui_int32_t)dat->box_start_h + d_h * dat->box_permille / 1000);
            eui_int16_t content_w = window->window_w - 2 * dat->content_padding;
            int fx = window->window_x + dat->content_padding + (content_w - (eui_int16_t)cur_w) / 2;
            int center_y = (int)y + (bmp->h) / 2;
            int fy = center_y - (int)cur_h / 2;
            ESGUI_WidgetBmpFocusBoxAnim(c_it->canvas, fx, fy, cur_w, cur_h);
        }
    }
    canvas_clip_pop(c_it->canvas);
    if (page->items[page->focus_idx].label) {
        const char *label = page->items[page->focus_idx].label;
        int text_w = eui_get_text_width(&ESGUI_DEFAULT_FONT, label);
        int max_w = window->window_w - 10;
        int text_x = (int)window->window_x + ((int)window->window_w - text_w) / 2;
        if (text_x < (int)(window->window_x + 5)) text_x = (int)(window->window_x + 5);
        eui_draw_text_clip(c_it->canvas, text_x,
            window->window_y + dat->label_anim_y,
            &ESGUI_DEFAULT_FONT, label, EUI_MODE_SET, max_w);
    }
    canvas_clip_pop(c_it->canvas);
}

/**
 * @brief BMP 列表弹窗滚动标题版本销毁回调
 */
void esgui_default_bmp_list_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page) {
    if (page == ESGUI_NULL) return;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = page->draw_data;
    if (dat != ESGUI_NULL) {
        anim_stop_all(&dat->title_scroll_x);
        anim_stop_all(&page->items[0].x);
        anim_stop_all(&dat->box_permille);
        anim_stop_all(&dat->label_anim_y);
        popup_data_free();
        page->draw_data = ESGUI_NULL;
    }
    page->render_ctx = ESGUI_NULL;
}

static const esgui_page_vtable_t bmp_list_scroll_title_popwindow_vtable = {
    .on_create                = esgui_default_bmp_list_scroll_title_popwindow_on_create,
    .on_destroy               = esgui_default_bmp_list_scroll_title_popwindow_on_destroy,
    .on_draw                  = esgui_default_bmp_list_scroll_title_popwindow_on_draw,
    .special_item_draw        = ESGUI_NULL,
    .get_special_item_draw_w  = ESGUI_NULL,
    .on_input                 = esgui_default_bmp_list_popwindow_on_input,
    .on_focus_change          = esgui_default_bmp_list_popwindow_on_focus_change,
    .on_page_chenge           = esgui_default_bmp_list_popwindow_on_page_change,
};

/**
 * @brief 创建 BMP 列表弹窗滚动标题版本
 */
void ESGUI_DefaultBMPListScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char *title,
    eui_uint16_t window_w, eui_uint16_t window_h,
    ESGUI_MenuItem_T *items, eui_uint32_t item_num) {
    if (window == ESGUI_NULL || items == ESGUI_NULL || item_num == 0) return;
    memset(window, 0, sizeof(ESGUI_PopWindow_T));
    window->vtbl     = &bmp_list_scroll_title_popwindow_vtable;
    window->title    = (title == ESGUI_NULL) ? "" : title;
    window->window_w = window_w;
    window->window_h = window_h;
    window->items    = items;
    window->item_num = (eui_uint16_t)item_num;
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT *dat = popup_data_alloc();
    window->draw_data = dat;
}

#endif /* ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE */




/* ============================================================
 * 七、通用弹窗内存池（Union 定义在所有弹窗数据结构之后）
 * ============================================================
 * 由于同一时间只能存在一个弹窗，所有弹窗类型共享一块内存。
 * 使用 Union 确保内存大小等于最大成员，避免为每个弹窗单独分配。
 */

#if (ESGUI_ENABLE_POPUP_MESSAGE || ESGUI_ENABLE_POPUP_BOOL || ESGUI_ENABLE_POPUP_VALUE || ESGUI_ENABLE_POPUP_TEXTLIST || ESGUI_ENABLE_POPUP_BMPLIST)

/**
 * @brief 弹窗数据 Union（所有弹窗数据结构的联合体）
 * @note  大小等于最大成员，确保任意弹窗类型都能容纳。
 */
typedef union {
#if ESGUI_ENABLE_POPUP_MESSAGE
    ESGUI_DEFAULT_MESSAGE_WINDOW_DAT    msg;    /**< 消息弹窗数据 */
#endif
#if ESGUI_ENABLE_POPUP_BOOL
    ESGUI_DEFAULT_BOOL_WONDOW_DAT       boo;    /**< 布尔弹窗数据 */
#endif
#if ESGUI_ENABLE_POPUP_VALUE
    ESGUI_DEFAULT_VALUE_WINDOW_DAT      val;    /**< 值弹窗数据 */
#endif
#if ESGUI_ENABLE_POPUP_TEXTLIST
    ESGUI_DEFAULT_TEXT_LIST_WINDOW_DAT  txt;    /**< 文本列表弹窗数据 */
#endif
#if ESGUI_ENABLE_POPUP_BMPLIST
    ESGUI_DEFAULT_BMP_LIST_WINDOW_DAT   bmp;    /**< BMP 列表弹窗数据 */
#endif
} ESGUI_PopWindowData_Union;

/** @brief 通用弹窗数据静态实例 */
static ESGUI_PopWindowData_Union s_popup_data;
/** @brief 弹窗数据占用标志（0=空闲，1=占用） */
static eui_uint8_t s_popup_data_busy = 0;

/**
 * @brief 分配通用弹窗数据内存
 * @return 数据指针，若已有弹窗在运行则返回 ESGUI_NULL
 * @note  自动清零内存，确保初始状态干净
 */
static void* popup_data_alloc()
{
    if (s_popup_data_busy) return ESGUI_NULL;
    s_popup_data_busy = 1;
    memset(&s_popup_data, 0, sizeof(s_popup_data));
    return (void*)&s_popup_data;
}

/**
 * @brief 释放通用弹窗数据内存
 * @note  仅清零占用标志，不实际清除数据（下次 alloc 会 memset）
 */
static void popup_data_free()
{
    s_popup_data_busy = 0;
}

#endif