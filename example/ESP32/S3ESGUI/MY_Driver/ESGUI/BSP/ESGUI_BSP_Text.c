#include "ESGUI_BSP_Text.h"
#include "ESGUI_BSP_BMP.h"

/**
 * @brief  从 UTF-8 字符串中解码下一个 Unicode 码点
 * @param  txt  输入字符串（以 '\0' 结尾），不能为 ESGUI_NULL
 * @param  idx  入出参：当前字节索引指针，不能为 ESGUI_NULL；返回后指向下一字符首字节
 * @return      Unicode 码点（32-bit）；遇到非法首字节时返回 '?' 并跳过一字节
 * @note   支持标准 UTF-8 四字节序列：
 *         0xxxxxxx                    → 1-byte (U+0000~U+007F)
 *         110xxxxx 10xxxxxx           → 2-byte (U+0080~U+07FF)
 *         1110xxxx 10xxxxxx 10xxxxxx  → 3-byte (U+0800~U+FFFF)
 *         11110xxx 10xxxxxx 10xxxxxx 10xxxxxx → 4-byte (U+10000~U+10FFFF)
 */
static eui_uint32_t utf8_decode(const char *txt, eui_uint16_t *idx)
{
    eui_uint32_t cp = 0;
    eui_uint8_t c = txt[*idx];

    if ((c & 0x80) == 0) {              // 0xxxxxxx: 1-byte
        cp = c;
        (*idx)++;
    } else if ((c & 0xE0) == 0xC0) {    // 110xxxxx: 2-byte
        cp = ((c & 0x1F) << 6) | (txt[*idx + 1] & 0x3F);
        *idx += 2;
    } else if ((c & 0xF0) == 0xE0) {    // 1110xxxx: 3-byte
        cp = ((c & 0x0F) << 12) | ((txt[*idx + 1] & 0x3F) << 6)
           | (txt[*idx + 2] & 0x3F);
        *idx += 3;
    } else if ((c & 0xF8) == 0xF0) {    // 11110xxx: 4-byte
        cp = ((c & 0x07) << 18) | ((txt[*idx + 1] & 0x3F) << 12)
           | ((txt[*idx + 2] & 0x3F) << 6) | (txt[*idx + 3] & 0x3F);
        *idx += 4;
    } else {                            // 非法首字节，跳过
        (*idx)++;
        cp = '?';
    }
    return cp;
}

/**
 * @brief  通过 Unicode 码点查找字形索引
 * @param  font    字体指针，不能为 ESGUI_NULL
 * @param  unicode Unicode 码点（32-bit）
 * @retval >=0    字形索引
 * @retval -1     缺字（未找到对应字形）
 * @note   遍历字体中的所有 cmap（映射表）。
 *         type=0 连续范围直接计算；type=1 稀疏列表使用二分查找（要求升序）。
 */
eui_int16_t eui_font_get_glyph_id(const Font *font, eui_uint32_t unicode)
{
    /* 空指针保护 */
    if (!font || !font->cmaps) return -1;

    for (eui_uint32_t i = 0; i < font->cmap_num; i++) {
        const FontCmap *cm = &font->cmaps[i];

        /* cmap 空指针保护 */
        if (cm->type == 1 && !cm->unicode_list && cm->list_length > 0) continue;

        if (cm->type == 0) {
            if (unicode >= cm->range_start &&
                unicode < cm->range_start + cm->range_length)
                return (eui_int16_t)(cm->glyph_id_start + (unicode - cm->range_start));
        } else {
            /* ========== 二分查找（要求 unicode_list 升序） ========== */
            int left = 0;
            int right = (int)cm->list_length - 1;
            while (left <= right) {
                int mid = (left + right) >> 1;
                eui_uint32_t mid_val = cm->unicode_list[mid];
                if (mid_val == unicode) {
                    return (eui_int16_t)(cm->glyph_id_start + mid);
                } else if (mid_val < unicode) {
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            /* ======================================================== */
        }
    }
    return -1;
}

/**
 * @brief  计算字符串在指定字体下的总显示宽度（像素）
 * @param  font  字体指针，不能为 ESGUI_NULL
 * @param  text  UTF-8 文本指针，不能为 ESGUI_NULL
 * @retval >=0   字符串总显示宽度（像素）
 * @note   遍历所有字符累加 adv_w（水平步进）。缺字字符按半行高占位。
 *         换行符 '\n' 不增加宽度。
 *         保留控制字符 '\x03'（ESC，ESGUI 标记符前缀）：视为字符串结束，
 *         其后内容（如标记类型 "/7"）不计入宽度 —— 标记符是不可见元数据。
 */
int eui_get_text_width(const Font *font, const char *text)
{
    if (font == ESGUI_NULL || text == ESGUI_NULL) return 0;

    eui_uint16_t i = 0;
    int w = 0;

    /* 字符缓存：避免连续相同字符重复查表 */
    eui_uint32_t prev_cp = 0;
    eui_int16_t  prev_gid = -2;   /* -2 表示缓存无效 */

    while (text[i]) {
        /* 标记符前缀 '\x03'：其后为不可见元数据，结束测量 */
        if (text[i] == '\x03') break;

        eui_uint32_t cp = utf8_decode(text, &i);
        eui_int16_t gid;

        if (cp == prev_cp && prev_gid != -2) {
            gid = prev_gid;
        } else {
            gid = eui_font_get_glyph_id(font, cp);
            prev_cp = cp;
            prev_gid = gid;
        }

        if (gid >= 0) w += font->glyphs[gid].adv_w;
        else w += font->line_height / 2; /* 缺字用半行高占位 */
    }
    return w;
}

/**
 * @brief  绘制 UTF-8 文本
 * @param  c      Canvas 指针，不能为 ESGUI_NULL
 * @param  x      文本起始 X 坐标（左上角）
 * @param  y      文本起始 Y 坐标（行顶）
 * @param  font   字体指针，不能为 ESGUI_NULL
 * @param  text   UTF-8 文本指针，不能为 ESGUI_NULL
 * @param  color  1=白字，0=黑字（挖空）
 * @retval >=0    实际占用宽度（像素）
 * @note   光标从 (x, y) 开始，cy 始终指向行顶。
 *         字形实际绘制位置 = (cx + ofs_x, cy + base_line + ofs_y)。
 *         遇到 '\n' 时自动换行。
 *         当 gy 是 8 的倍数且 box_h 是 8 的倍数时，走整页快速路径。
 *         保留控制字符 '\x03'（ESC，ESGUI 标记符前缀）：视为字符串结束，
 *         其后内容（如标记类型 "/7"）不绘制 —— 标记符是不可见元数据。
 */
int eui_draw_text(Canvas *c, int x, int y, const Font *font, const char *text, eui_uint8_t color)
{
    if (c == ESGUI_NULL || font == ESGUI_NULL || text == ESGUI_NULL) return 0;
    if (!font->glyphs || !font->bitmap || font->cmap_num == 0) return 0;

    eui_uint16_t i = 0;
    int cx = x, cy = y;
    int max_x = cx;

    /* 字符缓存：避免连续相同字符重复查表 */
    eui_uint32_t prev_cp = 0;
    eui_int16_t  prev_gid = -2;   /* -2 表示缓存无效 */

    while (text[i]) {
        /* 标记符前缀 '\x03'：其后为不可见元数据，结束绘制 */
        if (text[i] == '\x03') break;
        if (text[i] == '\n') {
            if (cx > max_x) max_x = cx;
            cx = x;
            cy += font->line_height;
            i++;
            continue;
        }

        eui_uint32_t cp = utf8_decode(text, &i);
        eui_int16_t gid;


        if (cp == prev_cp && prev_gid != -2) {
            gid = prev_gid;
        } else {
            gid = eui_font_get_glyph_id(font, cp);
            prev_cp = cp;
            prev_gid = gid;
        }

        if (gid < 0) {
            cx += font->line_height / 2;
            continue;
        }

        const FontGlyph *g = &font->glyphs[gid];


        /* 新增：glyph 越界保护（防止 bitmap_index 超出 bitmap 数组） */
        if (!g || g->bitmap_index >= 0xFFFFFFFF) continue;  /* 无意义，直接删掉 */

        if (g->box_w && g->box_h) {
            /* 新增：确保 bitmap 指针有效 */
            const eui_uint8_t *bmp_data = &font->bitmap[g->bitmap_index];
            if (!bmp_data) continue;

            Bitmap bmp = {g->box_w, g->box_h, bmp_data};
            int gx = cx + g->ofs_x;
            int gy = cy + font->base_line + g->ofs_y;
            eui_draw_bitmap_transparent(c, gx, gy, &bmp, color, 0);
        }
        cx += g->adv_w;
    }
    if (cx > max_x) max_x = cx;
    return max_x - x;
}

/**
 * @brief  绘制文本，超出 max_w 自动截断（单行）
 * @param  c       Canvas 指针，不能为 ESGUI_NULL
 * @param  x       文本起始 X 坐标
 * @param  y       文本起始 Y 坐标（行顶）
 * @param  font    字体指针，不能为 ESGUI_NULL
 * @param  text    UTF-8 文本指针，不能为 ESGUI_NULL
 * @param  color   1=白字，0=黑字（挖空）
 * @param  max_w   最大可用宽度（像素），必须 >= 0
 * @retval >=0     实际绘制宽度（像素）
 * @note   遇到换行符或超出 max_w 时提前终止。
 *         缺字字符按半行高占位，若剩余空间不足则截断。
 *         保留控制字符 '\x03'（ESC，ESGUI 标记符前缀）：视为字符串结束，
 *         其后内容（如标记类型 "/7"）不绘制 —— 标记符是不可见元数据。
 */
int eui_draw_text_clip(Canvas *c, int x, int y, const Font *font, const char *text, eui_uint8_t color, int max_w)
{
    if (c == ESGUI_NULL || font == ESGUI_NULL || text == ESGUI_NULL || max_w < 0) return 0;

    if (!font->glyphs || !font->bitmap || font->cmap_num == 0) return 0;

    eui_uint16_t i = 0;
    int cx = x, cy = y;

    /* 字符缓存：避免连续相同字符重复查表 */
    eui_uint32_t prev_cp = 0;
    eui_int16_t  prev_gid = -2;   /* -2 表示缓存无效 */

    while (text[i]) {
        if (text[i] == '\n') break;
        /* 标记符前缀 '\x03'：其后为不可见元数据，结束绘制 */
        if (text[i] == '\x03') break;

        eui_uint32_t cp = utf8_decode(text, &i);
        eui_int16_t gid;

        if (cp == prev_cp && prev_gid != -2) {
            gid = prev_gid;
        } else {
            gid = eui_font_get_glyph_id(font, cp);
            prev_cp = cp;
            prev_gid = gid;
        }

        if (gid < 0) {
            if (cx + font->line_height / 2 > x + max_w) break;
            cx += font->line_height / 2;
            continue;
        }

        const FontGlyph *g = &font->glyphs[gid];
        if (!g || g->bitmap_index >= 0xFFFFFFFF) continue;  /* 无意义，直接删掉 */


        if (cx + g->adv_w > x + max_w) break;

        if (g->box_w && g->box_h) {
            const eui_uint8_t *bmp_data = &font->bitmap[g->bitmap_index];
            if (!bmp_data) continue;

            Bitmap bmp = {g->box_w, g->box_h, bmp_data};
            int gx = cx + g->ofs_x;
            int gy = cy + font->base_line + g->ofs_y;
            eui_draw_bitmap_transparent(c, gx, gy, &bmp, color, 0);
        }
        cx += g->adv_w;
    }
    return cx - x;
}

/**
 * get_text_height: 计算字符串总显示高度
 *
 * 实现说明：
 *   本函数只统计换行符数量，不解码 UTF-8。
 *   因为换行符 '\n' 在 UTF-8 中是单字节 0x0A，无需完整解码即可识别。
 *
 *   高度 = 行数 × font->line_height
 *   行数 = (text[0] == '\0') ? 0 : (1 + '\n' 的数量)
 */
int eui_get_text_height_all_line(const Font *font, const char *text)
{
    if (!text || !text[0] || font == ESGUI_NULL) return 0;   /* 空字符串高度为 0 */

    int lines = 1;                     /* 至少有一行 */
    for (int i = 0; text[i]; i++) {
        if (text[i] == '\n') lines++; /* 每遇到一个换行符增加一行 */
    }
    return lines * font->line_height;
}

int eui_get_text_height(const Font *font, const char *text)
{
    if (!text || !text[0] || font == ESGUI_NULL) return 0;      /* 空文本无高度 */
    return font->line_height;             /* 单行高度 = 字体行高 */
}