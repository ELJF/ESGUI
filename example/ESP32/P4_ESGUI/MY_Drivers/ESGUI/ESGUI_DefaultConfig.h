#ifndef ESGUI_DEFAULT_CONFIG_H
#define ESGUI_DEFAULT_CONFIG_H

/**
 * @file ESGUI_DefaultConfig.h
 * @brief ESGUI 默认显示效果的编译时配置头文件
 * @author E_LJF
 * @date 2026/06
 *
 * 本文件通过宏开关控制默认虚函数表（ESGUI_PageDefaltVtbl）的编译内容。
 * 所有宏均支持在编译命令行中通过 -D 覆盖，实现按需裁剪，减小 Flash 占用。
 * 例如：gcc -DESGUI_ENABLE_POPUP_MESSAGE=0 ... 可完全剔除消息弹窗代码。
 */


#define ESGUI_MAX_MENU_DEPTH    8   //最大菜单深度


/* ============================================================
 * 命令队列配置
 * ============================================================ */

#ifndef ESGUI_ENABLE_MULTITHREAD
/**
 * @brief 多线程支持开关
 * @note  1 = 开启：所有 Async 入口走无锁命令队列（可从任意任务/中断调用）
 *        0 = 关闭：Async 入口退化为直接同步执行（单线程，零队列开销，省内存）
 */
#define ESGUI_ENABLE_MULTITHREAD  1
#endif

#ifndef ESGUI_CMD_QUEUE_SIZE
/**
 * @brief 命令队列大小（必须是 2 的幂，仅 ESGUI_ENABLE_MULTITHREAD=1 时生效）
 * @note  按键事件与菜单动作（入栈/出栈/弹窗/覆盖层/动画）共用一条无锁队列，
 *        ESGUI_FeedKey / ESGUI_*Async 入队（可从任意任务/中断调用），
 *        ESGUI_Tick 在 UI 线程内取出并逐个处理。
 */
#define ESGUI_CMD_QUEUE_SIZE  32
#endif

#ifndef ESGUI_SYNC_MODE
/**
 * @brief 命令队列同步方式（仅 ESGUI_ENABLE_MULTITHREAD=1 时生效）
 * @note  0 = 自动适配（默认）：由编译器适配宏层选择同步实现，
 *          - GCC / Clang / ARM Compiler 6：使用内建原子 __atomic_*，
 *            多核安全（生产/消费可运行在不同 CPU 核上）、中断安全；
 *          - 其他编译器（MSVC / IAR / Keil ARMCC5 等）：无内建原子时
 *            自动退化为普通 volatile 读写（单核语义，需单核 + 单生产者）。
 *        1 = 纯软件（强制 volatile，零内建原子、零 asm、零 RTOS）：
 *          - 任何 C 编译器均可编译；
 *          - 正确性前提（必须全部满足，否则请改用 0）：
 *            ① 单生产者：每个队列/收件箱仅一个任务/中断写入；
 *            ② 单消费者：仅 UI 线程在 ESGUI_Tick 内出队；
 *            ③ 单核：生产与消费在同一 CPU 核上（依赖同核 volatile 按序 +
 *               对齐 32 位读写原子，主流 MCU 架构均满足）。
 */
#define ESGUI_SYNC_MODE  0
#endif

#ifndef ESGUI_MAX_PRODUCER
/**
 * @brief 生产者收件箱最大数量（多生产者收拢）
 * @note  每注册一个收件箱，UI 线程在 ESGUI_Tick 内多轮询一个 SPSC 队列，
 *        用于把"多任务调用 UI"收拢为"每任务单生产者 + UI 唯一消费者"。
 */
#define ESGUI_MAX_PRODUCER  4
#endif

#ifndef ESGUI_PRODUCER_BOX_CAP
/**
 * @brief 单个生产者收件箱容量（必须是 2 的幂）
 * @note  每箱占 ESGUI_PRODUCER_BOX_CAP * sizeof(ESGUI_Cmd_T) 字节 RAM；
 *        满时新命令被丢弃（可接受，与主命令队列策略一致）。
 */
#define ESGUI_PRODUCER_BOX_CAP  8
#endif



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

#ifndef ESGUI_POPUP_TITLE_SCROLL_MARGIN
/**
 * @brief 弹窗滚动标题与左右边界的最小间距（像素）
 * @note  标题长度超过弹窗宽度减去 2*本值时，自动启动水平滚动动画
 */
#define ESGUI_POPUP_TITLE_SCROLL_MARGIN    3
#endif

#ifndef ESGUI_ENABLE_POPUP_MESSAGE
/**
 * @brief 使能消息弹窗（单按钮提示框）
 */
#define ESGUI_ENABLE_POPUP_MESSAGE   1
#endif

#ifndef ESGUI_ENABLE_POPUP_MESSAGE_SCROLL_TITLE
/**
 * @brief 使能消息弹窗滚动标题版本
 * @note  标题过长时自动水平滚动，需同时开启 ESGUI_ENABLE_POPUP_MESSAGE
 */
#define ESGUI_ENABLE_POPUP_MESSAGE_SCROLL_TITLE  1
#endif

#ifndef ESGUI_ENABLE_POPUP_BOOL
/**
 * @brief 使能布尔弹窗（OK / Cancel 二选一）
 */
#define ESGUI_ENABLE_POPUP_BOOL      1
#endif

#ifndef ESGUI_ENABLE_POPUP_BOOL_SCROLL_TITLE
/**
 * @brief 使能布尔弹窗滚动标题版本
 */
#define ESGUI_ENABLE_POPUP_BOOL_SCROLL_TITLE     1
#endif

#ifndef ESGUI_ENABLE_POPUP_VALUE
/**
 * @brief 使能值弹窗（带进度条数值调节）
 */
#define ESGUI_ENABLE_POPUP_VALUE     1
#endif

#ifndef ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE
/**
 * @brief 使能值弹窗滚动标题版本
 */
#define ESGUI_ENABLE_POPUP_VALUE_SCROLL_TITLE    1
#endif

#ifndef ESGUI_ENABLE_POPUP_TEXTLIST
/**
 * @brief 使能文本列表弹窗（在弹窗内显示可滚动文本列表）
 */
#define ESGUI_ENABLE_POPUP_TEXTLIST  1
#endif

#ifndef ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE
/**
 * @brief 使能文本列表弹窗滚动标题版本
 * @note  原版不显示标题，此版本增加标题栏支持
 */
#define ESGUI_ENABLE_POPUP_TEXTLIST_SCROLL_TITLE 1
#endif

#ifndef ESGUI_ENABLE_POPUP_BMPLIST
/**
 * @brief 使能 BMP 列表弹窗（在弹窗内显示可滚动图片列表）
 */
#define ESGUI_ENABLE_POPUP_BMPLIST   1
#endif

#ifndef ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE
/**
 * @brief 使能 BMP 列表弹窗滚动标题版本
 */
#define ESGUI_ENABLE_POPUP_BMPLIST_SCROLL_TITLE  1
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


/* ============================================================
 * 六、覆盖层（Overlay）配置
 * ============================================================ */

#ifndef ESGUI_MAX_OVERLAY
/**
 * @brief 覆盖层最大数量
 * @note  覆盖层用于常驻显示的图形/组件（如 3D 线框图、悬浮时钟、角标等），
 *        独立于菜单页面与弹窗，始终叠加在二者之上。按需调大以支持更多常驻组件。
 */
#define ESGUI_MAX_OVERLAY   4
#endif


/* ============================================================
 * 七、3D 渲染模块裁剪
 * ============================================================ */

#ifndef ESGUI_ENABLE_3D
/**
 * @brief 使能 3D 线框渲染模块（ESGUI_3D.c）
 * @note  0=禁用，剔除整个 3D 模块（模型/变换/投影），减小 Flash
 */
#define ESGUI_ENABLE_3D   1
#endif


#ifndef ESGUI_3D_MAX_VERTICES
/**
 * @brief 3D 单模型最大顶点数（用于绘制函数内部世界坐标缓冲）
 * @note  超出该数量的模型无法一步绘制，需用 ESGUI_3DTransformPoints 手动变换后分段处理
 */
#define ESGUI_3D_MAX_VERTICES   64
#endif


/* ============================================================
 * 八、3D 菜单配置
 * ============================================================ */

#ifndef ESGUI_ENABLE_3D_MENU
/**
 * @brief 使能默认 3D 菜单页面（用 3D 线框模型替换 BMP 图形的图形菜单）
 * @note  0=禁用，剔除 esgui_3d_menu_* 系列函数；需同时开启 ESGUI_ENABLE_3D
 */
#define ESGUI_ENABLE_3D_MENU   1
#endif

#ifndef ESGUI_3D_MENU_ITEM_GAP
/** @brief 3D 菜单中相邻模型槽位之间的水平间距（像素） */
#define ESGUI_3D_MENU_ITEM_GAP  15
#endif


#ifndef ESGUI_3D_DURATION
/** @brief 3D 菜单中焦点模型旋转一周所用时间(ms) */
#define ESGUI_3D_DURATION  3000
#endif


#ifndef ESGUI_3D_MENU_FOCAL
/** @brief 3D 菜单透视焦距（像素，越大视野越窄/透视越平缓）
 *  @note  焦距过小（广角）会让“厚”模型（如立方体）的近端面离相机很近、
 *         投影被明显放大，看起来比其他模型“更大”；调大焦距可缓解 */
#define ESGUI_3D_MENU_FOCAL     80
#endif

#ifndef ESGUI_3D_MENU_DEPTH
/** @brief 3D 菜单模型深度（世界坐标 y，须 > 0，越大投影越小） */
#define ESGUI_3D_MENU_DEPTH     40
#endif

#ifndef ESGUI_3D_MENU_FOCUS_MARGIN
/** @brief 焦点框距上下分界线的最小间距（像素），焦点框尺寸随屏幕高度自动适配 */
#define ESGUI_3D_MENU_FOCUS_MARGIN  20
#endif

#ifndef ESGUI_3D_MENU_MODEL_SCALE
/** @brief 模型尺寸占焦点框尺寸的百分比（0~100），即模型放大倍率，越小模型越小 */
#define ESGUI_3D_MENU_MODEL_SCALE  65
#endif


#ifndef ESGUI_3D_MENU_MAX_ITEMS
/** @brief 3D 菜单单页最大条目数（决定 item_scale_q8 数组大小） */
#define ESGUI_3D_MENU_MAX_ITEMS 16
#endif

#ifndef ESGUI_3D_MENU_DATA_POOL_SIZE
/** @brief 3D 菜单页面私有数据静态内存池大小（槽位数） */
#define ESGUI_3D_MENU_DATA_POOL_SIZE  (ESGUI_MAX_MENU_DEPTH)
#endif



#endif /* ESGUI_DEFAULT_CONFIG_H */