//
// Created by E_LJF on 2026/6/6.
// 重构版本：降低耦合，提高单片机运行效率
//

#ifndef ESGUI_ESGUI_PAGEDEFALT_H
#define ESGUI_ESGUI_PAGEDEFALT_H

#include "ESGUI.h"

/* GIF 动图组件（BMP 菜单 GIF 条目依赖其类型定义） */
#if ESGUI_ENABLE_GIF
#include "ESGUI_GIF.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

/** @brief 默认字体，可通过编译宏覆盖以适配不同硬件 */
#ifndef ESGUI_DEFAULT_FONT
#define ESGUI_DEFAULT_FONT       eui_test_font
#include "eui_test_font.h"
#endif

/* ========== 值描述符（类型定义不占 Flash，保留） ========== */
typedef struct {
    void *ctx;
    eui_uint16_t (*get_permille)(void *ctx);
    eui_uint8_t (*to_string)(void *ctx, char *buf, eui_uint16_t size);
    bool (*step)(void *ctx, eui_int8_t direction);
} ESGUI_ValueDesc_T;

/* ========== 默认文本菜单 ========== */
#if ESGUI_ENABLE_TEXT_MENU

/**
 * @brief 文本菜单页面私有数据（运行时状态）
 * @note  每个文本菜单页面在 on_create 时从静态池分配一个实例。
 *        所有动画驱动的属性（focus_box_w, focus_box_y, line_len 等）
 *        均作为动画变量，由 anim_start 修改，on_draw 读取。
 *
 *        用户自定义切换效果时，可通过 page->draw_data 访问本结构体：
 *          ESGUI_DEFALT_TEXT_PAGE_DATA_T *pd = page->draw_data;
 */
typedef struct esgui_defalt_text_page_data {
    eui_uint16_t progress_bar_permille; /**< 进度条千分比（0~1000） */
    eui_int16_t  focus_box_w;           /**< 焦点框当前宽度（像素） */
    eui_int16_t  focus_box_y;           /**< 焦点框当前 Y 坐标（像素） */
    eui_uint16_t line_len;              /**< 标题下方分割线当前长度（像素） */
    eui_int16_t  long_text_x;           /**< 长文本滚动动画的当前 X 偏移（像素） */
    eui_uint16_t text_len;              /**< 当前焦点条目的纯文本宽度（像素） */
    eui_uint16_t text_need_len;         /**< 当前焦点条目右侧需预留的总宽度（进度条+特殊标记） */
    eui_uint16_t buff;                  /**< 屏幕可见区域最多容纳的条目数 */
    eui_uint16_t stay;                  /**< 焦点保持在顶部/中间区域的阈值索引 */
    eui_uint16_t item_stride;           /**< 相邻条目之间的 Y 方向步进（像素）= font_height + spacing */
    eui_uint8_t  title_h;               /**< 标题文本高度（像素），无标题时为 0 */
    eui_uint8_t  font_height;           /**< 当前字体行高（像素） */
    eui_uint8_t  flags;                 /**< 状态标志位：bit0=长文本动画已启动, bit1=焦点条目是长文本 */
    eui_uint16_t trans_count;           /**< 页面过渡遮罩级别（0~8，0=无遮罩）；用户自定义效果时可复用 */
    eui_uint8_t  trans_active;          /**< 过渡动画是否正在运行（1=运行中，屏蔽按键）；用户自定义效果时可复用 */
    eui_uint8_t  first_push;            /**< 1=首次被 Push（需要完整入场动画） */
} ESGUI_DEFALT_TEXT_PAGE_DATA_T;

void esgui_text_menu_defalt_on_create(ESGUI_MenuPage_T *page);
void esgui_text_menu_defalt_on_destroy(ESGUI_MenuPage_T *page);
void esgui_text_menu_defalt_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx);
ESGUI_MenuAction_T esgui_menu_defalt_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e);
void esgui_text_menu_defalt_on_draw(ESGUI_MenuPage_T *page);
eui_uint16_t esgui_text_menu_defalt_special_item_draw(ESGUI_MenuPage_T *page, eui_uint16_t indx);
eui_uint16_t esgui_text_menu_defalt_get_special_item_draw_w(ESGUI_MenuPage_T *page, eui_uint16_t indx);
void esgui_text_menu_default_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action);

void ESGUI_DefaltTextMenuCreate(ESGUI_MenuPage_T *page,
                                ESGUI_MenuItem_T *items, const char *title,
                                eui_uint32_t item_num);

#endif /* ESGUI_ENABLE_TEXT_MENU */

/* ========== 默认 BMP 菜单 ========== */
#if ESGUI_ENABLE_BMP_MENU

/**
 * @brief BMP 菜单页面私有数据（运行时状态）
 * @note  包含图片布局参数、进度条、分割线、焦点框、标签动画等状态。
 */
typedef struct esgui_default_bmp_menu_dat {
    eui_uint16_t font_height;       /**< 字体行高（像素） */
    eui_uint16_t label_y;           /**< 标签基准 Y 坐标 */
    eui_int16_t  label_anim_y;      /**< 标签动画当前 Y 坐标 */
    eui_uint16_t bmp_y;             /**< 图片区域基准 Y 坐标 */
    eui_uint16_t progress_bar_h;    /**< 顶部横向进度条高度 */
    eui_uint16_t progress_bar_per;  /**< 进度条千分比（0~1000） */
    eui_uint16_t line_len;          /**< 分割线当前长度 */
    eui_uint16_t box_start_w;       /**< 焦点框动画起始宽度 */
    eui_uint16_t box_start_h;       /**< 焦点框动画起始高度 */
    eui_uint16_t box_target_w;      /**< 焦点框动画目标宽度 */
    eui_uint16_t box_target_h;      /**< 焦点框动画目标高度 */
    eui_uint16_t box_permille;      /**< 焦点框生长动画进度（0~1000） */
    eui_uint16_t trans_count;       /**< 过渡遮罩级别（0~8） */
    eui_uint8_t  trans_active;      /**< 过渡动画是否运行中 */
    eui_uint8_t  first_push;        /**< 1=首次 Push（需要完整入场动画） */
#if ESGUI_ENABLE_GIF
    /* —— GIF 条目（名称末尾带 "\x03/7" 标记，icon 指向 ESGUI_GIF_T 描述符） —— */
    eui_uint8_t  gif_is[ESGUI_BMP_MENU_MAX_ITEMS]; /**< 各项是否为 GIF（0/1），on_create 预扫描 */
    ESGUI_GIF_T  gif_play;      /**< 当前焦点 GIF 的播放槽（描述信息从描述符装载，播放状态独立） */
    const ESGUI_GIF_T *gif_desc;/**< 播放槽当前绑定的 GIF 描述符（焦点切换时重装载） */
    eui_uint16_t gif_pulse;     /**< 脉冲动画变量：焦点 GIF 播放期间保持页面持续刷新 */
#endif
} ESGUI_DEFAULT_BMP_MENU_DAT;

void esgui_bmp_menu_defalt_on_create(ESGUI_MenuPage_T *page);
void esgui_bmp_menu_defalt_on_destroy(ESGUI_MenuPage_T *page);
ESGUI_MenuAction_T esgui_bmp_defalt_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e);
void esgui_bmp_menu_defalt_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx);
void esgui_bmp_menu_default_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action);
void esgui_bmp_menu_defalt_on_draw(ESGUI_MenuPage_T *page);
#if ESGUI_ENABLE_GIF
/* 特殊条目绘制系列：名称末尾带 "\x03/7" 标记的项按 GIF 显示
 *（选中循环播放 / 未选中显示第 0 帧） */
eui_uint16_t esgui_bmp_menu_defalt_special_item_draw(ESGUI_MenuPage_T *page, eui_uint16_t indx);
eui_uint16_t esgui_bmp_menu_defalt_get_special_item_draw_w(ESGUI_MenuPage_T *page, eui_uint16_t indx);
#endif
void ESGUI_DefaultBMPMenuCreate(ESGUI_MenuPage_T *page, const char *title,
                                ESGUI_MenuItem_T *items, eui_uint32_t item_num);

#endif /* ESGUI_ENABLE_BMP_MENU */

/* ========== 默认 3D 菜单 ========== */
#if (ESGUI_ENABLE_3D_MENU && ESGUI_ENABLE_3D)

/**
 * @brief 3D 菜单页面私有数据（运行时状态）
 * @note  布局/动画字段与 BMP 菜单一致，仅把图片替换为 3D 线框模型，
 *        并增加透视、缩放、焦点旋转等 3D 专有状态。
 */
typedef struct esgui_default_3d_menu_dat {
    eui_uint16_t font_height;       /**< 字体行高（像素） */
    eui_uint16_t label_y;           /**< 标签基准 Y 坐标 */
    eui_int16_t  label_anim_y;      /**< 标签动画当前 Y 坐标 */
    eui_uint16_t model_y;           /**< 模型区域基准 Y 坐标 */
    eui_uint16_t model_center_y;    /**< 模型区域中心 Y 坐标 */
    eui_uint16_t progress_bar_h;    /**< 顶部横向进度条高度 */
    eui_uint16_t progress_bar_per;  /**< 进度条千分比（0~1000） */
    eui_uint16_t line_len;          /**< 分割线当前长度 */
    eui_uint16_t box_start_w;       /**< 焦点框动画起始宽度 */
    eui_uint16_t box_start_h;       /**< 焦点框动画起始高度 */
    eui_uint16_t box_target_w;      /**< 焦点框动画目标宽度 */
    eui_uint16_t box_target_h;      /**< 焦点框动画目标高度 */
    eui_uint16_t box_permille;      /**< 焦点框生长动画进度（0~1000） */
    eui_uint16_t trans_count;       /**< 过渡遮罩级别（0~8） */
    eui_uint8_t  trans_active;      /**< 过渡动画是否运行中 */
    eui_uint8_t  first_push;        /**< 1=首次 Push（需要完整入场动画） */
    eui_int32_t  focal;             /**< 透视焦距（像素） */
    eui_int32_t  model_depth;       /**< 模型深度（世界坐标 y，须 > 0） */
    eui_uint16_t slot_w;            /**< 模型槽位宽（模型显示尺寸 + 间距） */
    eui_uint16_t model_display_h;   /**< 模型目标显示高度（自适应） */
    eui_uint16_t focus_box_h;       /**< 焦点框边长（距分界线各 FOCUS_MARGIN px） */
    eui_int32_t  item_scale_q8[ESGUI_3D_MENU_MAX_ITEMS]; /**< 每模型缩放（Q8） */
    eui_int32_t  focus_rot_z;       /**< 焦点模型绕 Z 轴旋转角（度） */
} ESGUI_DEFAULT_3D_MENU_DAT;

void esgui_3d_menu_defalt_on_create(ESGUI_MenuPage_T *page);
void esgui_3d_menu_defalt_on_destroy(ESGUI_MenuPage_T *page);
ESGUI_MenuAction_T esgui_3d_menu_defalt_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e);
void esgui_3d_menu_defalt_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx);
void esgui_3d_menu_default_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action);
void esgui_3d_menu_defalt_on_draw(ESGUI_MenuPage_T *page);
void ESGUI_Default3DMenuCreate(ESGUI_MenuPage_T *page, const char *title,
                               ESGUI_MenuItem_T *items, eui_uint32_t item_num);

#endif /* (ESGUI_ENABLE_3D_MENU && ESGUI_ENABLE_3D) */

/* ========== 消息弹窗 ========== */
#if ESGUI_ENABLE_POPUP_MESSAGE

void esgui_default_message_popwindow_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action);
ESGUI_MenuAction_T esgui_default_message_popwindow_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e);
void esgui_default_message_popwindow_on_draw(ESGUI_MenuPage_T *page);
void esgui_default_message_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_message_popwindow_on_destroy(ESGUI_MenuPage_T *page);
void ESGUI_DefaultMessagePopWindowCreate(ESGUI_PopWindow_T *window,
    const char* message, eui_uint16_t window_w, eui_uint16_t window_h, _Bool button_en);

#endif /* ESGUI_ENABLE_POPUP_MESSAGE */

#if ESGUI_ENABLE_POPUP_MESSAGE_SCROLL_TITLE

void esgui_default_message_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_message_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page);
void ESGUI_DefaultMessageScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window,
    const char* message, eui_uint16_t window_w, eui_uint16_t window_h, _Bool button_en);

#endif /* ESGUI_ENABLE_POPUP_MESSAGE_SCROLL_TITLE */

/* ========== 布尔弹窗 ========== */
#if ESGUI_ENABLE_POPUP_BOOL

void esgui_default_bool_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_bool_popwindow_on_destroy(ESGUI_MenuPage_T *page);
ESGUI_MenuAction_T esgui_default_bool_popwindow_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e);
void esgui_default_bool_popwindow_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx);
void esgui_default_bool_popwindow_on_draw(ESGUI_MenuPage_T *page);
void esgui_default_bool_popwindow_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action);
void ESGUI_DefaultBoolPopWindowCreate(ESGUI_PopWindow_T *window, const char* message,
                                        eui_uint16_t window_w, eui_uint16_t window_h, bool *boo_val);

#endif /* ESGUI_ENABLE_POPUP_BOOL */

#if ESGUI_ENABLE_POPUP_BOOL_SCROLL_TITLE

void esgui_default_bool_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_bool_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page);
void esgui_default_bool_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page);
void ESGUI_DefaultBoolScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char* message,
                                                    eui_uint16_t window_w, eui_uint16_t window_h, bool *boo_val);

#endif /* ESGUI_ENABLE_POPUP_BOOL_SCROLL_TITLE */

/* ========== 值弹窗 ========== */
#if ESGUI_ENABLE_POPUP_VALUE

void esgui_default_value_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_value_popwindow_on_destroy(ESGUI_MenuPage_T *page);
ESGUI_MenuAction_T esgui_default_value_popwindow_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e);
void esgui_default_value_popwindow_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx);
void esgui_default_value_popwindow_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action);
void esgui_default_value_popwindow_on_draw(ESGUI_MenuPage_T *page);
void ESGUI_DefaultValuePopWindowCreate(ESGUI_PopWindow_T *window, const char* message,
                                         eui_uint16_t window_w, eui_uint16_t window_h, ESGUI_ValueDesc_T *value_desc);

#endif /* ESGUI_ENABLE_POPUP_VALUE */

#if ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE

void esgui_default_value_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_value_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page);
void esgui_default_value_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page);
void ESGUI_DefaultValueScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char* message,
                                                    eui_uint16_t window_w, eui_uint16_t window_h, ESGUI_ValueDesc_T *value_desc);

#endif /* ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE */

/* ========== 文本列表弹窗 ========== */
#if ESGUI_ENABLE_POPUP_TEXTLIST

void esgui_default_text_list_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_text_list_popwindow_on_destroy(ESGUI_MenuPage_T *page);
ESGUI_MenuAction_T esgui_default_text_list_popwindow_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e);
void esgui_default_text_list_popwindow_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx);
void esgui_text_list_popwindow_default_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action);
void esgui_default_text_list_popwindow_on_draw(ESGUI_MenuPage_T *page);
void ESGUI_DefaultTextListPopWindowCreate(ESGUI_PopWindow_T *window, eui_uint16_t window_w, eui_uint16_t window_h,
                                            ESGUI_MenuItem_T *items, eui_uint32_t item_num);

#endif /* ESGUI_ENABLE_POPUP_TEXTLIST */

#if ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE

void esgui_default_text_list_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_text_list_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page);
void esgui_default_text_list_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page);
void ESGUI_DefaultTextListScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char *title, eui_uint16_t window_w, eui_uint16_t window_h,
                                                        ESGUI_MenuItem_T *items, eui_uint32_t item_num);

#endif /* ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE */

/* ========== BMP 列表弹窗 ========== */
#if ESGUI_ENABLE_POPUP_BMPLIST

void esgui_default_bmp_list_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_bmp_list_popwindow_on_destroy(ESGUI_MenuPage_T *page);
ESGUI_MenuAction_T esgui_default_bmp_list_popwindow_on_input(ESGUI_MenuPage_T *page, ESGUI_EventCode_t e);
void esgui_default_bmp_list_popwindow_on_focus_change(ESGUI_MenuPage_T *page, eui_uint16_t old_idx, eui_uint16_t new_idx);
void esgui_default_bmp_list_popwindow_on_page_change(ESGUI_MenuPage_T *page, ESGUI_MenuAction_T *action);
void esgui_default_bmp_list_popwindow_on_draw(ESGUI_MenuPage_T *page);
void ESGUI_DefaultBMPListPopWindowCreate(ESGUI_PopWindow_T *window, const char *title,
                                         eui_uint16_t window_w, eui_uint16_t window_h,
                                         ESGUI_MenuItem_T *items, eui_uint32_t item_num);

#endif /* ESGUI_ENABLE_POPUP_BMPLIST */

#if ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE

void esgui_default_bmp_list_scroll_title_popwindow_on_create(ESGUI_MenuPage_T *page);
void esgui_default_bmp_list_scroll_title_popwindow_on_draw(ESGUI_MenuPage_T *page);
void esgui_default_bmp_list_scroll_title_popwindow_on_destroy(ESGUI_MenuPage_T *page);
void ESGUI_DefaultBMPListScrollTitlePopWindowCreate(ESGUI_PopWindow_T *window, const char *title,
                                                      eui_uint16_t window_w, eui_uint16_t window_h,
                                                      ESGUI_MenuItem_T *items, eui_uint32_t item_num);

#endif /* ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE */

#ifdef __cplusplus
}
#endif

#endif /* ESGUI_ESGUI_PAGEDEFALT_H */