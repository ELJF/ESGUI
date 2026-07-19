//
// Created by E_LJF on 2026/6/4.
//

#ifndef ESGUI_ESGUI_BSP_CANVAS_H
#define ESGUI_ESGUI_BSP_CANVAS_H

#include "stdint.h"
#include "stdbool.h"

/**
 * CANVAS_CLIP: 统一裁剪宏
 *
 * 用当前栈顶（已包含屏幕边界）裁剪输入坐标。
 * 如果裁剪后无效，直接 return。
 */
#define CANVAS_CLIP(c, _x1, _y1, _x2, _y2) \
do { \
const Area *_clip = canvas_clip_top(c); \
if ((_x1) > (_x2)) { int _t = (_x1); (_x1) = (_x2); (_x2) = _t; } \
if ((_y1) > (_y2)) { int _t = (_y1); (_y1) = (_y2); (_y2) = _t; } \
if ((_x1) < _clip->x1) (_x1) = _clip->x1; \
if ((_y1) < _clip->y1) (_y1) = _clip->y1; \
if ((_x2) > _clip->x2) (_x2) = _clip->x2; \
if ((_y2) > _clip->y2) (_y2) = _clip->y2; \
if ((_x1) > (_x2) || (_y1) > (_y2)) return; \
} while(0)

#define canvas_clip_top(c) &(c)->clip_stack[(c)->clip_sp]

/**
 * Area: 屏幕上的矩形区域，坐标包含边界（inclusive）
 */
typedef struct {
    int x1, y1;   // 左上角
    int x2, y2;   // 右下角（包含）
} Area;

/**
 * Canvas: 画布 —— 页式垂直内存布局
 *
 * 【SSD1315 原生映射】
 *   显存按 Page 组织，每页 8 行高（COM0~COM7）。
 *   水平寻址模式下，连续写入的字节依次填充：
 *     Page0 的列 0 → 1 → 2 → ... → 127
 *     然后自动跳到 Page1 的列 0 → 1 → ...
 *
 *   因此 Canvas 的 buf 与 SSD1315 GDDRAM 保持 1:1 映射：
 *     buf[page * stride + x] 的第 n 位 = 屏幕像素 (x, page*8+n)
 *
 *   【分块刷新】
 *   由于硬件按页寻址，strip（条带）高度必须是 8 的倍数，且与页边界对齐。
 *   canvas_bind_strip() 会自动把传入的区域扩展到页边界。
 *
 *   【两种工作模式】
 *   1. 完整帧缓冲：buf 指向 1KB 全屏内存（128×64）
 *   2. 分块条带模式：buf 指向小块显存，高度为 8/16/32/64
 */
typedef struct {
    uint8_t *buf;         // 当前绑定的内存（页式排列）
    int width, height;    // 屏幕总尺寸
    int stride;           // 每页字节数 = width（每页包含 width 列）
    int pages;            // 总页数 = height / 8

    // 【条带映射】buf 当前对应屏幕上的哪个区域（已自动页对齐）
    Area buf_area;

    // 【裁剪栈】clip_stack[0] = 屏幕边界（不可弹出）
    //           clip_stack[1..3] = 用户裁剪区
    Area clip_stack[4];
    int clip_sp;
} Canvas;


/**
 * @brief 分块刷新迭代器状态
 *
 * 用于将 canvas_refresh_fullscreen 的"条带循环"拆分为外部可控的步骤，
 * 使绘制逻辑无需以回调形式传入，可在主循环或任意函数中完成。
 */
typedef struct {
    Canvas *canvas;       /**< 关联的画布 */
    int strip_h;          /**< 条带高度（像素，已页对齐） */
    int y;                /**< 下一次迭代起始 Y（内部状态） */
    int y1, y2;           /**< 当前条带的精确像素范围（含边界） */
    Area strip_area;      /**< 当前条带的页对齐区域（用于 bind_strip） */
    int pages;            /**< 当前条带占用的页数 */
} CanvasStripIter;


/* ==================== 画布管理 ==================== */

void canvas_init(Canvas *c, uint8_t *buf, int w, int h);
void canvas_bind_strip(Canvas *c, const Area *screen_area);
bool canvas_clip_push(Canvas *c, const Area *a);
void canvas_clip_pop(Canvas *c);

/**
 * canvas_refresh_fullscreen: 分块刷新全屏
 *
 * @param strip_h  条带高度（像素）。必须是 8 的倍数，否则内部自动向上取整到 8。
 *                 建议取值：8（最省 RAM）、16、32、64（整屏，无分块）。
 * @param draw_fn  用户绘制回调
 * @param flush_fn 送屏回调。buf 与 SSD1315 GDDRAM 1:1 映射，可直接发送。
 *
 * 【注意】flush_fn 收到的 (x1,y1,x2,y2) 是页对齐后的区域，可能比 strip_h 略大。
 */
void canvas_refresh_fullscreen(Canvas *c, int strip_h,
                                void (*draw_fn)(Canvas*, void*), void *user,
                                void (*flush_fn)(int,int,int,int,const uint8_t*,void*), void *flush_user);

/* ==================== 辅助 ==================== */
void canvas_clear(Canvas *c, uint8_t color);



/**
 * @brief  初始化分块刷新迭代器
 * @param  it       迭代器指针，不能为 NULL
 * @param  c        Canvas 指针，不能为 NULL
 * @param  strip_h  条带高度（像素），内部强制向上对齐到 8 的倍数，最小为 8
 */
void canvas_strip_iter_init(CanvasStripIter *it, Canvas *c, int strip_h);

/**
 * @brief  推进到下一个条带
 * @param  it  迭代器指针
 * @retval true  成功进入新条带，it->y1/y2/strip_area 已更新
 * @retval false 所有条带已处理完毕
 * @note   首次调用进入第一条带（y=0）
 */
bool canvas_strip_iter_next(CanvasStripIter *it);

/**
 * @brief  绑定当前条带到 Canvas 并清零显存
 * @param  it  迭代器指针
 * @note   调用后 c->buf 即指向当前条带，可直接绘制
 */
void canvas_strip_iter_bind(CanvasStripIter *it);

/**
 * @brief  将当前条带内容送屏
 * @param  it         迭代器指针
 * @param  flush_fn   送屏回调，不能为 NULL
 * @param  flush_user 送屏回调的用户数据
 */
void canvas_strip_iter_flush(CanvasStripIter *it,
    void (*flush_fn)(int,int,int,int,const uint8_t*,void*), void *flush_user);


/**
 * @brief  将迭代器重置到初始位置
 * @param  it         迭代器指针
 */
void canvas_strip_iter_clean(CanvasStripIter *it);


#endif //ESGUI_ESGUI_BSP_CANVAS_H
