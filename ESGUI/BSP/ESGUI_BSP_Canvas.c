//
// Created by E_LJF on 2026/6/4.
//

#include "ESGUI_BSP_Canvas.h"
#include "string.h"

/* ==================== 裁剪栈 ==================== */

/**
 * @brief  初始化 Canvas 实例
 * @param  c   Canvas 指针，不能为 NULL
 * @param  buf 显存缓冲区指针，不能为 NULL
 * @param  w   画布宽度（像素），必须大于 0
 * @param  h   画布高度（像素），必须大于 0 且建议为 8 的倍数
 * @note   初始化后裁剪栈默认压入全屏区域，clip_sp = 0
 */
void canvas_init(Canvas *c, uint8_t *buf, int w, int h) {
    if (c == NULL || buf == NULL) return;
    if (w <= 0 || h <= 0) return;

    c->buf = buf;
    c->width = w;
    c->height = h;
    c->stride = w;              // 每页占 w 字节（每字节对应一列）
    c->pages = h >> 3;          // 总页数
    c->buf_area = (Area){0, 0, w - 1, h - 1};
    c->clip_stack[0] = (Area){0, 0, w - 1, h - 1};
    c->clip_sp = 0;
}

/**
 * @brief  绑定条带显存（强制页对齐）
 *
 * SSD1315 的 GDDRAM 按页（8 行）寻址，因此 buf_area 必须对齐到 8 像素边界。
 * 本函数会自动扩展传入的 screen_area 到页边界。
 *
 * @param  c           Canvas 指针，不能为 NULL
 * @param  screen_area 屏幕区域指针，不能为 NULL
 * @note   若 screen_area 超出画布边界，y2 会被钳位到画布最大高度
 */
void canvas_bind_strip(Canvas *c, const Area *screen_area) {
    if (c == NULL || screen_area == NULL) return;

    c->buf_area.x1 = screen_area->x1;
    c->buf_area.x2 = screen_area->x2;

    // 向下对齐到页起始（y1 取 8 的倍数）
    c->buf_area.y1 = screen_area->y1 & ~7;
    // 向上对齐到页结束（y2 取 8 的倍数减 1）
    c->buf_area.y2 = (screen_area->y2 | 7);
    if (c->buf_area.y2 >= c->height) c->buf_area.y2 = c->height - 1;
}

/**
 * @brief  压入新的裁剪区域（与当前栈顶求交集）
 * @param  c  Canvas 指针，不能为 NULL
 * @param  a  待裁剪区域指针，不能为 NULL
 * @retval true  裁剪区域压入成功
 * @retval false 裁剪栈已满（深度 >= 3）或参数非法
 * @note   若交集为空，内部标记为空区域（x1 > x2），但栈深度仍会增加
 */
bool canvas_clip_push(Canvas *c, const Area *a) {
    if (c == NULL || a == NULL) return false;
    if (c->clip_sp >= 3) return false;

    Area *top = &c->clip_stack[c->clip_sp];
    Area *next = &c->clip_stack[c->clip_sp + 1];

    next->x1 = (a->x1 > top->x1) ? a->x1 : top->x1;
    next->y1 = (a->y1 > top->y1) ? a->y1 : top->y1;
    next->x2 = (a->x2 < top->x2) ? a->x2 : top->x2;
    next->y2 = (a->y2 < top->y2) ? a->y2 : top->y2;

    if (next->x1 > next->x2 || next->y1 > next->y2) {
        next->x1 = 1; next->x2 = 0;  // 空区域标记
    }
    c->clip_sp++;
    return true;
}

/**
 * @brief  弹出栈顶裁剪区域
 * @param  c  Canvas 指针，不能为 NULL
 * @note   栈底（全屏区域）始终保留，clip_sp 不会低于 0
 */
void canvas_clip_pop(Canvas *c) {
    if (c == NULL) return;
    if (c->clip_sp > 0) c->clip_sp--;
}

/* ==================== 分块刷新引擎 ==================== */

/**
 * @brief  全屏分块刷新引擎
 *
 * 将屏幕按条带（strip）分块渲染，每块先清屏、再调用用户绘制回调、最后刷到硬件。
 * 适用于显存不足以容纳全屏的嵌入式场景（如 SSD1315）。
 *
 * @param  c          Canvas 指针，不能为 NULL
 * @param  strip_h    条带高度（像素），内部强制向上对齐到 8 的倍数，最小为 8
 * @param  draw_fn    用户绘制回调，不能为 NULL；接收 Canvas 指针和 user 参数
 * @param  user       绘制回调的用户数据
 * @param  flush_fn   送屏回调，不能为 NULL；参数为 (x1, y1, x2, y2, buf, flush_user)
 * @param  flush_user 送屏回调的用户数据
 * @note   每次进入条带前会自动压入精确到像素的裁剪区，绘制后弹出，
 *         防止 draw_fn 画出当前条带范围。
 */
void canvas_refresh_fullscreen(Canvas *c, int strip_h,
                                void (*draw_fn)(Canvas*, void*), void *user,
                                void (*flush_fn)(int,int,int,int,const uint8_t*,void*), void *flush_user)
{
    if (c == NULL || draw_fn == NULL || flush_fn == NULL) return;

    // 强制页对齐：strip_h 必须是 8 的倍数
    if (strip_h & 7) strip_h = (strip_h + 7) & ~7;
    if (strip_h < 8) strip_h = 8;

    for (int y = 0; y < c->height; y += strip_h) {
        int y1 = y;
        int y2 = (y + strip_h - 1 < c->height) ? y + strip_h - 1 : c->height - 1;

        // buf 区域：页对齐扩展（SSD1315 硬件按页寻址，必须发送完整页）
        Area strip_area = {
            0, y1 & ~7,
            c->width - 1, (y2 | 7)
        };
        if (strip_area.y2 >= c->height) strip_area.y2 = c->height - 1;

        int pages = (strip_area.y2 - strip_area.y1 + 1) >> 3;

        // 绑定当前条带（buf 与 SSD1315 GDDRAM 1:1 映射）
        canvas_bind_strip(c, &strip_area);
        memset(c->buf, 0, c->stride * pages);

        // 绘制裁剪区：精确到像素，防止画出当前条带之外的行
        Area draw_clip = {0, y1, c->width - 1, y2};
        canvas_clip_push(c, &draw_clip);

        draw_fn(c, user);

        canvas_clip_pop(c);

        // 送屏：buf 可直接发送，无需任何转置
        flush_fn(strip_area.x1, strip_area.y1, strip_area.x2, strip_area.y2, c->buf, flush_user);
    }
}

/* ==================== 辅助函数 ==================== */

/**
 * @brief  清空当前绑定的显存缓冲区
 * @param  c     Canvas 指针，不能为 NULL
 * @param  color 填充颜色：0 为黑色（清零），非 0 为白色（全 0xFF）
 * @note   仅清空当前 buf_area 对应的页范围，而非整个 Canvas 全屏
 */
void canvas_clear(Canvas *c, uint8_t color) {
    if (c == NULL) return;

    int pages = (c->buf_area.y2 - c->buf_area.y1 + 1) >> 3;
    memset(c->buf, color ? 0xFF : 0x00, c->stride * pages);
}



/* ==================== 分块刷新迭代器 ==================== */

void canvas_strip_iter_init(CanvasStripIter *it, Canvas *c, int strip_h) {
    if (it == NULL || c == NULL) return;

    /* 强制页对齐：与 canvas_refresh_fullscreen 保持一致 */
    if (strip_h & 7) strip_h = (strip_h + 7) & ~7;
    if (strip_h < 8) strip_h = 8;

    it->canvas  = c;
    it->strip_h = strip_h;
    it->y       = 0;
    it->y1 = it->y2 = 0;
    it->strip_area = (Area){0, 0, 0, 0};
    it->pages   = 0;
}

bool canvas_strip_iter_next(CanvasStripIter *it) {
    if (it == NULL || it->canvas == NULL) return false;

    Canvas *c = it->canvas;
    if (it->y >= c->height) return false;

    /* 精确像素范围 */
    it->y1 = it->y;
    it->y2 = (it->y + it->strip_h - 1 < c->height) ? (it->y + it->strip_h - 1) : (c->height - 1);

    /* 页对齐扩展（SSD1315 硬件按页寻址，必须发送完整页） */
    it->strip_area.x1 = 0;
    it->strip_area.x2 = c->width - 1;
    it->strip_area.y1 = it->y1 & ~7;
    it->strip_area.y2 = (it->y2 | 7);
    if (it->strip_area.y2 >= c->height) it->strip_area.y2 = c->height - 1;

    it->pages = (it->strip_area.y2 - it->strip_area.y1 + 1) >> 3;

    /* 推进内部状态，供下次调用 */
    it->y += it->strip_h;
    return true;
}

void canvas_strip_iter_bind(CanvasStripIter *it) {
    if (it == NULL || it->canvas == NULL) return;

    Canvas *c = it->canvas;
    canvas_bind_strip(c, &it->strip_area);
    memset(c->buf, 0, c->stride * it->pages);
}

void canvas_strip_iter_flush(CanvasStripIter *it,
    void (*flush_fn)(int,int,int,int,const uint8_t*,void*), void *flush_user)
{
    if (it == NULL || flush_fn == NULL) return;

    Area *a = &it->strip_area;
    flush_fn(a->x1, a->y1, a->x2, a->y2, it->canvas->buf, flush_user);
}


void canvas_strip_iter_clean(CanvasStripIter *it) {
    if (it == NULL || it->canvas == NULL) return;

    it->y       = 0;
    it->y1 = it->y2 = 0;
    it->strip_area = (Area){0, 0, 0, 0};
    it->pages   = 0;
}