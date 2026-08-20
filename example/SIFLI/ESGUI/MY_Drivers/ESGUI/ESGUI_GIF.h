//
// Created by E_LJF on 2026/8/17.
//
// ============================================================
// GIF 动图组件（BMP 帧序列版）
// ============================================================
//
// 【是什么】
//   用一组 1bpp 页式位图（Bitmap）按时间顺序播放，形成"动图"效果。
//   适用于单色屏 UI：图标动画、加载动画、状态指示、开机动画等。
//
// 【数据格式】
//   每帧就是一张 Bitmap（与 eui_draw_bitmap 完全一致）：
//     - 1bpp 页式排列：每页 stride = w，页优先，字节内 bit n = 页内第 n 行；
//     - 帧数据放在 const 数组（Flash/ROM 均可），零解析、零拷贝；
//     - 各帧尺寸可以不同，绘制时以各自宽高为准。
//
// 【特性】
//   - 在屏幕任意位置 (x,y) 绘制，支持负坐标越界自动裁剪；
//   - 自动适配条带刷新（buf_area）与裁剪栈，页面/弹窗/覆盖层直接可用；
//   - 零动态内存、零浮点、零平台依赖，可移植到任意单色屏 MCU；
//   - ESGUI_GIFDraw 内部按 now_ms 自动推进帧，支持重复播放 / 播完暂停。
//
// 【限制】
//   - 单色（1bpp）显示：颜色由位图数据决定，无灰度/半透明；
//   - 一个 gif 实例只维护一份播放状态，对应一个播放位置
//     （同一实例在多处绘制会同步推进）；
//   - 帧推进需在 UI 线程（ESGUI_Tick 内/页面/覆盖层回调）调用，
//     与框架其余绘制函数一致。
// ============================================================
//

#ifndef ESGUI_ESGUI_GIF_H
#define ESGUI_ESGUI_GIF_H

#include "ESGUI_DefaultConfig.h"

#if ESGUI_ENABLE_GIF

#include "ESGUI_Def.h"
#include "ESGUI_BSP_Canvas.h"
#include "ESGUI_BSP_draw.h"
#include "ESGUI_BSP_BMP.h"

/* ==================== 播放模式 ==================== */

/**
 * @brief 播放模式：控制动画播完后的行为
 */
typedef enum {
    ESGUI_GIF_PLAY_LOOP = 0,   /**< 重复播放：播完自动从头继续；
                                    若 loop_count > 0，则最多播 loop_count 遍后停在末帧；
                                    loop_count = 0 表示无限循环 */
    ESGUI_GIF_PLAY_ONCE,       /**< 播完暂停：只播放一遍，随后停在最后一帧（不再推进） */
} ESGUI_GIF_PlayMode_T;

/**
 * @brief GIF 动图描述符（BMP 帧序列版，内含播放状态）
 *
 * 【初始化】两种方式任选其一：
 *   1) ESGUI_GIFInit(&gif, frames, count, delays, delay_ms, loop_count);
 *   2) 指定初始化器：ESGUI_GIF_T gif = { .frames = frames, .frame_count = 3,
 *        .delay_ms = 200 };  （未赋值的播放状态字段自动为 0）
 *
 * 【播放状态】last_tick / acc / frame / plays / started / done 由
 * ESGUI_GIFDraw 自动维护，用户只读（如查询 done 判断是否播完），
 * 从头播放时调用 ESGUI_GIFReset 清零。
 */
typedef struct {
    /* —— 描述信息（初始化后只读） —— */
    const Bitmap *frames;        /**< 帧数组（每帧一个 Bitmap，可不同尺寸），不能为 NULL */
    eui_uint16_t frame_count;    /**< 帧数（须 ≥ 1） */
    const eui_uint16_t *delays;  /**< 每帧间隔 ms 数组（长度 = frame_count）；
                                       NULL 时所有帧统一用 delay_ms */
    eui_uint16_t delay_ms;       /**< 统一帧间隔 ms（delays 为 NULL 时生效），0 按 1ms 处理 */
    eui_uint16_t loop_count;     /**< 重复播放时的最大遍数（ESGUI_GIF_PLAY_LOOP 时生效），0 = 无限 */

    /* —— 播放状态（ESGUI_GIFDraw 自动维护；从头播放用 ESGUI_GIFReset） —— */
    eui_uint32_t last_tick;      /**< 上次帧推进的 now_ms 时刻 */
    eui_uint32_t acc;            /**< 已累计但尚未消费的时间 ms（不足一帧的零头保留在此，不丢精度） */
    eui_uint16_t frame;          /**< 当前帧号（0..frame_count-1），ESGUI_GIFDraw 每次绘制它 */
    eui_uint16_t plays;          /**< 已完成播放的遍数（每播完一轮 +1） */
    eui_uint8_t  started;        /**< 1=已开始播放（首次 ESGUI_GIFDraw 置 1） */
    eui_uint8_t  done;           /**< 1=已播完并暂停在末帧（ONCE 或 LOOP 限次播完时置 1，不再推进） */
} ESGUI_GIF_T;

/**
 * @brief  初始化动图描述符：绑定帧数据与播放参数，播放状态全部清零
 * @param  gif        描述符指针，不能为 NULL
 * @param  frames     帧数组（Bitmap 数组，须保持有效），不能为 NULL
 * @param  frame_count 帧数，须 ≥ 1
 * @param  delays     每帧间隔 ms 数组（长度 = frame_count）；NULL 时统一用 delay_ms
 * @param  delay_ms   统一帧间隔 ms（delays 为 NULL 时生效），0 按 1ms 处理
 * @param  loop_count 重复播放时的最大遍数（LOOP 模式生效），0 = 无限
 * @note   等价于用指定初始化器并把播放状态字段置 0；
 *         播放开始前的任何时刻调用都安全，播放中调用会重置播放。
 */
void ESGUI_GIFInit(ESGUI_GIF_T *gif, const Bitmap *frames, eui_uint16_t frame_count,
                   const eui_uint16_t *delays, eui_uint16_t delay_ms, eui_uint16_t loop_count);

/**
 * @brief  重置播放：从第 0 帧重新开始，清除已播完（done）状态
 * @param  gif 描述符指针，不能为 NULL
 * @note   播完暂停（ONCE / LOOP 限次）后想重新播放时调用；
 *         不影响 frames / delays 等描述信息。
 */
void ESGUI_GIFReset(ESGUI_GIF_T *gif);

/**
 * @brief  在屏幕任意位置 (x,y) 自动播放：内部按 now_ms 推进帧并绘制当前帧
 * @param  c         Canvas 指针（已绑定当前条带并裁剪），不能为 NULL
 * @param  gif       动图描述符（含播放状态，非 const），不能为 NULL
 * @param  x, y      帧左上角屏幕坐标（可为负，超出部分自动裁剪）
 * @param  mode      绘制模式：EUI_MODE_SET 白色 / EUI_MODE_CLER 黑色 /
 *                   EUI_MODE_XOR 反色
 * @param  now_ms    当前系统时间 ms（UI 主循环 tick，单调递增即可；
 *                   uint32 回绕由无符号差值自动处理）
 * @param  play_mode 播放模式：ESGUI_GIF_PLAY_LOOP 重复播放 /
 *                   ESGUI_GIF_PLAY_ONCE 播完暂停在末帧
 * @note   首次调用从第 0 帧开始并记录 last_tick；之后每次调用按
 *         now_ms 的增量推进帧（零头时间累计保留，不丢精度）。
 *         内部调用 eui_draw_bitmap / eui_draw_bitmap_invert，
 *         自动适配裁剪栈与条带（buf_area），可在页面/弹窗/覆盖层中直接使用。
 *
 *         典型用法（覆盖层常驻动画，now_ms 与传给 ESGUI_Tick 的为同一时刻值）：
 *         @code
 *         static ESGUI_GIF_T gif;                       // 全局：ESGUI_GIFInit 初始化
 *         static void ov_draw(ESGUI_Overlay_T *ov) {    // 覆盖层 on_draw 回调
 *             Canvas *c = ov->render_ctx;               // 框架注入，已绑条带并裁剪
 *             ESGUI_GIFDraw(c, &gif, 32, 48, EUI_MODE_SET,
 *                           now_ms, ESGUI_GIF_PLAY_LOOP);
 *         }
 *         @endcode
 */
void ESGUI_GIFDraw(Canvas *c, ESGUI_GIF_T *gif, int x, int y, EUI_DrawMode mode,
                   eui_uint32_t now_ms, ESGUI_GIF_PlayMode_T play_mode);

/**
 * @brief  按流逝时间(ms)无状态计算应显示的帧号（工具函数）
 * @param  gif        动图描述符
 * @param  elapsed_ms 自播放开始流逝的时间（ms）
 * @return 帧号（0..frame_count-1）；参数非法或 0 帧时返回 0
 * @note   仅按 delays / delay_ms 与 loop_count 计算，不修改任何状态，
 *         适合"手动取帧、自行控制播放节奏"的场景；
 *         ESGUI_GIFDraw 已自动取帧并推进，一般无需调用本函数。
 */
eui_uint16_t ESGUI_GIFGetFrame(const ESGUI_GIF_T *gif, eui_uint32_t elapsed_ms);

#endif /* ESGUI_ENABLE_GIF */

#endif /* ESGUI_ESGUI_GIF_H */
