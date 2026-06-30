#ifndef ESGUI_DEFAULTVTB_CONFIG_H
#define ESGUI_DEFAULTVTB_CONFIG_H

/**
 * @file ESGUI_DefaultVtbConfig.h
 * @brief ESGUI 默认显示效果的编译时配置头文件
 * @author E_LJF
 * @date 2026/06
 *
 * 本文件通过宏开关控制默认虚函数表（ESGUI_PageDefaltVtbl）的编译内容。
 * 所有宏均支持在编译命令行中通过 -D 覆盖，实现按需裁剪，减小 Flash 占用。
 * 例如：gcc -DESGUI_ENABLE_POPUP_MESSAGE=0 ... 可完全剔除消息弹窗代码。
 */

/* ============================================================
 * 一、样式参数配置（像素单位，可通过编译宏覆盖）
 * ============================================================ */

#ifndef ESGUI_PROGRESS_BAR_W
/**
 * @brief 进度条底座宽度（像素）
 * @note  同时影响横向进度条的高度和纵向进度条的宽度
 */
#define ESGUI_PROGRESS_BAR_W     3
#endif

#ifndef ESGUI_ITEM_SPACING
/**
 * @brief 文本菜单条目之间的垂直间距（像素）
 * @note  实际条目步进 = 字体高度 + ESGUI_ITEM_SPACING
 */
#define ESGUI_ITEM_SPACING       3
#endif

#ifndef ESGUI_LONG_TEXT_GAP
/**
 * @brief 长文本滚动动画中，首尾文本之间的空白间隔（像素）
 * @note  值越大，环形滚动时两段文本间距越宽
 */
#define ESGUI_LONG_TEXT_GAP      25
#endif

#ifndef ESGUI_BOOL_POPWINDOW_TEXT_GAP
/**
 * @brief 布尔弹窗中 "OK" 与 "Cancel" 按钮之间的水平间距（像素）
 */
#define ESGUI_BOOL_POPWINDOW_TEXT_GAP      20
#endif

#ifndef ESGUI_FOCUS_BOX_PAD_X
/**
 * @brief 文本焦点框比文本宽度多出的水平内边距（像素）
 * @note  focus_box_w = text_width + ESGUI_FOCUS_BOX_PAD_X
 */
#define ESGUI_FOCUS_BOX_PAD_X    4
#endif

#ifndef ESGUI_TEXT_MARGIN_X
/**
 * @brief 文本绘制时相对于左侧的边距（像素）
 */
#define ESGUI_TEXT_MARGIN_X      3
#endif

#ifndef ESGUI_TITLE_LINE_OFFSET
/**
 * @brief 标题下方分割线与标题底部的垂直偏移（像素）
 */
#define ESGUI_TITLE_LINE_OFFSET  2
#endif

#ifndef ESGUI_LABEL_TMP_BUF_SIZE
/**
 * @brief 临时文本缓冲区的最大长度（字节）
 * @note  用于去除标记符后的纯文本拷贝，需大于最长单条文本长度
 */
#define ESGUI_LABEL_TMP_BUF_SIZE 64
#endif

#ifndef BMP_PAGE_DATA_POOL_SIZE
/**
 * @brief BMP 菜单页面私有数据的静态内存池大小（槽位数）
 * @note  默认与最大菜单深度相同，保证每层菜单都能有一个 BMP 页面
 */
#define BMP_PAGE_DATA_POOL_SIZE  (ESGUI_MAX_MENU_DEPTH)
#endif

#ifndef ESGUI_BMP_ITEM_GAP
/**
 * @brief BMP 菜单中相邻图片之间的水平间距（像素）
 */
#define ESGUI_BMP_ITEM_GAP      15
#endif

#ifndef ESGUI_PAGE_TRANSITION_ANIM_TIME
/**
 * @brief 页面切换百叶窗过渡动画的持续时间（毫秒）
 * @note  值越大，页面淡入/淡出越慢
 */
#define ESGUI_PAGE_TRANSITION_ANIM_TIME 250
#endif


#ifndef ESGUI_PAGE_TRANSITION_TYPE
/**
 * @brief 页面切换效果类型
 * @note  0 = 百叶窗淡入淡出（默认，交错扫描线遮罩）
 *        1 = 缩放效果（退出时页面向中心收缩，进入时从中心展开并放大条目）
 */
#define ESGUI_PAGE_TRANSITION_TYPE  0
#endif


/* ============================================================
 * 二、页面类型裁剪（关闭不用的页面类型可减小 Flash）
 * ============================================================ */

#ifndef ESGUI_ENABLE_TEXT_MENU
/**
 * @brief 使能默认文本菜单页面
 * @note  0=禁用，剔除 esgui_text_menu_* 系列函数，显著减容
 */
#define ESGUI_ENABLE_TEXT_MENU   1
#endif

#ifndef ESGUI_ENABLE_BMP_MENU
/**
 * @brief 使能默认图形（BMP）菜单页面
 * @note  0=禁用，剔除 esgui_bmp_menu_* 系列函数
 */
#define ESGUI_ENABLE_BMP_MENU    1
#endif


/* ============================================================
 * 三、弹窗类型裁剪（按需关闭可大幅减小 Flash 占用）
 * ============================================================ */

#ifndef ESGUI_ENABLE_POPUP_MESSAGE
/**
 * @brief 使能消息弹窗（单按钮提示框）
 */
#define ESGUI_ENABLE_POPUP_MESSAGE   1
#endif

#ifndef ESGUI_ENABLE_POPUP_BOOL
/**
 * @brief 使能布尔弹窗（OK / Cancel 二选一）
 */
#define ESGUI_ENABLE_POPUP_BOOL      1
#endif

#ifndef ESGUI_ENABLE_POPUP_VALUE
/**
 * @brief 使能值弹窗（带进度条数值调节）
 */
#define ESGUI_ENABLE_POPUP_VALUE     1
#endif

#ifndef ESGUI_ENABLE_POPUP_TEXTLIST
/**
 * @brief 使能文本列表弹窗（在弹窗内显示可滚动文本列表）
 */
#define ESGUI_ENABLE_POPUP_TEXTLIST  1
#endif

#ifndef ESGUI_ENABLE_POPUP_BMPLIST
/**
 * @brief 使能 BMP 列表弹窗（在弹窗内显示可滚动图片列表）
 */
#define ESGUI_ENABLE_POPUP_BMPLIST   1
#endif


/* ============================================================
 * 四、绘制图元裁剪（关闭不用的图元可减小 Flash）
 * ============================================================ */

#ifndef ESGUI_ENABLE_DRAW_TRIANGLE
/**
 * @brief 使能三角形绘制函数（eui_draw_triangle_* 系列）
 * @note  若默认效果未使用三角形，可设为 0 减容
 */
#define ESGUI_ENABLE_DRAW_TRIANGLE   1
#endif


/* ============================================================
 * 五、动画缓动曲线裁剪（关闭不用的曲线可减小 Flash）
 * ============================================================ */

#ifndef ESGUI_ANIM_ENABLE_OVERSHOOT
/**
 * @brief 使能 Overshoot（冲过）缓动曲线
 * @note  用于弹窗入场等弹性效果
 */
#define ESGUI_ANIM_ENABLE_OVERSHOOT  1
#endif

#ifndef ESGUI_ANIM_ENABLE_BOUNCE
/**
 * @brief 使能 Bounce（弹跳）缓动曲线
 */
#define ESGUI_ANIM_ENABLE_BOUNCE     1
#endif

#ifndef ESGUI_ANIM_ENABLE_STEP
/**
 * @brief 使能 Step（阶跃）缓动曲线
 * @note  直接跳转到终点，不经过中间值
 */
#define ESGUI_ANIM_ENABLE_STEP       1
#endif


#endif /* ESGUI_DEFAULTVTB_CONFIG_H */