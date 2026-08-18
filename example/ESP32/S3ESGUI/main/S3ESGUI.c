// #include <stdio.h>
#include "ESGUI_Task.h"
#include "freertos/FreeRTOS.h"

void app_main(void)
{
    ESGUI_Task_Init();
    while (1) {
        vTaskDelay(pdMS_TO_TICKS(10000));
    }
}
