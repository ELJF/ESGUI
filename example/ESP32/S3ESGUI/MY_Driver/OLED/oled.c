//
// Created by E_LJF on 2026/8/11.
//

#include "oled.h"
#include "freertos/FreeRTOS.h"


#if SPI_BUS_INIT_EN
static void spi_bus_init(spi_host_device_t host_id,gpio_num_t mosi,gpio_num_t scl) {
    spi_bus_config_t buscfg = {
        .mosi_io_num = mosi,
        .miso_io_num = -1,          // 半双工输出，MISO 不用
        .sclk_io_num = scl,
        .quadwp_io_num = -1,
        .quadhd_io_num = -1,
        .max_transfer_sz = 1024,    // 大于 64 字节会自动走 DMA
    };

    // SPI_DMA_CH_AUTO 让驱动自动分配 DMA 通道
    spi_bus_initialize(host_id, &buscfg, SPI_DMA_CH_AUTO);

}
#endif



#ifdef GPIO_INIT_EN
static void oled_gpio_init(OLED_T *oled) {
    gpio_config_t conf = {
        .pin_bit_mask = (1ULL << oled->res_pin)
                      | (1ULL << oled->dc_pin)
                      | (1ULL << oled->cs_pin),
        .mode = GPIO_MODE_OUTPUT,
        .pull_up_en = GPIO_PULLUP_DISABLE,
        .pull_down_en = GPIO_PULLDOWN_DISABLE,
        .intr_type = GPIO_INTR_DISABLE,
        // .hys_ctrl_mode = GPIO_HYS_SOFT_DISABLE
    };
    gpio_config(&conf);
}
#endif




esp_err_t oled_send_cmd(OLED_T *oled,uint8_t cmd)
{
    gpio_set_level(oled->dc_pin,0);
    gpio_set_level(oled->cs_pin,0);
    spi_transaction_t t = {
        .length = 8,      // 单位：bit
        .tx_buffer = &cmd,
    };
    esp_err_t ret = spi_device_transmit(oled->oled_device, &t);
    gpio_set_level(oled->cs_pin,1);
    return ret;
}



esp_err_t oled_send_dat(OLED_T *oled,uint8_t dat)
{
    gpio_set_level(oled->dc_pin,1);
    gpio_set_level(oled->cs_pin,0);
    spi_transaction_t t = {
        .length = 8,      // 单位：bit
        .tx_buffer = &dat,
    };
    esp_err_t ret = spi_device_transmit(oled->oled_device, &t);
    gpio_set_level(oled->cs_pin,1);
    return ret;
}



void oled_init(OLED_T *oled,
    uint16_t oled_w,
    uint16_t oled_h,
    spi_host_device_t spi_host_id,
    gpio_num_t scl_pin_id,
    gpio_num_t sda_pin_id,
    gpio_num_t res_pin_id,
    gpio_num_t dc_pin_id,
    gpio_num_t cs_pin_id)
{
    if (oled == NULL) {

        return;
    }


    oled->spi_host_id = spi_host_id;

    oled->oled_w = oled_w;
    oled->oled_h = oled_h;

    oled->scl_pin = scl_pin_id;
    oled->sda_pin = sda_pin_id;
    oled->res_pin = res_pin_id;
    oled->dc_pin = dc_pin_id;
    oled->cs_pin = cs_pin_id;


#if SPI_BUS_INIT_EN
    spi_bus_init(oled->spi_host_id,sda_pin_id,scl_pin_id);
#endif

#if GPIO_INIT_EN
    oled_gpio_init(oled);
#endif

    spi_device_interface_config_t devcfg = {
        .clock_speed_hz = 20 * 1000 * 1000,  // 拉满 20MHz
        .mode = 0,
        .spics_io_num = -1,
        .queue_size = 4,             // 队列深度，批量传输时设大些（如 7 或更高）
        .flags = SPI_DEVICE_HALFDUPLEX,  // 半双工
    };

    spi_bus_add_device(oled->spi_host_id, &devcfg, &oled->oled_device);


    gpio_set_level(res_pin_id, 1);
    vTaskDelay(pdMS_TO_TICKS(100));
    gpio_set_level(res_pin_id, 0);
    vTaskDelay(pdMS_TO_TICKS(100));
    gpio_set_level(res_pin_id, 1);
    vTaskDelay(pdMS_TO_TICKS(100));

#ifdef OLED_SSD1306

    // 1. 关闭显示
    oled_send_cmd(oled,0xAE);

    // 2. 设置时钟分频比/振荡器频率: 分频比=1, 振荡器频率=默认
   oled_send_cmd(oled,0xD5);
   oled_send_cmd(oled,0x80);

    // 3. 设置多路复用率(MUX Ratio): 参数 = 屏幕高度 - 1 (自适应)
   oled_send_cmd(oled,0xA8);
   oled_send_cmd(oled,(uint8_t)(oled->oled_h - 1));

    // 4. 设置显示偏移(Display Offset): 无偏移
   oled_send_cmd(oled,0xD3);
   oled_send_cmd(oled,0x00);

    // 5. 设置显示起始行(Display Start Line): 起始行 = 0
   oled_send_cmd(oled,0x40);

    // 6. 开启电荷泵 (SSD1306 必须): 0x14=启用内部升压
   oled_send_cmd(oled,0x8D);
   oled_send_cmd(oled,0x14);

    // 7. 设置内存地址模式: 0x00=水平寻址
   oled_send_cmd(oled,0x20);
   oled_send_cmd(oled,0x00);

    // 8. 设置段重映射(Segment Re-map): 0xA1=重映射 (左右翻转)
   oled_send_cmd(oled,0xA1);

    // 9. 设置 COM 扫描方向: 0xC8=反向扫描 (从下到上)
   oled_send_cmd(oled,0xC8);

    // 10. 设置 COM 引脚硬件配置 (根据屏幕高度自适应)
    //     0x02: 顺序COM引脚配置, 禁用左右重映射 (适用于32行及以下)
    //     0x12: 交替COM引脚配置, 禁用左右重映射 (适用于64行)
   oled_send_cmd(oled,0xDA);
    if (oled_h <= 32) {
       oled_send_cmd(oled,0x02);  // Sequential COM, 适用于32行及以下
    } else {
       oled_send_cmd(oled,0x12);  // Alternative COM, 适用于64行
    }

    // 11. 设置对比度(Contrast Control): 207 (范围 0-255)
   oled_send_cmd(oled,0x81);
   oled_send_cmd(oled,0xCF);

    // 12. 设置预充电周期(Pre-charge Period): 相位1=15, 相位2=1
   oled_send_cmd(oled,0xD9);
   oled_send_cmd(oled,0xF1);

    // 13. 设置 VCOMH 取消选择电平: ~0.77x Vcc
   oled_send_cmd(oled,0xDB);
   oled_send_cmd(oled,0x40);

    // 14. 禁用滚动
   oled_send_cmd(oled,0x2E);

    // 15. 输出跟随 RAM (Entire Display ON): 0xA4=跟随RAM内容
   oled_send_cmd(oled,0xA4);

    // 16. 设置正常/反向显示: 0xA6=正常显示 (非反色)
   oled_send_cmd(oled,0xA6);

    // 17. 开启显示
   oled_send_cmd(oled,0xAF);

#elif defined(OLED_SH1107)
 // 1. 关闭显示
    oled_send_cmd(oled,0xAE);

    // 2. 设置显示起始线 (SH1107 使用 0xDC, SSD1306 使用 0x40)
    oled_send_cmd(oled,0xDC);
    oled_send_cmd(oled,0x00);

    // 3. 设置对比度 (提高对比度，0x7F=127 比 0x2F=47 更亮)
    oled_send_cmd(oled,0x81);
    oled_send_cmd(oled,0x7F);

    // 4. 设置内存地址模式 (SH1107 通常使用页寻址模式 0x02)
    oled_send_cmd(oled,0x20);
    oled_send_cmd(oled,0x02);  // Page Addressing Mode

    // 5. 设置段重映射: 0xA0=正常, 0xA1=重映射
    //    根据屏幕硬件接线选择，如果显示左右镜像则改为 0xA1
    oled_send_cmd(oled,0xA0);

    // 6. 设置 COM 输出扫描方向: 0xC0=正常, 0xC8=反向
    //    根据屏幕硬件接线选择，如果显示上下颠倒则改为 0xC8
    oled_send_cmd(oled,0xC0);

    // 7. 设置多路复用率(MUX Ratio): 参数 = 屏幕高度 - 1
    //    SH1107 支持 1~128 MUX (0x00~0x7F)
    oled_send_cmd(oled,0xA8);
    oled_send_cmd(oled,(uint8_t)(oled_h - 1));

    // 8. 设置显示偏移 (根据屏幕高度自适应)
    //    SH1107 不同屏幕有不同的偏移需求：
    //    - 128x64 屏幕 (如 Adafruit FeatherWing): 通常需要 0x60 偏移
    //    - 128x128 屏幕 (如 Pimoroni): 通常偏移为 0x00
    //    用户可通过修改 OLED_SH1107_OFFSET 宏来适配自己的屏幕
    oled_send_cmd(oled,0xD3);
    oled_send_cmd(oled,(uint8_t)OLED_SH1107_OFFSET);

    // 9. 设置时钟分频比/振荡器频率 (提高频率减少闪烁)
    //    0xF0 = 1111 0000: 最高振荡器频率, 分频比=1
    oled_send_cmd(oled,0xD5);
    oled_send_cmd(oled,0xF0);

    // 10. 设置预充电周期
    oled_send_cmd(oled,0xD9);
    oled_send_cmd(oled,0x22);

    // 11. 设置 VCOMH 取消选择电平
    oled_send_cmd(oled,0xDB);
    oled_send_cmd(oled,0x35);

    // 12. 设置页地址 (SH1107 需要设置初始页地址)
    oled_send_cmd(oled,0xB0);

    // 13. 设置 COM 引脚硬件配置 (根据屏幕高度自适应)
    //     0x02: 顺序COM引脚配置 (适用于32行及以下)
    //     0x12: 交替COM引脚配置 (适用于64行及以上)
    oled_send_cmd(oled,0xDA);
    if (oled_h <= 32) {
        oled_send_cmd(oled,0x02);  // Sequential COM, 适用于32行及以下
    } else {
        oled_send_cmd(oled,0x12);  // Alternative COM, 适用于64行及以上
    }

    // 14. 设置 IREF 模式 (SH1107 特有, 0xAD 命令)
    //     0x30 = 0011 0000: 内部 IREF (参考 Zephyr RTOS 驱动)
    oled_send_cmd(oled,0xAD);
    oled_send_cmd(oled,0x30);

    // 15. 设置电荷泵 (SH1107 使用 0x8D 或 0xAD 设置 DCDC)
    oled_send_cmd(oled,0x8D);
    oled_send_cmd(oled,0x14);  // 启用电荷泵

    // 16. 设置初始列地址 (SH1107 需要设置列地址)
    oled_send_cmd(oled,0x00);  // 列地址低4位
    oled_send_cmd(oled,0x10);  // 列地址高4位

    // 17. 输出跟随 RAM
    oled_send_cmd(oled,0xA4);

    // 18. 设置正常/反向显示
    oled_send_cmd(oled,0xA6);

    // 19. 开启显示
    oled_send_cmd(oled,0xAF);
#endif
}


//将OLED显存发送到OLED屏幕上显示
// oled_obj OLED对象结构体
void OLED_Refresh(OLED_T *oled_obj,uint8_t *buf,uint16_t len) {
    if (oled_obj == NULL) {return;}

    gpio_set_level(oled_obj->cs_pin,0);

#ifdef OLED_SSD1306
    /* ============================================================
     * SSD1306 刷新方式: 水平寻址模式，一次性发送整个显存
     * 支持 DMA 模式，大数据量传输效率高
     * ============================================================ */
    gpio_set_level(oled_obj->dc_pin, 1);

    spi_transaction_t t = {
        .length = 8 * len,      // 单位：bit
        .tx_buffer = buf,
    };
    spi_device_transmit(oled_obj->oled_device, &t);

#elif defined(OLED_SH1107)
    /* ============================================================
     * SH1107 刷新方式: 页寻址模式，逐页发送
     *
     * 关键修复：
     * 1. SH1107 每页数据量小 (通常128字节)，DMA 不划算
     * 2. 命令和数据必须在同一个 CS 低电平期间发送，避免 CS 频繁切换
     * 3. 不使用 OLED_WriteCommand()，因为它会独立控制 CS
     *
     * 每页流程：
     *   CS 拉低 -> DC 命令模式 -> 发送页地址命令 (3字节)
     *   -> DC 数据模式 -> 发送该页数据 -> CS 拉高
     * ============================================================ */

    if (len == 0) {
        gpio_set_level(oled_obj->cs_pin, 1);
        return;
    }

    uint8_t col_offset = 0;  // SH1107 列偏移，某些屏幕需要 +2
    uint16_t page_bytes = oled_obj->oled_w;
    uint8_t page_num = (len + page_bytes - 1) / page_bytes;  // 向上取整

    for (uint8_t page = 0; page < page_num; page++) {
        uint16_t page_offset = page * page_bytes;
        uint16_t bytes_to_send = page_bytes;

        // 最后一页可能不足一页，按实际剩余字节数发送
        if (page_offset + bytes_to_send > len) {
            bytes_to_send = len - page_offset;
        }

        // 1. 发送命令：设置页地址 + 列地址低 + 列地址高 (3字节打包)
        gpio_set_level(oled_obj->dc_pin, 0);
        uint8_t cmd_buf[3] = {
            0xB0 | page,                                    // 页地址
            0x00 | ((col_offset + 0) & 0x0F),              // 列地址低4位
            0x10 | (((col_offset + 0) >> 4) & 0x0F)         // 列地址高4位
        };

        spi_transaction_t t = {
            .length = 8 * 3,      // 单位：bit
            .tx_buffer = cmd_buf,
        };
        spi_device_transmit(oled_obj->oled_device, &t);

        // 2. 切换为数据模式，发送该页数据（最后一页可能不足 page_bytes）
        gpio_set_level(oled_obj->dc_pin, 1);

        spi_transaction_t t_d = {
            .length = 8 * bytes_to_send,      // 单位：bit
            .tx_buffer = &buf[page_offset],
        };
        spi_device_transmit(oled_obj->oled_device, &t_d);
    }
#endif
    gpio_set_level(oled_obj->cs_pin, 1);
}


