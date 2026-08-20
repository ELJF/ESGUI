//
// Created by E_LJF on 2026/8/17.
//
// ============================================================
// GIF 动图组件实现（BMP 帧序列版）
// ============================================================
//   - 播放核心：ESGUI_GIFDraw 按 now_ms 增量累计时间并推进帧，
//     帧数据仅作位图引用，零解析、零动态内存、零浮点；
//   - 绘制复用 eui_draw_bitmap / eui_draw_bitmap_invert（框架自带），
//     自动适配裁剪栈与条带（buf_area），不绑定任何芯片或平台。
// ============================================================
//

#include "ESGUI_GIF.h"

/**
 * @brief  取第 i 帧的显示时长（ms）
 * @param  gif 动图描述符
 * @param  i   帧号（调用方保证 < frame_count）
 * @return 该帧间隔 ms；0 按 1ms 处理（避免推进循环卡死）
 */
static eui_uint32_t gif_delay(const ESGUI_GIF_T *gif, eui_uint16_t i) {
    eui_uint32_t d = gif->delays ? gif->delays[i] : gif->delay_ms;
    return d ? d : 1;
}

/* ==================== 初始化 / 重置 ==================== */

void ESGUI_GIFInit(ESGUI_GIF_T *gif, const Bitmap *frames, eui_uint16_t frame_count,
                   const eui_uint16_t *delays, eui_uint16_t delay_ms, eui_uint16_t loop_count) {
    if (gif == ESGUI_NULL) return;

    /* 描述信息：帧数据与播放参数 */
    gif->frames      = frames;
    gif->frame_count = frame_count;
    gif->delays      = delays;
    gif->delay_ms    = delay_ms;
    gif->loop_count  = loop_count;

    /* 播放状态：全部清零（等价于 ESGUI_GIFReset） */
    gif->last_tick   = 0;
    gif->acc         = 0;
    gif->frame       = 0;
    gif->plays       = 0;
    gif->started     = 0;
    gif->done        = 0;
}

void ESGUI_GIFReset(ESGUI_GIF_T *gif) {
    if (gif == ESGUI_NULL) return;

    /* 播放状态清零：下次 ESGUI_GIFDraw 视为首次调用，从第 0 帧开始 */
    gif->last_tick = 0;
    gif->acc       = 0;
    gif->frame     = 0;
    gif->plays     = 0;
    gif->started   = 0;
    gif->done      = 0;
}

/* ==================== 绘制指定帧（复用 eui_draw_bitmap） ==================== */

/**
 * @brief  绘制第 frame 帧到 Canvas 的 (x, y) 处
 * @note   直接转发给框架自带位图绘制函数：
 *         - EUI_MODE_SET / CLER → eui_draw_bitmap（含 y 与高度 8 对齐时的
 *           快速整页路径，以及任意 y 的通用路径）；
 *         - EUI_MODE_XOR → eui_draw_bitmap_invert（两次绘制可恢复原状）。
 *         三者内部均自带裁剪栈 + 条带（buf_area）双重裁剪，跨条带安全。
 */
static void gif_draw_frame(Canvas *c, const ESGUI_GIF_T *gif, eui_uint16_t frame,
                           int x, int y, EUI_DrawMode mode) {
    const Bitmap *bmp = &gif->frames[frame];
    if (bmp->w <= 0 || bmp->h <= 0 || bmp->data == ESGUI_NULL) return;

    switch (mode) {
        case EUI_MODE_XOR:
            eui_draw_bitmap_invert(c, x, y, bmp);
            break;
        case EUI_MODE_CLER:
            eui_draw_bitmap(c, x, y, bmp, 0);
            break;
        default: /* EUI_MODE_SET */
            eui_draw_bitmap(c, x, y, bmp, 1);
            break;
    }
}

/* ==================== 自动播放绘制 ==================== */

void ESGUI_GIFDraw(Canvas *c, ESGUI_GIF_T *gif, int x, int y, EUI_DrawMode mode,
                   eui_uint32_t now_ms, ESGUI_GIF_PlayMode_T play_mode) {
    /* 参数保护：任一关键指针为空或帧数为 0 时直接返回，不做任何操作 */
    if (c == ESGUI_NULL || gif == ESGUI_NULL || gif->frames == ESGUI_NULL || gif->frame_count == 0) return;

    if (!gif->started) {
        /* —— 首次调用：从第 0 帧开始，记录基准时刻 ——
         * started 作为"已初始化"标志；此后仅依赖 now_ms 的差值推进，
         * 与绝对时刻无关，因此 now_ms 的起点可以是任意值。 */
        gif->started   = 1;
        gif->frame     = 0;
        gif->plays     = 0;
        gif->done      = 0;
        gif->acc       = 0;
        gif->last_tick = now_ms;
    } else if (!gif->done) {
        /* —— 已开始且未播完：累计流逝时间并推进帧 ——
         * (now_ms - last_tick) 为无符号差值：即使 now_ms 发生 uint32 回绕，
         * 只要两次调用间隔 < 2^31 ms，差值依然正确。
         * 未满一帧的零头时间累加进 acc 保留，下次继续累计，不丢精度。 */
        gif->acc += now_ms - gif->last_tick;
        gif->last_tick = now_ms;

        /* 每满一个"当前帧间隔"就前进一帧；调用间隔过大时可一次跨多帧 */
        while (1) {
            eui_uint32_t d = gif_delay(gif, gif->frame);
            if (gif->acc < d) break;          /* 剩余时间不足一帧：等下次调用 */
            gif->acc -= d;
            gif->frame++;

            if (gif->frame >= gif->frame_count) {
                /* 一轮播放完毕：计数并决定是否结束 */
                gif->plays++;
                /* 结束条件：ONCE 播一遍即停；LOOP 且 loop_count 限次播完也停 */
                if (play_mode == ESGUI_GIF_PLAY_ONCE ||
                    (gif->loop_count > 0 && gif->plays >= gif->loop_count)) {
                    gif->frame = (eui_uint16_t)(gif->frame_count - 1); /* 停在末帧 */
                    gif->done  = 1;                                    /* 标记播完 */
                    break;
                }
                gif->frame = 0;   /* 继续下一轮 */
            }
        }
    }
    /* done=1 时不再推进，持续绘制末帧（播完暂停的视觉效果） */

    /* 绘制当前帧（首次调用即绘制第 0 帧） */
    gif_draw_frame(c, gif, gif->frame, x, y, mode);
}

/* ==================== 无状态取帧（工具） ==================== */

eui_uint16_t ESGUI_GIFGetFrame(const ESGUI_GIF_T *gif, eui_uint32_t elapsed_ms) {
    if (gif == ESGUI_NULL || gif->frame_count == 0) return 0;

    /* 先求单轮总时长 total = 各帧间隔之和（0 间隔按 1ms） */
    eui_uint32_t total = 0;
    eui_uint16_t i;
    for (i = 0; i < gif->frame_count; i++) {
        eui_uint32_t d = gif->delays ? gif->delays[i] : gif->delay_ms;
        if (d == 0) d = 1;
        total += d;
    }
    if (total == 0) return 0;

    /* 有限循环（loop_count > 0）且已播完：无论何时都停在最后一帧。
     * elapsed/total 即已完整播放的遍数。 */
    if (gif->loop_count > 0 && (elapsed_ms / total) >= gif->loop_count)
        return (eui_uint16_t)(gif->frame_count - 1);

    /* 无限循环：把 elapsed 折算到单轮内的时间 t，再逐帧定位 */
    eui_uint32_t t = elapsed_ms % total;
    for (i = 0; i < gif->frame_count; i++) {
        eui_uint32_t d = gif->delays ? gif->delays[i] : gif->delay_ms;
        if (d == 0) d = 1;
        if (t < d) return i;      /* t 落在第 i 帧的时间窗口内 */
        t -= d;
    }
    return (eui_uint16_t)(gif->frame_count - 1);   /* 兜底：落在最后一帧 */
}
