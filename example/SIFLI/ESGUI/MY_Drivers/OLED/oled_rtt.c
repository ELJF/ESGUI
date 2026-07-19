#include "oled_rtt.h"
#include "drivers/pin.h"
#include "drivers/spi.h"
#include "rtconfig.h"
#include "rtdef.h"
#include "rtthread.h"
#include <time.h>
#include "drv_gpio.h"



rt_err_t oled_send_cmd(OLED_T *oled,rt_uint8_t cmd)
{
    rt_pin_write(oled->dc_pin_id, PIN_LOW);
    rt_pin_write(oled->cs_pin_id, PIN_LOW);
    rt_err_t ret = rt_spi_send(&oled->spi_dev, &cmd, 1);
    rt_pin_write(oled->cs_pin_id, PIN_HIGH);
    return ret;
}



rt_err_t oled_send_dat(OLED_T *oled,rt_uint8_t dat)
{
    rt_pin_write(oled->dc_pin_id, PIN_HIGH);
    rt_pin_write(oled->cs_pin_id, PIN_LOW);
    rt_err_t ret = rt_spi_send(&oled->spi_dev, &dat, 1);
    rt_pin_write(oled->cs_pin_id, PIN_HIGH);
    return ret;
}



rt_err_t oled_init(OLED_T *oled,
    const char *oled_name,
    rt_uint16_t oled_w,
    rt_uint16_t oled_h,
    const char *spi_bus_name,
    rt_base_t res_pin_id,
    rt_base_t dc_pin_id,
    rt_base_t cs_pin_id)
{
    if (oled == RT_NULL || oled_name == NULL || spi_bus_name == NULL) {

        return RT_ERROR;
    }

    oled->oled_name = oled_name;
    oled->oled_w = oled_w;
    oled->oled_h = oled_h;
    oled->res_pin_id = res_pin_id;
    oled->dc_pin_id = dc_pin_id;
    oled->cs_pin_id = cs_pin_id;

    rt_pin_mode(res_pin_id, PIN_MODE_OUTPUT);
    rt_pin_mode(dc_pin_id, PIN_MODE_OUTPUT);
    rt_pin_mode(cs_pin_id, PIN_MODE_OUTPUT);


    rt_err_t result = rt_spi_bus_attach_device(
        &oled->spi_dev,            /* 必须传入设备结构体 */
        oled_name,
        spi_bus_name,
        (void *)cs_pin_id       /* user_data 传 CS 引脚号，后续手动控制 */
    );

    if (result != RT_EOK)
    {
        return -RT_ERROR;
    }


    struct rt_spi_configuration cfg;
    cfg.data_width = 8;
    cfg.mode = RT_SPI_MASTER | RT_SPI_MODE_0 | RT_SPI_MSB;
    cfg.max_hz = 10 * 1000 * 1000;  /* 10MHz，SSD1306 SPI 最高支持 10MHz */
    
    rt_spi_configure(&oled->spi_dev, &cfg);

    #if OLED_SPI_DMA_EN == 1
    /* 关键：打开设备时传入 DMA 标志 */
    rt_err_t err = rt_device_open((rt_device_t)&oled->spi_dev, 
                                   RT_DEVICE_OFLAG_WRONLY | RT_DEVICE_FLAG_DMA_TX);
    if (err != RT_EOK)
    {
        rt_device_open((rt_device_t)&oled->spi_dev, RT_DEVICE_OFLAG_WRONLY);
    }
#else
    rt_device_open((rt_device_t)&oled->spi_dev, RT_DEVICE_OFLAG_WRONLY);
#endif




    rt_pin_write(res_pin_id, PIN_HIGH);
    rt_thread_mdelay(100);
    rt_pin_write(res_pin_id, PIN_LOW);
    rt_thread_mdelay(100);
    rt_pin_write(res_pin_id, PIN_HIGH);
    rt_thread_mdelay(100);

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

    return RT_EOK;
}


//将OLED显存发送到OLED屏幕上显示
// oled_obj OLED对象结构体
void OLED_Refresh(OLED_T *oled_obj,rt_uint8_t *buf,rt_uint16_t len) {
    if (oled_obj == NULL) {return;}

#ifdef OLED_SSD1306
    /* ============================================================
     * SSD1306 刷新方式: 水平寻址模式，一次性发送整个显存
     * 支持 DMA 模式，大数据量传输效率高
     * ============================================================ */
    rt_pin_write(oled_obj->dc_pin_id, PIN_HIGH);
    rt_pin_write(oled_obj->cs_pin_id, PIN_LOW);

    #if OLED_SPI_DMA_EN == 1
         struct rt_spi_message msg;
    msg.send_buf   = buf;
    msg.recv_buf   = RT_NULL;
    msg.length     = len;
    msg.cs_take    = 1;  /* 片选拉低 */
    msg.cs_release = 1;  /* 片选拉高 */
    msg.next       = RT_NULL;
    
    rt_spi_transfer_message(&oled_obj->spi_dev, &msg);
    #else
        rt_spi_send(&oled_obj->spi_dev, buf, len);
    #endif

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
     *   -> DC 数据模式 -> 发送该页数据 (width字节) -> CS 拉高
     * ============================================================ */

    uint8_t page_num = (oled_obj->oled_h + 7) / 8;
    uint8_t col_offset = 0;  // SH1107 列偏移，某些屏幕需要 +2

    for (uint8_t page = 0; page < page_num; page++) {
        uint16_t page_offset = page * oled_obj->oled_w;

        // 1. 发送命令：设置页地址 + 列地址低 + 列地址高 (3字节打包)
        // 减少 HAL_SPI_Transmit 调用次数，降低 HAL 层开销
        rt_pin_write(oled_obj->dc_pin_id, PIN_LOW);
        uint8_t cmd_buf[3] = {
            0xB0 | page,                                    // 页地址
            0x00 | ((col_offset + 0) & 0x0F),              // 列地址低4位
            0x10 | (((col_offset + 0) >> 4) & 0x0F)         // 列地址高4位
        };
        rt_spi_send(&oled_obj->spi_dev, cmd_buf, sizeof(cmd_buf));

        // 2. 切换为数据模式，发送该页数据
        rt_pin_write(oled_obj->dc_pin_id, PIN_HIGH);

        rt_spi_send(&oled_obj->spi_dev, &buf[page_offset], oled_obj->oled_w);
    }
#endif
    rt_pin_write(oled_obj->cs_pin_id, PIN_HIGH);
}