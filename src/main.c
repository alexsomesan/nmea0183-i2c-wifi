#include <stdio.h>
#include "esp_log.h"
#include "driver/i2c.h"
#include "sdkconfig.h"
#include "string.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event.h"
#include "nvs_flash.h"

#include "lwip/err.h"
#include "lwip/sys.h"

#define SENT_BUF_SZ 40

#define DATA_LENGTH 128
#define I2C_ADDR 0x3F
#define I2C_SLAVE_TX_BUF_LEN (2 * DATA_LENGTH) /*!< I2C slave tx buffer size */
#define I2C_SLAVE_RX_BUF_LEN (2 * DATA_LENGTH) /*!< I2C slave rx buffer size */

#define EXAMPLE_ESP_WIFI_SSID      ""
#define EXAMPLE_ESP_WIFI_PASS      ""
#define EXAMPLE_ESP_MAXIMUM_RETRY  1000

#define WIFI_CONNECTED_BIT BIT0
#define WIFI_FAIL_BIT      BIT1

static int s_retry_num = 0;
static EventGroupHandle_t s_wifi_event_group;

static const char *TAG = "i2c-nmea0183-wifi";

static void i2c_slave_init(void) {
    i2c_config_t i2cSlave;

    i2cSlave.mode = I2C_MODE_SLAVE;
    i2cSlave.slave.slave_addr = I2C_ADDR;
    i2cSlave.slave.addr_10bit_en = 0;
    i2cSlave.scl_io_num = 19;
    i2cSlave.sda_io_num = 18;
    i2cSlave.sda_pullup_en = GPIO_PULLUP_DISABLE;
    i2cSlave.scl_pullup_en = GPIO_PULLUP_DISABLE;
    
    if (i2c_param_config(I2C_NUM_0, &i2cSlave) != ESP_OK) {
        ESP_LOGE(TAG, "Failed to configure I2C slave.\n");
    }
    if (i2c_driver_install(I2C_NUM_0, I2C_MODE_SLAVE, I2C_SLAVE_RX_BUF_LEN, I2C_SLAVE_TX_BUF_LEN, 0) != ESP_OK) {
        ESP_LOGE(TAG, "Failed to install I2C driver.\n");
    }
    if (i2c_reset_rx_fifo(I2C_NUM_0) != ESP_OK) {
        ESP_LOGE(TAG, "Failed to reset I2C EX FIFO.\n");
    }
    if (i2c_reset_rx_fifo(I2C_NUM_0) != ESP_OK) {
        ESP_LOGE(TAG, "Failed to reset I2C RX FIFO.\n");
    }
    if (i2c_reset_tx_fifo(I2C_NUM_0) != ESP_OK) {
        ESP_LOGE(TAG, "Failed to reset I2C TX FIFO.\n");
    }
    if (i2c_filter_enable(I2C_NUM_0, 6)  != ESP_OK) {
        ESP_LOGE(TAG, "Failed to I2C SCL filtering.\n");
    }
    ESP_LOGI(TAG, "I2C slave started.\n");
}

uint8_t getChecksum(char* str)
{
    uint8_t cs = 0;
    for (unsigned int n = 1; n < strlen(str) - 1; n++) {
        cs ^= str[n];
    }
    return cs;
}

char* NMEA0183WindSentence(char* buf, uint16_t dir, uint mph) {
    memset(buf, 0, SENT_BUF_SZ);
    sprintf(buf, "$WIMWV,%d,R,%.1f,N,A*", dir, mph / 1.15f / 10);
    uint8_t cs = getChecksum(buf);
    sprintf(buf + strlen(buf), "%02X\r\n", cs);
    return buf;
}

static void event_handler(void* arg, esp_event_base_t event_base,
                                int32_t event_id, void* event_data)
{
    if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_START) {
        esp_wifi_connect();
    } else if (event_base == WIFI_EVENT && event_id == WIFI_EVENT_STA_DISCONNECTED) {
        if (s_retry_num < EXAMPLE_ESP_MAXIMUM_RETRY) {
            esp_wifi_connect();
            s_retry_num++;
            ESP_LOGI(TAG, "retry to connect to the AP");
        } else {
            xEventGroupSetBits(s_wifi_event_group, WIFI_FAIL_BIT);
        }
        ESP_LOGI(TAG,"connect to the AP fail");
    } else if (event_base == IP_EVENT && event_id == IP_EVENT_STA_GOT_IP) {
        ip_event_got_ip_t* event = (ip_event_got_ip_t*) event_data;
        ESP_LOGI(TAG, "got ip:%s",
                 ip4addr_ntoa(&event->ip_info.ip));
        s_retry_num = 0;
        xEventGroupSetBits(s_wifi_event_group, WIFI_CONNECTED_BIT);
    }
}

void wifi_init_sta()
{
    s_wifi_event_group = xEventGroupCreate();

    tcpip_adapter_init();

    ESP_ERROR_CHECK(esp_event_loop_create_default());

    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));

    ESP_ERROR_CHECK(esp_event_handler_register(WIFI_EVENT, ESP_EVENT_ANY_ID, &event_handler, NULL));
    ESP_ERROR_CHECK(esp_event_handler_register(IP_EVENT, IP_EVENT_STA_GOT_IP, &event_handler, NULL));

    wifi_config_t wifi_config = {
        .sta = {
            .ssid = EXAMPLE_ESP_WIFI_SSID,
            .password = EXAMPLE_ESP_WIFI_PASS,
            .pmf_cfg = {
                .capable = true,
                .required = false
            },
        },
    };
    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA) );
    ESP_ERROR_CHECK(esp_wifi_set_config(ESP_IF_WIFI_STA, &wifi_config) );
    ESP_ERROR_CHECK(esp_wifi_start() );

    ESP_LOGI(TAG, "wifi_init_sta finished.");

    /* Waiting until either the connection is established (WIFI_CONNECTED_BIT) or connection failed for the maximum
     * number of re-tries (WIFI_FAIL_BIT). The bits are set by event_handler() (see above) */
    EventBits_t bits = xEventGroupWaitBits(s_wifi_event_group,
            WIFI_CONNECTED_BIT | WIFI_FAIL_BIT,
            pdFALSE,
            pdFALSE,
            portMAX_DELAY);

    /* xEventGroupWaitBits() returns the bits before the call returned, hence we can test which event actually
     * happened. */
    if (bits & WIFI_CONNECTED_BIT) {
        ESP_LOGI(TAG, "connected to ap SSID:%s password:%s",
                 EXAMPLE_ESP_WIFI_SSID, EXAMPLE_ESP_WIFI_PASS);
    } else if (bits & WIFI_FAIL_BIT) {
        ESP_LOGI(TAG, "Failed to connect to SSID:%s, password:%s",
                 EXAMPLE_ESP_WIFI_SSID, EXAMPLE_ESP_WIFI_PASS);
    } else {
        ESP_LOGE(TAG, "UNEXPECTED EVENT");
    }

    ESP_ERROR_CHECK(esp_event_handler_unregister(IP_EVENT, IP_EVENT_STA_GOT_IP, &event_handler));
    ESP_ERROR_CHECK(esp_event_handler_unregister(WIFI_EVENT, ESP_EVENT_ANY_ID, &event_handler));
    vEventGroupDelete(s_wifi_event_group);
}

void app_main() {
    char nmeastr[SENT_BUF_SZ];
    uint8_t i2cdata[5];

    //Initialize NVS
    esp_err_t ret = nvs_flash_init();
    if (ret == ESP_ERR_NVS_NO_FREE_PAGES || ret == ESP_ERR_NVS_NEW_VERSION_FOUND) {
      ESP_ERROR_CHECK(nvs_flash_erase());
      ret = nvs_flash_init();
    }
    ESP_ERROR_CHECK(ret);

    ESP_LOGI(TAG, "ESP_WIFI_MODE_STA");
    wifi_init_sta();

    i2c_slave_init();
    while(1) {
        int i2cLen= i2c_slave_read_buffer(I2C_NUM_0, i2cdata, 5, 1000 / portTICK_PERIOD_MS);
        if (i2cLen != ESP_FAIL) {
            NMEA0183WindSentence(nmeastr, 
            (uint16_t)(i2cdata[0] << 8 | i2cdata[1]),
            i2cdata[3]);
            printf(nmeastr);
        } else
            ESP_LOGE(TAG, "Failed to read from I2C!");
    }
}