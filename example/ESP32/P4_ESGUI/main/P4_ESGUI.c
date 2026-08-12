#include "driver/spi_master.h"
#include "freertos/FreeRTOS.h"
#include "ESGUI_Task.h"

void app_main(void)
{
    ESGUI_Task_Init();

    while (1) {
        vTaskDelay(pdMS_TO_TICKS(10000));
    }
}
