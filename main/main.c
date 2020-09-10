#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "freertos/event_groups.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "esp_log.h"
#include "wifi_manager.h"

#include "http_hook.h"
#include "i2ctask.h"
#include "nmea.h"

#define NMEA_QUEUE_DEPTH 50

const char *TAG = "nmea0183-wifi-i2c";
uint networkOn = 0;

esp_err_t my_custom_handler(httpd_req_t *);
void cb_connection_ok(void *);

void app_main() {
    TaskHandle_t xI2CReceiveHandle = NULL;
    TaskHandle_t xNMEASenderHandle = NULL;

    QueueHandle_t xNMEAQueue = xQueueCreate(
        NMEA_QUEUE_DEPTH, 
        sizeof(char) * SENT_BUF_SZ
    );
    
    wifi_manager_start();
    wifi_manager_set_callback(WM_EVENT_STA_GOT_IP, &cb_connection_ok);
    
    // http_app_set_handler_hook(HTTP_GET, &my_custom_handler);

    while(networkOn == 0) {
        vTaskDelay(portTICK_PERIOD_MS);
    }

    xTaskCreate(vTaskI2CReceive, "I2C-RECEIVER", 2048, 
        xNMEAQueue, tskIDLE_PRIORITY, &xI2CReceiveHandle);

    configASSERT( xI2CReceiveHandle );

    
    xTaskCreate(vTaskNMEASend, "NMEA-SENDER", 2048, 
        xNMEAQueue, tskIDLE_PRIORITY, &xNMEASenderHandle);

    configASSERT( xNMEASenderHandle );

    for(;;) {
        vTaskDelay(portTICK_PERIOD_MS);
    }
    ESP_LOGE(TAG, "END OF MAIN");
}

void cb_connection_ok(void *p) {
	ESP_LOGI(TAG, "I have a connection!");
    networkOn = 1;
}