#include "esp_log.h"
#include "sdkconfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"

#include "nmea.h"

extern const char *TAG;

void vTaskNMEASend( void * xQueue  ) {
    QueueHandle_t xNMEAQueue = (QueueHandle_t)xQueue;

    char nmeastr[SENT_BUF_SZ];

    for(;;) {    
        if( xQueueGenericReceive(xNMEAQueue, nmeastr, 10 / portTICK_PERIOD_MS, pdFALSE) != pdPASS ) {
            continue;
        }

        ESP_LOGI(TAG, "NMEA message: %s",nmeastr);
    }
}