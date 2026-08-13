#include "ESGUI_BSP_draw.h"
#include "limits.h"
#include "string.h"

#define abs(x) ((x) < 0 ? -(x) : (x))

// static inline const Area* canvas_clip_top(const Canvas *c) {
//     return &c->clip_stack[c->clip_sp];
// }

/* ==================== 1bpp 页式位操作核心 ==================== */

/**
 * _bit_mask: 计算像素 y 在页内字节中的位掩码
 *
 * 页式格式下，字节内 bit n 对应页内第 n 行。
 * 例：y=0 → bit0 → 0x01, y=7 → bit7 → 0x80
 *
 * 【SSD1315 方向说明】
 *   软件层只需按此顺序写入，屏幕上的上下方向由 SSD1315 初始化命令
 *   0xC0/0xC8（COM 扫描方向）和 0xA0/0xA1（SEG 重映射）控制。
 *   通常配置 0xA1+0xC8 使 (0,0) 在左上角，此时 bit0 对应最上方像素。
 */
static inline eui_uint8_t _bit_mask(int y) {
    return (eui_uint8_t)(1u << ((y) & 7));
}

/**
 * _buf_ptr: 屏幕坐标 → 内存地址（页式映射）
 *
 * 地址计算：
 *   page_offset = (y - buf_area.y1) / 8
 *   addr = buf + page_offset * stride + x
 *
 * 例：屏幕 128×64，条带对应 y=8~15（Page1）
 *   画像素 (5, 9)：
 *     page_offset = (9-8)/8 = 0（在 buf 的第 0 页，即全局 Page1）
 *     地址 = buf + 0*128 + 5 = buf[5]
 *     掩码 = 1 << (9&7) = 1<<1 = 0x02
 */
static inline eui_uint8_t* _buf_ptr(Canvas *c, int x, int y) {
    return &c->buf[((y - c->buf_area.y1) >> 3) * c->stride + x];
}

/**
 * _raw_pixel: 原始像素操作（无边界检查）
 *
 * @param mode 绘制模式：EUI_MODE_SET 直接覆盖，EUI_MODE_XOR 与显存异或
 *
 * 【XOR 模式原理】
 *   1bpp 下 XOR 即对目标字节中与掩码对应的位取反：
 *     dest ^= mask
 *   同一图形用 XOR 绘制两次可完全恢复原状，常用于：
 *     - 光标/选框的临时高亮（无需保存背景）
 *     - 橡皮擦效果（绘制过的像素再次绘制即擦除）
 *     - 反色文字叠加
 */
static inline void _raw_pixel(Canvas *c, int x, int y, EUI_DrawMode mode) {
    eui_uint8_t *p = _buf_ptr(c, x, y);
    eui_uint8_t m = _bit_mask(y);

    switch (mode) {
        case EUI_MODE_XOR:
            *p ^= m;   /* XOR：翻转对应位 */
            break;

        case EUI_MODE_SET:
            *p |= m;
            break;

        case EUI_MODE_CLER:
            *p &= ~m;
            break;

        default:
            break;
    }
}

/* ==================== 基础绘制函数 ==================== */

/**
 * @brief  绘制单个像素点（带裁剪，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x      像素 X 坐标
 * @param  y      像素 Y 坐标
 * @param  mode   绘制模式：EUI_MODE_SET EUI_MODE_CLER EUI_MODE_XOR
 * @note   XOR 模式下仅翻转目标位
 */
void eui_draw_pixel(Canvas *c, int x, int y, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    const Area *clip = canvas_clip_top(c);
    if (x < clip->x1 || x > clip->x2 || y < clip->y1 || y > clip->y2) return;
    if (y < c->buf_area.y1 || y > c->buf_area.y2) return;
    _raw_pixel(c, x, y, mode);
}

/**
 * @brief  绘制水平线（带裁剪，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x1     起点 X 坐标
 * @param  x2     终点 X 坐标
 * @param  y      Y 坐标
 * @param  mode   绘制模式
 * @note   XOR 模式下对整段水平线内的所有像素位进行异或翻转
 */
void eui_draw_hline(Canvas *c, int x1, int x2, int y, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    CANVAS_CLIP(c, x1, y, x2, y);
    if (y < c->buf_area.y1 || y > c->buf_area.y2) return;

    eui_uint8_t *p = _buf_ptr(c, x1, y);
    eui_uint8_t m = _bit_mask(y);

    switch (mode) {
        case EUI_MODE_SET:
            for (int x = x1; x <= x2; x++) *p++ |= m;
            break;

        case EUI_MODE_CLER:
            for (int x = x1; x <= x2; x++) *p++ &= ~m;
            break;

        case EUI_MODE_XOR:
            for (int x = x1; x <= x2; x++) { *p++ ^= m; }
            break;

        default:
            break;
    }
}


/**
 * @brief  绘制垂直线（带裁剪，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x      X 坐标
 * @param  y1     起点 Y 坐标
 * @param  y2     终点 Y 坐标
 * @param  mode   绘制模式
 * @note   XOR 模式下对整段垂直线内的所有像素位进行异或翻转
 *         完整页可用 0xFF 异或实现整字节翻转，保持高效
 */
void eui_draw_vline(Canvas *c, int x, int y1, int y2, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    CANVAS_CLIP(c, x, y1, x, y2);

    if (y2 < c->buf_area.y1 || y1 > c->buf_area.y2) return;
    if (y1 < c->buf_area.y1) y1 = c->buf_area.y1;
    if (y2 > c->buf_area.y2) y2 = c->buf_area.y2;

    int page1 = y1 >> 3;
    int page2 = y2 >> 3;
    eui_uint8_t *p = _buf_ptr(c, x, y1);

    if (page1 == page2) {
        /* 同一页内：生成部分掩码 */
        eui_uint8_t m = ((1u << ((y2 & 7) + 1)) - 1) & ~((1u << (y1 & 7)) - 1);

        switch (mode) {
            case EUI_MODE_SET:
                *p |= m;
                break;

            case EUI_MODE_CLER:
                *p &= ~m;
                break;

            case EUI_MODE_XOR:
                 *p ^= m;
                break;

            default:
                break;
        }

    } else {
        /* 首部（部分页） */
        eui_uint8_t m1 = 0xFF << (y1 & 7);

        switch (mode) {
            case EUI_MODE_SET:
                *p |= m1;
                break;

            case EUI_MODE_CLER:
                *p &= ~m1;
                break;

            case EUI_MODE_XOR:
                *p ^= m1;
                break;

            default:
                break;
        }

        p += c->stride;

        /* 中部（完整页）：整字节操作，最快路径 */
        for (int page = page1 + 1; page < page2; page++) {

            switch (mode) {
                case EUI_MODE_SET:
                    *p = 0xFF;
                    break;

                case EUI_MODE_CLER:
                    *p = 0x00;
                    break;

                case EUI_MODE_XOR:
                     *p ^= 0xFF;
                    break;

                default:
                    break;
            }

            p += c->stride;
        }

        /* 尾部（部分页） */
        if (page2 > page1) {
            eui_uint8_t m2 = (1u << ((y2 & 7) + 1)) - 1;

            switch (mode) {
                case EUI_MODE_SET:
                    *p |= m2;
                    break;

                case EUI_MODE_CLER:
                    *p &= ~m2;
                    break;

                case EUI_MODE_XOR:
                     *p ^= m2;
                    break;

                default:
                    break;
            }

        }
    }
}


/**
 * @brief  绘制任意直线（Bresenham 算法，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x0     起点 X 坐标
 * @param  y0     起点 Y 坐标
 * @param  x1     终点 X 坐标
 * @param  y1     终点 Y 坐标
 * @param  mode   绘制模式
 * @note   逐像素调用 eui_draw_pixel_ex，XOR 模式下每个像素独立翻转
 */
void eui_draw_line(Canvas *c, int x0, int y0, int x1, int y1, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    int dx = abs(x1 - x0), sx = (x0 < x1) ? 1 : -1;
    int dy = abs(y1 - y0), sy = (y0 < y1) ? 1 : -1;
    int err = dx - dy;

    while (1) {
        eui_draw_pixel(c, x0, y0, mode);
        if (x0 == x1 && y0 == y1) break;
        int e2 = 2 * err;
        if (e2 > -dy) { err -= dy; x0 += sx; }
        if (e2 < dx)  { err += dx; y0 += sy; }
    }
}

/* ==================== 矩形 ==================== */


/**
 * @brief  绘制实心矩形（带裁剪，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x1     左上角 X 坐标
 * @param  y1     左上角 Y 坐标
 * @param  x2     右下角 X 坐标
 * @param  y2     右下角 Y 坐标
 * @param  mode   绘制模式
 * @note   XOR 模式下：
 *         - 整页覆盖区域用 0xFF 异或整字节（高效）
 *         - 部分页覆盖区域用掩码异或逐字节
 */
void eui_draw_rect_fill(Canvas *c, int x1, int y1, int x2, int y2,EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    CANVAS_CLIP(c, x1, y1, x2, y2);

    if (y1 < c->buf_area.y1) y1 = c->buf_area.y1;
    if (y2 > c->buf_area.y2) y2 = c->buf_area.y2;
    if (y1 > y2) return;

    int page1 = y1 >> 3;
    int page2 = y2 >> 3;
    int w = x2 - x1 + 1;

    for (int page = page1; page <= page2; page++) {
        /* 计算该页内被矩形覆盖的 bit 掩码 */
        eui_uint8_t mask;
        if (page1 == page2) {
            mask = ((1u << ((y2 & 7) + 1)) - 1) & ~((1u << (y1 & 7)) - 1);
        } else if (page == page1) {
            mask = 0xFF << (y1 & 7);
        } else if (page == page2) {
            mask = (1u << ((y2 & 7) + 1)) - 1;
        } else {
            mask = 0xFF;  /* 整页覆盖 */
        }

        /* 该行在 buf 中的起始地址（注意用 buf_area.y1 计算页偏移） */
        eui_uint8_t *row = c->buf + ((page - (c->buf_area.y1 >> 3)) * c->stride) + x1;

        switch (mode) {
            case EUI_MODE_SET:
                if (mask == 0xFF) {
                    memset(row, 0xFF, w);
                }
                else {
                    for (int i = 0; i < w; i++) row[i] |= mask;
                }
                break;

            case EUI_MODE_CLER:
                if (mask == 0xFF) {
                    memset(row, 0x00, w);
                }
                else {
                    for (int i = 0; i < w; i++) row[i] &= ~mask;
                }
                break;

            case EUI_MODE_XOR:
                for (int i = 0; i < w; i++) row[i] ^= mask;
                break;

            default:
                break;
        }
    }
}


/**
 * @brief  绘制矩形边框（带裁剪，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x1     左上角 X 坐标
 * @param  y1     左上角 Y 坐标
 * @param  x2     右下角 X 坐标
 * @param  y2     右下角 Y 坐标
 * @param  mode   绘制模式
 * @note   由两条水平线 + 两条垂直线组成，均支持 XOR 模式
 */
void eui_draw_rect_stroke(Canvas *c, int x1, int y1, int x2, int y2, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    if (x1 > x2) { int t = x1; x1 = x2; x2 = t; }
    if (y1 > y2) { int t = y1; y1 = y2; y2 = t; }

    eui_draw_hline(c, x1, x2, y1, mode);  /* 上边 */
    eui_draw_hline(c, x1, x2, y2, mode);  /* 下边 */
    if (y1 + 1 <= y2 - 1) {
        eui_draw_vline(c, x1, y1 + 1, y2 - 1, mode);  /* 左边 */
        eui_draw_vline(c, x2, y1 + 1, y2 - 1, mode);  /* 右边 */
    }
}


/**
 * @brief  绘制带边框的矩形（内部填充黑色，边框指定颜色，支持 XOR 模式）
 * @param  c             Canvas 指针，不能为 ESGUI_NULL
 * @param  x1            左上角 X 坐标
 * @param  y1            左上角 Y 坐标
 * @param  x2            右下角 X 坐标
 * @param  y2            右下角 Y 坐标
 * @param  mode          绘制模式
 * @note   内部先 fill(0) 再 stroke(border_color)。
 *         XOR 模式下：将边框翻转，
 *         整体效果为"边框反色"。
 */
void eui_draw_rect_box(Canvas *c, int x1, int y1, int x2, int y2,EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    switch (mode) {
        case EUI_MODE_SET:
            eui_draw_rect_fill(c, x1, y1, x2, y2, EUI_MODE_CLER);
            eui_draw_rect_stroke(c, x1, y1, x2, y2, EUI_MODE_SET);
            break;

        case EUI_MODE_CLER:
            eui_draw_rect_fill(c, x1, y1, x2, y2, EUI_MODE_CLER);
            break;

        case EUI_MODE_XOR:
            eui_draw_rect_fill(c, x1, y1, x2, y2, EUI_MODE_CLER);
            eui_draw_rect_stroke(c, x1, y1, x2, y2, EUI_MODE_XOR);
            break;

        default:
            break;
    }
}

/* ==================== 圆 ==================== */

/**
 * @brief  绘制圆形边框（中点圆算法，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  cx     圆心 X 坐标
 * @param  cy     圆心 Y 坐标
 * @param  r      半径，必须 >= 0
 * @param  mode   绘制模式
 * @note   8 路对称点均通过 eui_draw_pixel_ex 绘制，支持 XOR 翻转
 */
void eui_draw_circle_stroke(Canvas *c, int cx, int cy, int r, EUI_DrawMode mode) {
    if (c == ESGUI_NULL || r < 0) return;

    int x = 0, y = r, d = 3 - 2 * r;

    while (x <= y) {
        eui_draw_pixel(c, cx + x, cy + y, mode);
        eui_draw_pixel(c, cx - x, cy + y, mode);
        eui_draw_pixel(c, cx + x, cy - y, mode);
        eui_draw_pixel(c, cx - x, cy - y, mode);
        eui_draw_pixel(c, cx + y, cy + x, mode);
        eui_draw_pixel(c, cx - y, cy + x, mode);
        eui_draw_pixel(c, cx + y, cy - x, mode);
        eui_draw_pixel(c, cx - y, cy - x, mode);

        if (d < 0) d += 4 * x + 6;
        else { d += 4 * (x - y) + 10; y--; }
        x++;
    }
}


/**
 * @brief  绘制实心圆（扫描线填充，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  cx     圆心 X 坐标
 * @param  cy     圆心 Y 坐标
 * @param  r      半径，必须 >= 0
 * @param  mode   绘制模式
 * @note   每行调用 eui_draw_hline_ex 填充，XOR 模式下整行翻转
 */
void eui_draw_circle_fill(Canvas *c, int cx, int cy, int r,EUI_DrawMode mode) {
    if (c == ESGUI_NULL || r < 0) return;

    int x = r, y = 0, err = 0;

    while (x >= y) {
        eui_draw_hline(c, cx - x, cx + x, cy + y, mode);
        if (y != 0) eui_draw_hline(c, cx - x, cx + x, cy - y, mode);
        if (y != x) {
            eui_draw_hline(c, cx - y, cx + y, cy + x, mode);
            eui_draw_hline(c, cx - y, cx + y, cy - x, mode);
        }

        y++; err += 1 + 2 * y;
        if (2 * (err - x) + 1 > 0) { x--; err += 1 - 2 * x; }
    }
}


/**
 * @brief  绘制带边框的实心圆（内部黑色，边框指定颜色，支持 XOR 模式）
 * @param  c             Canvas 指针，不能为 ESGUI_NULL
 * @param  cx            圆心 X 坐标
 * @param  cy            圆心 Y 坐标
 * @param  r             半径，必须 >= 0
 * @param  mode          绘制模式
 */
void eui_draw_circle_box(Canvas *c, int cx, int cy, int r, EUI_DrawMode mode) {
    if (c == ESGUI_NULL || r < 0) return;

    switch (mode) {
        case EUI_MODE_SET:
            eui_draw_circle_fill(c, cx, cy, r, EUI_MODE_CLER);
            eui_draw_circle_stroke(c, cx, cy, r, EUI_MODE_SET);
            break;

        case EUI_MODE_CLER:
            eui_draw_circle_fill(c, cx, cy, r, EUI_MODE_CLER);
            break;

        case EUI_MODE_XOR:
            eui_draw_circle_fill(c, cx, cy, r, EUI_MODE_CLER);
            eui_draw_circle_stroke(c, cx, cy, r, EUI_MODE_XOR);
            break;

        default:
            break;
    }
}

/* ==================== 三角形 ==================== */


/**
 * @brief  绘制三角形边框（带裁剪，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x0     顶点 0 X 坐标
 * @param  y0     顶点 0 Y 坐标
 * @param  x1     顶点 1 X 坐标
 * @param  y1     顶点 1 Y 坐标
 * @param  x2     顶点 2 X 坐标
 * @param  y2     顶点 2 Y 坐标
 * @param  mode   绘制模式
 * @note   三条边分别调用 eui_draw_line_ex
 */
void eui_draw_triangle_stroke(Canvas *c, int x0, int y0, int x1, int y1, int x2, int y2, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    eui_draw_line(c, x0, y0, x1, y1, mode);
    eui_draw_line(c, x1, y1, x2, y2,  mode);
    eui_draw_line(c, x2, y2, x0, y0,  mode);
}

static inline void _tri_edge_scan(int y, int ex1, int ey1, int ex2, int ey2,
                                   int *xl, int *xr, int *cnt)
{
    if (y < ey1 || y > ey2 || ey2 == ey1) return;
    int x = ex1 + (ex2 - ex1) * (y - ey1) / (ey2 - ey1);
    if (x < *xl) *xl = x;
    if (x > *xr) *xr = x;
    (*cnt)++;
}

/**
 * @brief  绘制实心三角形（扫描线填充，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x0     顶点 0 X 坐标
 * @param  y0     顶点 0 Y 坐标
 * @param  x1     顶点 1 X 坐标
 * @param  y1     顶点 1 Y 坐标
 * @param  x2     顶点 2 X 坐标
 * @param  y2     顶点 2 Y 坐标
 * @param  mode   绘制模式
 * @note   每行扫描出左右边界后，调用 eui_draw_hline_ex 填充，支持 XOR
 */
void eui_draw_triangle_fill(Canvas *c, int x0, int y0, int x1, int y1, int x2, int y2, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    if (y0 > y1) { int t = x0; x0 = x1; x1 = t; t = y0; y0 = y1; y1 = t; }
    if (y0 > y2) { int t = x0; x0 = x2; x2 = t; t = y0; y0 = y2; y2 = t; }
    if (y1 > y2) { int t = x1; x1 = x2; x2 = t; t = y1; y1 = y2; y2 = t; }

    const Area *clip = canvas_clip_top(c);
    int ys = (y0 > clip->y1) ? y0 : clip->y1;
    int ye = (y2 < clip->y2) ? y2 : clip->y2;
    if (ys > ye) return;

    for (int y = ys; y <= ye; y++) {
        int xl = INT_MAX, xr = INT_MIN, cnt = 0;

        _tri_edge_scan(y, x0, y0, x1, y1, &xl, &xr, &cnt);
        _tri_edge_scan(y, x1, y1, x2, y2, &xl, &xr, &cnt);
        _tri_edge_scan(y, x0, y0, x2, y2, &xl, &xr, &cnt);

        if (cnt >= 2 && xl <= xr) {
            int x1c = xl, x2c = xr;
            if (x1c < clip->x1) x1c = clip->x1;
            if (x2c > clip->x2) x2c = clip->x2;
            if (x1c <= x2c) eui_draw_hline(c, x1c, x2c, y, mode);
        }
    }
}



/**
 * @brief  绘制带边框的实心三角形（内部黑色，边框指定颜色，支持 XOR 模式）
 * @param  c             Canvas 指针，不能为 ESGUI_NULL
 * @param  x0            顶点 0 X 坐标
 * @param  y0            顶点 0 Y 坐标
 * @param  x1            顶点 1 X 坐标
 * @param  y1            顶点 1 Y 坐标
 * @param  x2            顶点 2 X 坐标
 * @param  y2            顶点 2 Y 坐标
 * @param  mode          绘制模式
 */
void eui_draw_triangle_box(Canvas *c, int x0, int y0, int x1, int y1, int x2, int y2, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    switch (mode) {
        case EUI_MODE_SET:
            eui_draw_triangle_fill(c, x0, y0, x1, y1, x2, y2, EUI_MODE_CLER);
            eui_draw_triangle_stroke(c, x0, y0, x1, y1, x2, y2, EUI_MODE_SET);
            break;

        case EUI_MODE_CLER:
            eui_draw_triangle_fill(c, x0, y0, x1, y1, x2, y2, EUI_MODE_CLER);
            break;

        case EUI_MODE_XOR:
            eui_draw_triangle_fill(c, x0, y0, x1, y1, x2, y2, EUI_MODE_CLER);
            eui_draw_triangle_stroke(c, x0, y0, x1, y1, x2, y2, EUI_MODE_XOR);
            break;

        default:
            break;
    }
}

/* ==================== 圆角矩形 ==================== */

/**
 * fill_circle_quadrant: 填充 1/4 圆扇形（内部辅助）
 *
 * 页式格式下，从圆心辐射出的水平线调用 eui_draw_hline（逐列），
 * 圆角半径通常很小（2~4），性能可接受。
 */
static void fill_circle_quadrant(Canvas *c, int cx, int cy, int r, int sx, int sy, EUI_DrawMode mode) {
    int x = r, y = 0, err = 0;

    while (x >= y) {
        int y1 = cy + sy * y;
        int y2 = cy + sy * x;

        if (sx > 0) {
            eui_draw_hline(c, cx, cx + x, y1, mode);
            if (y != x) eui_draw_hline(c, cx, cx + y, y2, mode);
        } else {
            eui_draw_hline(c, cx - x, cx, y1,mode);
            if (y != x) eui_draw_hline(c, cx - y, cx, y2, mode);
        }

        y++; err += 1 + 2 * y;
        if (2 * (err - x) + 1 > 0) { x--; err += 1 - 2 * x; }
    }
}

/**
 * @brief  绘制圆角矩形边框（带裁剪，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x1     左上角 X 坐标
 * @param  y1     左上角 Y 坐标
 * @param  x2     右下角 X 坐标
 * @param  y2     右下角 Y 坐标
 * @param  r      圆角半径，负数会被钳位到 0
 * @param  mode   绘制模式
 * @note   由两条水平线 + 两条垂直线 + 四个 1/8 圆弧组成，均支持 XOR
 */
void eui_draw_round_rect_stroke(Canvas *c, int x1, int y1, int x2, int y2, int r, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    if (x1 > x2) { int t = x1; x1 = x2; x2 = t; }
    if (y1 > y2) { int t = y1; y1 = y2; y2 = t; }

    int w = x2 - x1 + 1, h = y2 - y1 + 1;
    if (r > w / 2) r = w / 2;
    if (r > h / 2) r = h / 2;
    if (r < 0) r = 0;

    int cx1 = x1 + r, cy1 = y1 + r;
    int cx2 = x2 - r, cy2 = y2 - r;

    if (w > 2 * r) {
        eui_draw_hline(c, x1 + r, x2 - r, y1, mode);
        eui_draw_hline(c, x1 + r, x2 - r, y2, mode);
    }
    if (h > 2 * r) {
        eui_draw_vline(c, x1, y1 + r, y2 - r,mode);
        eui_draw_vline(c, x2, y1 + r, y2 - r,mode);
    }

    if (r > 0) {
        int x = 0, y = r, d = 3 - 2 * r;
        while (x <= y) {
            eui_draw_pixel(c, cx1 - x, cy1 - y,  mode);
            if (x != y) eui_draw_pixel(c, cx1 - y, cy1 - x, mode);
            eui_draw_pixel(c, cx2 + x, cy1 - y,  mode);
            if (x != y) eui_draw_pixel(c, cx2 + y, cy1 - x, mode);
            eui_draw_pixel(c, cx2 + x, cy2 + y,  mode);
            if (x != y) eui_draw_pixel(c, cx2 + y, cy2 + x,  mode);
            eui_draw_pixel(c, cx1 - x, cy2 + y,  mode);
            if (x != y) eui_draw_pixel(c, cx1 - y, cy2 + x,  mode);

            if (d < 0) d += 4 * x + 6;
            else { d += 4 * (x - y) + 10; y--; }
            x++;
        }
    }
}


/**
 * @brief  绘制实心圆角矩形（带裁剪，支持 XOR 模式）
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x1     左上角 X 坐标
 * @param  y1     左上角 Y 坐标
 * @param  x2     右下角 X 坐标
 * @param  y2     右下角 Y 坐标
 * @param  r      圆角半径，负数会被钳位到 0
 * @param  mode   绘制模式
 * @note   由主体矩形 + 上下填充带 + 四个 1/4 圆扇形组成，
 *         所有子操作均通过 _ex 版本传递 mode 参数
 */
void eui_draw_round_rect_fill(Canvas *c, int x1, int y1, int x2, int y2, int r, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    if (x1 > x2) { int t = x1; x1 = x2; x2 = t; }
    if (y1 > y2) { int t = y1; y1 = y2; y2 = t; }

    int w = x2 - x1 + 1, h = y2 - y1 + 1;
    if (r > w / 2) r = w / 2;
    if (r > h / 2) r = h / 2;
    if (r < 0) r = 0;

    int cx1 = x1 + r, cy1 = y1 + r;
    int cx2 = x2 - r, cy2 = y2 - r;

    /* 1. 中间主体矩形（完整宽度，高度减去上下圆角） */
    if (y1 + r <= y2 - r)
        eui_draw_rect_fill(c, x1, y1 + r, x2, y2 - r, mode);

    /* 2. 上下两条填充带 */
    if (r > 0) {
        if (y1 <= y1 + r - 1)
            eui_draw_rect_fill(c, x1 + r, y1, x2 - r, y1 + r - 1, mode);
        if (y2 - r + 1 <= y2)
            eui_draw_rect_fill(c, x1 + r, y2 - r + 1, x2 - r, y2, mode);
    } else if (y1 == y2) {
        eui_draw_hline(c, x1, x2, y1, mode);
    }

    /* 3. 四个 1/4 圆扇形填充 */
    if (r > 0) {
        fill_circle_quadrant(c, cx1, cy1, r, -1, -1, mode);
        fill_circle_quadrant(c, cx2, cy1, r, +1, -1, mode);
        fill_circle_quadrant(c, cx2, cy2, r, +1, +1, mode);
        fill_circle_quadrant(c, cx1, cy2, r, -1, +1, mode);
    }
}


/**
 * @brief  绘制带边框的实心圆角矩形（内部黑色，边框指定颜色，支持 XOR 模式）
 * @param  c             Canvas 指针，不能为 ESGUI_NULL
 * @param  x1            左上角 X 坐标
 * @param  y1            左上角 Y 坐标
 * @param  x2            右下角 X 坐标
 * @param  y2            右下角 Y 坐标
 * @param  r             圆角半径，负数会被钳位到 0
 * @param  mode          绘制模式
 */
void eui_draw_round_rect_box(Canvas *c, int x1, int y1, int x2, int y2, int r, EUI_DrawMode mode) {
    if (c == ESGUI_NULL) return;

    switch (mode) {
        case EUI_MODE_SET:
            eui_draw_round_rect_fill(c, x1, y1, x2, y2, r, EUI_MODE_CLER);
            eui_draw_round_rect_stroke(c, x1, y1, x2, y2, r, EUI_MODE_SET);
            break;

        case EUI_MODE_CLER:
            eui_draw_round_rect_fill(c, x1, y1, x2, y2, r, EUI_MODE_CLER);
            break;

        case EUI_MODE_XOR:
            eui_draw_round_rect_fill(c, x1, y1, x2, y2, r, EUI_MODE_CLER);
            eui_draw_round_rect_stroke(c, x1, y1, x2, y2, r, EUI_MODE_XOR);
            break;

        default:
            break;
    }
}




/**
 * @brief 对当前 Canvas 绑定的显存应用页面切换百叶窗掩码
 * @param c     Canvas 指针
 * @param level 掩码级别 0~8，0=无掩码，8=最黑（全黑）
 * @note 内部使用 0xAA >> level 的交错扫描线效果，适配条带刷新
 */
void canvas_apply_transition_mask(Canvas *c, eui_uint8_t level) {
    if (c == ESGUI_NULL || level == 0) return;
    if (level > 8) level = 8;

    int pages = (c->buf_area.y2 - c->buf_area.y1 + 1) >> 3;

    for (int p = 0; p < pages; p++) {
        eui_uint8_t *row = c->buf + p * c->stride;
        for (int x = 0; x < c->stride; x++) {
             // row[x] &= (0xAA >> level);   /* 整字节统一掩码，条带间无相位跳变 */
            // row[x] &= (0xAA >> (x % level));

            // row[x] &= ((0xAA >> level) >> (x % 8));
            row[x] &= ((0xAA >> level) >> (x % level));

            // row[x] &= ((0xAA >> level) << (x % 8));
            // row[x] &= ((0xAA >> level) << (level));
        }
    }
}




/**
 * @brief 对当前 Canvas 应用中心裁剪式缩放遮罩（真正的"放大/缩小"效果）
 * @param c     Canvas 指针
 * @param level 遮罩级别 0~8：
 *              0 = 全屏显示（无遮罩）
 *              8 = 只显示中心最小区域（完全收缩）
 * @note  通过计算中心矩形裁剪区，让页面内容从中心向外"放大展开"或向中心"缩小消失"。
 *        与"四黑边"方案不同，此方案保留中心区域的内容，视觉上更像镜头缩放。
 *        适用于单色屏页式显存，零浮点运算。
 */
void canvas_apply_zoom_mask(Canvas *c, eui_uint8_t level) {
    if (c == ESGUI_NULL || level == 0) return;
    if (level > 8) level = 8;

    int w = c->stride;
    int h = c->buf_area.y2 - c->buf_area.y1 + 1;

    /* 计算中心可见区的半宽高：level 越大，可见区越小 */
    /* 公式：半宽 = w/2 * (8-level)/8，即 level=8 时半宽=0，level=0 时半宽=w/2 */
    int half_w = (w * (8 - level)) / 16;
    int half_h = (h * (8 - level)) / 16;
    if (half_w < 1) half_w = 1;
    if (half_h < 1) half_h = 1;

    int cx = w / 2;
    int cy = h / 2;

    int x1 = cx - half_w;
    int y1 = cy - half_h;
    int x2 = cx + half_w - 1;
    int y2 = cy + half_h - 1;

    if (x1 < 0) x1 = 0;
    if (y1 < 0) y1 = 0;
    if (x2 >= w) x2 = w - 1;
    if (y2 >= h) y2 = h - 1;

    /* 绘制 4 个黑色矩形遮住中心区域之外的部分 */
    /* 上 */
    if (y1 > 0) {
        eui_draw_rect_fill(c, 0, 0, w - 1, y1 - 1, EUI_MODE_CLER);
    }
    /* 下 */
    if (y2 < h - 1) {
        eui_draw_rect_fill(c, 0, y2 + 1, w - 1, h - 1, EUI_MODE_CLER);
    }
    /* 左 */
    if (x1 > 0 && y1 <= y2) {
        eui_draw_rect_fill(c, 0, y1, x1 - 1, y2, EUI_MODE_CLER);
    }
    /* 右 */
    if (x2 < w - 1 && y1 <= y2) {
        eui_draw_rect_fill(c, x2 + 1, y1, w - 1, y2, EUI_MODE_CLER);
    }
}
