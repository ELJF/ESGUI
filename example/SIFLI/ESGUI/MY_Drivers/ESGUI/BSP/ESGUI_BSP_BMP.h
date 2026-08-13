//
// Created by E_LJF on 2026/6/4.
//

#ifndef ESGUI_ESGUI_BSP_BMP_H
#define ESGUI_ESGUI_BSP_BMP_H

#include "ESGUI_BSP_Canvas.h"
#include "ESGUI_Def.h"

/**
 * Bitmap: 1bpp 位图描述符（页式格式）
 *
 * 【数据格式】与 SSD1315 GDDRAM 完全一致：
 *   每页 stride = w（每页占 w 字节，每字节对应一列的 8 个垂直像素）
 *   页优先排列：Page0 所有列 → Page1 所有列 → ...
 *   字节内 bit n 对应页内第 n 行（bit0 = 页内第 0 行）
 *
 * 【生成工具】原有 PCtoLCD/Image2LCD 生成的是水平格式（行优先），
 *   需要先用转换脚本转为页式格式，才能使用本库的快速绘制函数。
 */
typedef struct {
    int w, h;               // 位图宽高（像素）
    const eui_uint8_t *data;    // 页式位图数据（只读，存放于 Flash/ROM）
} Bitmap;

/* ==================== 位图（页式格式） ==================== */

void eui_draw_bitmap(Canvas *c, int x, int y, const Bitmap *bmp, eui_uint8_t color);
void eui_draw_bitmap_transparent(Canvas *c, int x, int y, const Bitmap *bmp,
                             eui_uint8_t color, eui_uint8_t transparent_color);
void eui_draw_bitmap_invert(Canvas *c, int x, int y, const Bitmap *bmp);


#endif //ESGUI_ESGUI_BSP_BMP_H
