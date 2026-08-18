//
// Created by E_LJF on 2026/5/28.
//

#ifndef ESGUI_ESGUI_BSP_H
#define ESGUI_ESGUI_BSP_H

#include "ESGUI_BSP_Canvas.h"
#include "ESGUI_DefaultConfig.h"

/**
 * @brief 绘制模式枚举
 *
 * 定义了所有绘制函数支持的像素混合模式：
 *   - EUI_MODE_SET:   直接覆盖（SET），color=0 写黑，color≠0 写白
 *   - EUI_MODE_XOR:   异或模式（XOR），将目标像素与掩码进行按位异或
 *                     用于反色、擦除、高亮等特效，同一图形绘制两次可恢复原状
 */
typedef enum {
    EUI_MODE_CLER = 0,   /**< 清除 */
    EUI_MODE_SET,       /**< 填充 */
    EUI_MODE_XOR   /**< XOR 模式：与显存异或，用于反色/擦除 */
} EUI_DrawMode;

/* ==================== 基础绘制 ==================== */

void eui_draw_pixel(Canvas *c, int x, int y, EUI_DrawMode mode);

void eui_draw_hline(Canvas *c, int x1, int x2, int y,EUI_DrawMode mode);

void eui_draw_vline(Canvas *c, int x, int y1, int y2, EUI_DrawMode mode);

void eui_draw_line(Canvas *c, int x0, int y0, int x1, int y1, EUI_DrawMode mode);

/* ==================== 矩形 ==================== */

void eui_draw_rect_fill(Canvas *c, int x1, int y1, int x2, int y2, EUI_DrawMode mode);

void eui_draw_rect_stroke(Canvas *c, int x1, int y1, int x2, int y2, EUI_DrawMode mode);

void eui_draw_rect_box(Canvas *c, int x1, int y1, int x2, int y2, EUI_DrawMode mode);

/* ==================== 圆 ==================== */

void eui_draw_circle_stroke(Canvas *c, int cx, int cy, int r, EUI_DrawMode mode);

void eui_draw_circle_fill(Canvas *c, int cx, int cy, int r, EUI_DrawMode mode);

void eui_draw_circle_box(Canvas *c, int cx, int cy, int r, EUI_DrawMode mode);

/* ==================== 三角形 ==================== */
#if ESGUI_ENABLE_DRAW_TRIANGLE

void eui_draw_triangle_stroke(Canvas *c, int x0, int y0, int x1, int y1, int x2, int y2, EUI_DrawMode mode);

void eui_draw_triangle_fill(Canvas *c, int x0, int y0, int x1, int y1, int x2, int y2, EUI_DrawMode mode);

void eui_draw_triangle_box(Canvas *c, int x0, int y0, int x1, int y1, int x2, int y2, EUI_DrawMode mode);

#endif /* ESGUI_ENABLE_DRAW_TRIANGLE */

/* ==================== 圆角矩形 ==================== */

void eui_draw_round_rect_stroke(Canvas *c, int x1, int y1, int x2, int y2, int r, EUI_DrawMode mode);

void eui_draw_round_rect_fill(Canvas *c, int x1, int y1, int x2, int y2, int r, EUI_DrawMode mode);

void eui_draw_round_rect_box(Canvas *c, int x1, int y1, int x2, int y2, int r, EUI_DrawMode mode);



/* ==================== 显存操作 ==================== */
void canvas_apply_transition_mask(Canvas *c, eui_uint8_t level);
void canvas_apply_zoom_mask(Canvas *c, eui_uint8_t level);



#endif //ESGUI_ESGUI_BSP_H
