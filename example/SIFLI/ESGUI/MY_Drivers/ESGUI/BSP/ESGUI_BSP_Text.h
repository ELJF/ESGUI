//
// Created by E_LJF on 2026/5/31.
//

#ifndef ESGUI_ESGUI_BSP_FONT_H
#define ESGUI_ESGUI_BSP_FONT_H

#include "ESGUI_BSP_Canvas.h"

#define EUI_FONT_CMAP_COUNT(arr)  (sizeof(arr) / sizeof((arr)[0]))  //CMAP自动计算宏

/**
 * FontCmap: Unicode → glyph_id 映射表
 *   type=0: 连续范围（如 ASCII 0x20~0x7E）
 *   type=1: 稀疏列表（如只包含 "0123456789" 或几个中文）
 */
typedef struct {
    uint32_t range_start;        // 起始 Unicode（type=0 用）
    uint16_t range_length;       // 连续长度（type=0 用）
    uint16_t glyph_id_start;     // 对应 glyph_id 起始
    const uint16_t *unicode_list; // 稀疏码点表（type=1 用）
    uint16_t list_length;        // 稀疏表长度
    uint8_t type;                // 0=连续, 1=稀疏
} FontCmap;

/**
 * FontGlyph: 字形描述符
 *
 * 【页式格式说明】
 *   font->bitmap 中的字模数据必须是页式排列（与 SSD1315 GDDRAM 一致）：
 *     每页 stride = box_w（字节）
 *     总页数 = (box_h + 7) / 8
 *     字节内 bit n 对应页内第 n 行（bit0 = 页内最上方）
 *
 *   bitmap_index 为该字模在 font->bitmap[] 中的字节偏移，
 *   由字模生成工具按页式格式计算。
 */
typedef struct {
    uint16_t bitmap_index;       // 页式位图 blob 中的字节偏移
    uint8_t  adv_w;              // 水平步进（像素）
    int8_t   ofs_x, ofs_y;       // 位图相对于光标原点的偏移
    uint8_t  box_w, box_h;       // 位图宽高（像素）
} FontGlyph;

/**
 * Font: 字体实例
 *
 * 【性能提示】
 *   为了触发 eui_draw_bitmap_transparent() 的快速路径（整页 OR/AND），
 *   建议字模高度 box_h 取 8 的倍数（如 8, 16, 24），且字体基线设计
 *   使得实际绘制时 gy = y + base_line + ofs_y 也是 8 的倍数。
 *   此时整个字符串渲染速度接近 memcpy。
 */
typedef struct {
    const uint8_t *bitmap;       // 页式位图 blob（所有字模首尾相接）
    const FontGlyph *glyphs;     // 字形描述符数组
    const FontCmap *cmaps;       // 映射表数组
    uint8_t cmap_num;            // 映射表数量
    uint8_t line_height;         // 行高（含行距）
    int8_t  base_line;           // 基线到行顶的距离（向下为正）
} Font;

/* 查找 glyph_id，未找到返回 -1 */
int16_t eui_font_get_glyph_id(const Font *font, uint32_t unicode);

/* 计算字符串总宽度（像素） */
int eui_get_text_width(const Font *font, const char *text);

/* 绘制文本，返回实际占用宽度（像素） */
int eui_draw_text(Canvas *c, int x, int y, const Font *font, const char *text, uint8_t color);

/* 绘制文本，超出 max_w 自动截断，返回实际宽度 */
int eui_draw_text_clip(Canvas *c, int x, int y, const Font *font, const char *text, uint8_t color, int max_w);

/**
 * get_text_height: 计算字符串在指定字体下的总显示高度
 *
 * @param font 字体实例
 * @param text 以 '\0' 结尾的 UTF-8 字符串
 * @return     总高度（像素）。按行数 × line_height 计算
 *
 * 行数统计规则：
 *   - 空字符串 "" → 返回 0
 *   - 非空字符串初始计 1 行，每遇到一个 '\n' 增加 1 行
 *   - 例："abc" → 1 行；"abc\ndef" → 2 行；"abc\n" → 2 行
 *
 * 与 draw_text 配合使用时，传入的 (x, y) 为行顶坐标，
 * 则文本底部 = y + get_text_height(font, text)。
 */
int eui_get_text_height_all_line(const Font *font, const char *text);

/**
 * get_text_height: 获取单行文本的渲染高度
 *
 * @param font 字体实例
 * @param text 文本内容（仅判断是否为空，不影响高度值）
 * @return     单行高度（像素）。空字符串返回 0，否则返回 font->line_height
 *
 * 说明：
 *   对于位图字体，line_height 在生成时已固定，包含了所有字形的最大
 *   上升部（ascent）和下降部（descent）。因此无论文本是 "aaa" 还是 "ggg"，
 *   单行渲染高度都相同。
 *
 *   如需多行总高度（含换行），请自行计算：行数 × font->line_height
 */
int eui_get_text_height(const Font *font, const char *text);

#endif //ESGUI_ESGUI_BSP_FONT_H
