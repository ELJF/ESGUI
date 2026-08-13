//
// Created by E_LJF on 2026/6/9.
// Flash-optimized: unified progress bar core, zero float, zero sprintf
//

#include "ESGUI_Widget.h"
#include "ESGUI_BSP_draw.h"
#include "string.h"

/* ========== 进度条唯一核心实现（千分比，零浮点） ========== */

static void _progbar_draw_base_v(Canvas *c, int x, int y, eui_uint8_t w, eui_uint16_t len)
{
    eui_uint8_t half = w >> 1;
    eui_draw_rect_fill(c, x, y, x + w, y + 2, EUI_MODE_SET);           /* 顶底座 */
    eui_draw_rect_fill(c, x, y + len - 2, x + w, y + len, EUI_MODE_SET); /* 底底座 */
    if ((w & 1) == 0) { /* 偶数 */
        eui_draw_rect_fill(c, x + half - 1, y + 2, x + half + (w == 3 ? 0 : 0), y + len - 2, EUI_MODE_SET);
    } else { /* 奇数 */
        eui_draw_rect_fill(c, x + half, y + 2, x + half + (w == 3 ? 0 : 1), y + len - 2, EUI_MODE_SET);
    }
}

static void _progbar_draw_base_h(Canvas *c, int x, int y, eui_uint8_t w, eui_uint16_t len)
{
    eui_uint8_t half = w >> 1;
    eui_draw_rect_fill(c, x, y, x + 2, y + w, EUI_MODE_SET);           /* 左底座 */
    eui_draw_rect_fill(c, x + len - 2, y, x + len, y + w, EUI_MODE_SET); /* 右底座 */
    if ((w & 1) == 0) { /* 偶数 */
        eui_draw_rect_fill(c, x + 2, y + half - 1, x + len - 2, y + half + (w == 3 ? 0 : 0), EUI_MODE_SET);
    } else { /* 奇数 */
        eui_draw_rect_fill(c, x + 2, y + half, x + len - 2, y + half + (w == 3 ? 0 : 1), EUI_MODE_SET);
    }
}

void ESGUI_WidgetProgrssBarChangeLenPermille(Canvas *c, int x, int y, eui_uint8_t w, eui_uint16_t len, eui_uint16_t permille, eui_uint8_t direction)
{
    if (c == ESGUI_NULL || len < 13 || permille > 1000) { return; }
    eui_uint16_t max_fill = len - 10; /* 4px 底座 + 6px 留白 */
    eui_uint16_t fill = (eui_uint16_t)(((eui_uint32_t)max_fill * permille) / 1000);
    switch (direction) {
        case ESGUI_WIDGET_PROGBAR_UP:
            _progbar_draw_base_v(c, x, y, w, len);
            eui_draw_rect_fill(c, x, y + len - 5 - fill, x + w, y + len - 5, EUI_MODE_SET);
            break;
        case ESGUI_WIDGET_PROGBAR_DOWN:
            _progbar_draw_base_v(c, x, y, w, len);
            eui_draw_rect_fill(c, x, y + 5, x + w, y + 5 + fill, EUI_MODE_SET);
            break;
        case ESGUI_WIDGET_PROGBAR_RIGHT:
            _progbar_draw_base_h(c, x, y, w, len);
            eui_draw_rect_fill(c, x + 5, y, x + 5 + fill, y + w, EUI_MODE_SET);
            break;
        case ESGUI_WIDGET_PROGBAR_LEFT:
            _progbar_draw_base_h(c, x, y, w, len);
            eui_draw_rect_fill(c, x + len - 5 - fill, y, x + len - 5, y + w, EUI_MODE_SET);
            break;
        default:
            break;
    }
}

void ESGUI_WidgetProgrssBarPermille(Canvas *c, int x, int y, eui_uint8_t w, eui_uint16_t permille, eui_uint8_t direction)
{
    if (c == ESGUI_NULL) return;
    eui_uint16_t len = (direction <= ESGUI_WIDGET_PROGBAR_DOWN) ? (eui_uint16_t)c->height : (eui_uint16_t)c->width;
    ESGUI_WidgetProgrssBarChangeLenPermille(c, x, y, w, len, permille, direction);
}

/* ========== 焦点框与控件（无改动） ========== */

void ESGUI_WidgetTextFocusBox(Canvas *c,int x,int y,eui_uint8_t h,eui_uint8_t len) {
    eui_draw_round_rect_fill(c,x,y,x+len,y+h,1,EUI_MODE_XOR);
}

void ESGUI_WidgetCheckBoxSquare(Canvas *c,int x,int y,eui_uint8_t h,eui_uint8_t len,bool state) {
    if (c == ESGUI_NULL) return;
    eui_draw_rect_box(c,x,y,x+len,y+h,EUI_MODE_SET);
    if (state) {
        eui_draw_rect_fill(c,x+2,y+2,x+len-2,y+h-2,EUI_MODE_SET);
    }
}

void ESGUI_WidgetCheckBoxRound(Canvas *c,int x,int y,eui_uint8_t r,bool state) {
    if (c == ESGUI_NULL) return;
    eui_draw_circle_box(c,x,y,r,EUI_MODE_SET);
    if (state) {
        eui_draw_circle_fill(c,x,y,r - 2,EUI_MODE_SET);
    }
}

bool ESGUI_WidgetCheckMarker(const char *raw,char marker,eui_uint16_t *out_len,char *out_ch)
{
    if (raw == ESGUI_NULL) {
        if (out_len) *out_len = 0;
        if (out_ch) *out_ch = '\0';
        return 0;
    }
    size_t len = strlen(raw);
    if (len >= 3 && raw[len - 3] == marker && raw[len - 2] == '/') {
        if (out_len) *out_len = len - 3;
        if (out_ch)  *out_ch  = raw[len - 1];
        return 1;
    }
    if (out_len) *out_len = len;
    if (out_ch)  *out_ch  = '\0';
    return 0;
}

void ESGUI_WidgetBmpFocusBox(Canvas *c, int x, int y, eui_uint16_t w, eui_uint16_t h) {
    if (c == ESGUI_NULL || w == 0 || h == 0) return;
    int x_f = x - 2;
    int y_f = y - 2;
    int x_r = x + w + 1;
    int y_b = y + h + 1;
    eui_int16_t len = (eui_int16_t)(w + 4 - 10) / 2;
    if (len < 3) len = 3;
    if (len > (eui_int16_t)(w + 4) / 2) len = (eui_int16_t)(w + 4) / 2;
    eui_int16_t h_f = (eui_int16_t)(h + 4 - 10) / 2;
    if (h_f < 3) h_f = 3;
    if (h_f > (eui_int16_t)(h + 4) / 2) h_f = (eui_int16_t)(h + 4) / 2;
    eui_draw_hline(c, x_f, x_f + len, y_f, EUI_MODE_SET);
    eui_draw_vline(c, x_f, y_f, y_f + h_f, EUI_MODE_SET);
    eui_draw_hline(c, x_r - len, x_r, y_f, EUI_MODE_SET);
    eui_draw_vline(c, x_r, y_f, y_f + h_f, EUI_MODE_SET);
    eui_draw_hline(c, x_f, x_f + len, y_b, EUI_MODE_SET);
    eui_draw_vline(c, x_f, y_b - h_f, y_b, EUI_MODE_SET);
    eui_draw_hline(c, x_r - len, x_r, y_b, EUI_MODE_SET);
    eui_draw_vline(c, x_r, y_b - h_f, y_b, EUI_MODE_SET);
}

void ESGUI_WidgetBmpFocusBoxAnim(Canvas *c, int x, int y, eui_uint16_t box_w, eui_uint16_t box_h) {
    if (c == ESGUI_NULL || box_w < 8 || box_h < 8) return;
    int x0 = x;
    int y0 = y;
    int x1 = x0 + (int)box_w - 1;
    int y1 = y0 + (int)box_h - 1;
    eui_int16_t len = (eui_int16_t)box_w / 4;
    if (len < 3) len = 3;
    if (len > (eui_int16_t)(box_w / 2) - 2) len = (eui_int16_t)(box_w / 2) - 2;
    eui_int16_t h_f = (eui_int16_t)box_h / 4;
    if (h_f < 3) h_f = 3;
    if (h_f > (eui_int16_t)(box_h / 2) - 2) h_f = (eui_int16_t)(box_h / 2) - 2;
    if (len <= 0 || h_f <= 0) return;
    eui_draw_hline(c, x0, x0 + len, y0, EUI_MODE_SET);
    eui_draw_vline(c, x0, y0, y0 + h_f, EUI_MODE_SET);
    eui_draw_hline(c, x1 - len, x1, y0, EUI_MODE_SET);
    eui_draw_vline(c, x1, y0, y0 + h_f, EUI_MODE_SET);
    eui_draw_hline(c, x0, x0 + len, y1, EUI_MODE_SET);
    eui_draw_vline(c, x0, y1 - h_f, y1, EUI_MODE_SET);
    eui_draw_hline(c, x1 - len, x1, y1, EUI_MODE_SET);
    eui_draw_vline(c, x1, y1 - h_f, y1, EUI_MODE_SET);
}