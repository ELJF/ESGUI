//
// Created by E_LJF on 2026/8/11.
//

#ifndef P4_ESGUI_SSD1306_H
#define P4_ESGUI_SSD1306_H

#include "driver/spi_master.h"
#include "driver/gpio.h"

#define SPI_BUS_INIT_EN 1    //驱动是否配置SPI总线，1 配置，0 不配置，为0时用户需自己配置SPI总线
#define GPIO_INIT_EN    1    //驱动是否配置OLED用到的GPIO，1 配置，0 不配置，为0时用户需自己配置GPIO

/* ============================================================
 * 驱动芯片选择 - 注释掉不需要的驱动，只保留一个
 * 注释掉 OLED_SH1107 时，视为使用 SSD1306 驱动
 * 注释掉 OLED_SSD1306 时，视为使用 SH1107 驱动
 * ============================================================ */
// #define OLED_SSD1306
#define OLED_SH1107


#ifdef OLED_SSD1306
    // SSD1306 配置
    #define OLED_DRIVER_NAME    "SSD1306"
    #define OLED_MAX_MUX_RATIO  64
    #define OLED_CMD_START_LINE 0x40
    #define OLED_CMD_COM_PINS   0xDA
    #define OLED_MEM_MODE       0x00  // 水平寻址模式
#elif defined(OLED_SH1107)
    // SH1107 配置
    #define OLED_DRIVER_NAME    "SH1107"
    #define OLED_MAX_MUX_RATIO  128
    #define OLED_CMD_START_LINE 0xDC  // SH1107 使用 0xDC 设置起始行
    #define OLED_CMD_COM_PINS   0xDA
    #define OLED_MEM_MODE       0x02  // 页寻址模式 (SH1107 仅支持页寻址)

    /* SH1107 显示偏移配置
     * 不同厂商的 SH1107 屏幕有不同的偏移值：
     * - 128x64 屏幕 (如 Adafruit FeatherWing): 通常需要 0x60 偏移
     * - 128x128 屏幕 (如 Pimoroni): 通常偏移为 0x00
     * 如果显示内容偏移，请修改此值 */
    #define OLED_SH1107_OFFSET  0x00  // 默认 0x00，128x64 屏幕可改为 0x60
#else
    #error "请定义 OLED_SSD1306 或 OLED_SH1107 之一"
#endif



typedef struct oled_
{
    spi_host_device_t spi_host_id;
    spi_device_handle_t oled_device;

    gpio_num_t scl_pin;
    gpio_num_t sda_pin;
    gpio_num_t res_pin;
    gpio_num_t dc_pin;
    gpio_num_t cs_pin;

    uint16_t oled_w;
    uint16_t oled_h;

#ifdef OLED_SH1107
    uint16_t oled_gram_size;
#endif
}OLED_T;

esp_err_t oled_send_cmd(OLED_T *oled,uint8_t cmd);
esp_err_t oled_send_dat(OLED_T *oled,uint8_t dat);

void oled_init(OLED_T *oled,
    uint16_t oled_w,
    uint16_t oled_h,
    spi_host_device_t spi_host_id,
    gpio_num_t scl_pin_id,
    gpio_num_t sda_pin_id,
    gpio_num_t res_pin_id,
    gpio_num_t dc_pin_id,
    gpio_num_t cs_pin_id);

void OLED_Refresh(OLED_T *oled_obj,uint8_t *buf,uint16_t len);

#endif //P4_ESGUI_SSD1306_H
