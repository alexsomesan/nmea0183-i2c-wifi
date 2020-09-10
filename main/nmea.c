#include "esp_log.h"
#include "sdkconfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"

#include "nmea.h"

#include "lwip/err.h"
#include "lwip/sockets.h"
#include "lwip/sys.h"

extern const char *TAG;

void vTaskNMEASend( void * xQueue  ) {
    QueueHandle_t xNMEAQueue = (QueueHandle_t)xQueue;

    char nmeastr[SENT_BUF_SZ];

    int sock = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP);
    if (sock < 0) {
        ESP_LOGE(TAG, "Failed to create socket. Error %d", sock);
    }

    struct sockaddr_in addr;
    addr.sin_addr.s_addr = htonl(IPADDR_BROADCAST);
    addr.sin_family = AF_INET;
    addr.sin_port = htons( UDP_PORT );

    for(;;) {    
        if( xQueueGenericReceive(xNMEAQueue, nmeastr, 10 / portTICK_PERIOD_MS, pdFALSE) != pdPASS ) {
            continue;
        }

        // ESP_LOGI(TAG, "NMEA message: %s",nmeastr);
        int err = sendto(sock, nmeastr, strlen(nmeastr), 0, (const struct sockaddr *)&addr, sizeof(addr));
        if (err < 0) {
            ESP_LOGE(TAG, "Failed to send UDP");
        }
    }
}