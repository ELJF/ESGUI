//
// Created by E_LJF on 2026/6/4.
//

#include "ESGUI_BSP_BMP.h"

/* ==================== 位图绘制（页式格式） ==================== */

/**
 * @brief  绘制页式 1bpp 位图
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x      位图左上角 X 坐标
 * @param  y      位图左上角 Y 坐标
 * @param  bmp    位图指针，不能为 ESGUI_NULL；data 成员也不能为 ESGUI_NULL
 * @param  color  绘制颜色：0 为黑色（擦除），非 0 为白色（绘制）
 * @retval 无
 * @note   快速路径：当 y 坐标和位图高度均为 8 的倍数时，按页逐字节 OR/AND，
 *         速度极快（适合字体、图标）。
 *         通用路径：支持任意 y 坐标，自动处理页内 bit 偏移和跨页拼接。
 */
void eui_draw_bitmap(Canvas *c, int x, int y, const Bitmap *bmp, eui_uint8_t color) {
    if (c == ESGUI_NULL || bmp == ESGUI_NULL || bmp->data == ESGUI_NULL || bmp->w <= 0 || bmp->h <= 0) return;

    int x1 = x, y1 = y;
    int x2 = x + bmp->w - 1;
    int y2 = y + bmp->h - 1;

    const Area *clip = canvas_clip_top(c);
    if (x1 < clip->x1) x1 = clip->x1;
    if (y1 < clip->y1) y1 = clip->y1;
    if (x2 > clip->x2) x2 = clip->x2;
    if (y2 > clip->y2) y2 = clip->y2;

    if (y1 < c->buf_area.y1) y1 = c->buf_area.y1;
    if (y2 > c->buf_area.y2) y2 = c->buf_area.y2;

    if (x1 > x2 || y1 > y2) return;

    int src_x1 = x1 - x;
    int copy_w = x2 - x1 + 1;

    // ========== 快速路径：y 和高度都是 8 对齐 ==========
    if ((y & 7) == 0 && (bmp->h & 7) == 0 &&
        y1 == y && y2 == (y + bmp->h - 1))
    {
        int src_pages = bmp->h >> 3;
        int dst_page0 = (y1 - c->buf_area.y1) >> 3;

        for (int p = 0; p < src_pages; p++) {
            eui_uint8_t *dst = c->buf + (dst_page0 + p) * c->stride + x1;
            const eui_uint8_t *src = bmp->data + p * bmp->w + src_x1;

            if (color) {
                for (int i = 0; i < copy_w; i++) dst[i] |= src[i];
            } else {
                for (int i = 0; i < copy_w; i++) dst[i] &= ~src[i];
            }
        }
        return;
    }

    // ========== 通用路径：逐目标页收集像素 ==========
    int dst_y = y1;
    while (dst_y <= y2) {
        int dst_page = (dst_y - c->buf_area.y1) >> 3;
        int dst_bit  = dst_y & 7;
        int rows_here = 8 - dst_bit;
        if (rows_here > (y2 - dst_y + 1)) rows_here = y2 - dst_y + 1;

        eui_uint8_t *dst_row = c->buf + dst_page * c->stride + x1;

        for (int i = 0; i < copy_w; i++) {
            int src_x = src_x1 + i;
            eui_uint8_t src_byte = 0;

            for (int row = 0; row < rows_here; row++) {
                int src_y = (dst_y - y) + row;
                int src_page = src_y >> 3;
                int src_bit  = src_y & 7;
                if (bmp->data[src_page * bmp->w + src_x] & (1u << src_bit))
                    src_byte |= (1u << (dst_bit + row));
            }

            if (color) dst_row[i] |= src_byte;
            else       dst_row[i] &= ~src_byte;
        }
        dst_y += rows_here;
    }
}

/**
 * @brief  带透明色的页式 1bpp 位图绘制
 * @param  c                  Canvas 指针，不能为 ESGUI_NULL
 * @param  x                  位图左上角 X 坐标
 * @param  y                  位图左上角 Y 坐标
 * @param  bmp                位图指针，不能为 ESGUI_NULL；data 成员也不能为 ESGUI_NULL
 * @param  color              绘制颜色：0 为黑色，非 0 为白色
 * @param  transparent_color  透明色（0 或 1）。位图中等于该值的像素不绘制。
 *                            传大于 1 的值（如 0xFF）表示不使用透明色，直接走不透明绘制。
 * @retval 无
 * @note   透明判断按整字节进行：目标页内收集到的 src_byte 全 0 视为透明色 0，
 *         全 0xFF 视为透明色 1。部分填充的边界字节可能无法精确按位透明。
 */
void eui_draw_bitmap_transparent(Canvas *c, int x, int y, const Bitmap *bmp,
                             eui_uint8_t color, eui_uint8_t transparent_color)
{
    if (c == ESGUI_NULL || bmp == ESGUI_NULL) return;

    if (transparent_color > 1) {
        eui_draw_bitmap(c, x, y, bmp, color);
        return;
    }

    if (bmp->data == ESGUI_NULL || bmp->w <= 0 || bmp->h <= 0) return;

    int x1 = x, y1 = y;
    int x2 = x + bmp->w - 1;
    int y2 = y + bmp->h - 1;

    const Area *clip = canvas_clip_top(c);
    if (x1 < clip->x1) x1 = clip->x1;
    if (y1 < clip->y1) y1 = clip->y1;
    if (x2 > clip->x2) x2 = clip->x2;
    if (y2 > clip->y2) y2 = clip->y2;

    if (y1 < c->buf_area.y1) y1 = c->buf_area.y1;
    if (y2 > c->buf_area.y2) y2 = c->buf_area.y2;

    if (x1 > x2 || y1 > y2) return;

    int src_x1 = x1 - x;
    int copy_w = x2 - x1 + 1;

    int dst_y = y1;
    while (dst_y <= y2) {
        int dst_page = (dst_y - c->buf_area.y1) >> 3;
        int dst_bit  = dst_y & 7;
        int rows_here = 8 - dst_bit;
        if (rows_here > (y2 - dst_y + 1)) rows_here = y2 - dst_y + 1;

        eui_uint8_t *dst_row = c->buf + dst_page * c->stride + x1;

        for (int i = 0; i < copy_w; i++) {
            int src_x = src_x1 + i;
            eui_uint8_t src_byte = 0;

            for (int row = 0; row < rows_here; row++) {
                int src_y = (dst_y - y) + row;
                int src_page = src_y >> 3;
                int src_bit  = src_y & 7;
                if (bmp->data[src_page * bmp->w + src_x] & (1u << src_bit))
                    src_byte |= (1u << (dst_bit + row));
            }

            // 透明色判断：如果 src_byte 全等于透明色，则跳过
            // 注意：透明色是按位判断，0=全黑透，1=全白透
            if (transparent_color == 0 && src_byte == 0) continue;
            if (transparent_color == 1 && src_byte == 0xFF) continue;

            if (color) dst_row[i] |= src_byte;
            else       dst_row[i] &= ~src_byte;
        }
        dst_y += rows_here;
    }
}

/**
 * @brief  反色（XOR）绘制页式 1bpp 位图
 * @param  c   Canvas 指针，不能为 ESGUI_NULL
 * @param  x   位图左上角 X 坐标
 * @param  y   位图左上角 Y 坐标
 * @param  bmp 位图指针，不能为 ESGUI_NULL；data 成员也不能为 ESGUI_NULL
 * @retval 无
 * @note   将位图覆盖区域与显存做 XOR 运算，常用于实现光标反色、选中高亮等效果。
 */
void eui_draw_bitmap_invert(Canvas *c, int x, int y, const Bitmap *bmp) {
    if (c == ESGUI_NULL || bmp == ESGUI_NULL || bmp->data == ESGUI_NULL || bmp->w <= 0 || bmp->h <= 0) return;

    int x1 = x, y1 = y;
    int x2 = x + bmp->w - 1;
    int y2 = y + bmp->h - 1;

    const Area *clip = canvas_clip_top(c);
    if (x1 < clip->x1) x1 = clip->x1;
    if (y1 < clip->y1) y1 = clip->y1;
    if (x2 > clip->x2) x2 = clip->x2;
    if (y2 > clip->y2) y2 = clip->y2;

    if (y1 < c->buf_area.y1) y1 = c->buf_area.y1;
    if (y2 > c->buf_area.y2) y2 = c->buf_area.y2;

    if (x1 > x2 || y1 > y2) return;

    int src_x1 = x1 - x;
    int copy_w = x2 - x1 + 1;

    int dst_y = y1;
    while (dst_y <= y2) {
        int dst_page = (dst_y - c->buf_area.y1) >> 3;
        int dst_bit  = dst_y & 7;
        int rows_here = 8 - dst_bit;
        if (rows_here > (y2 - dst_y + 1)) rows_here = y2 - dst_y + 1;

        eui_uint8_t *dst_row = c->buf + dst_page * c->stride + x1;

        for (int i = 0; i < copy_w; i++) {
            int src_x = src_x1 + i;
            eui_uint8_t src_byte = 0;

            for (int row = 0; row < rows_here; row++) {
                int src_y = (dst_y - y) + row;
                int src_page = src_y >> 3;
                int src_bit  = src_y & 7;
                if (bmp->data[src_page * bmp->w + src_x] & (1u << src_bit))
                    src_byte |= (1u << (dst_bit + row));
            }

            dst_row[i] ^= src_byte;
        }
        dst_y += rows_here;
    }
}
