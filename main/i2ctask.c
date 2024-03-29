
#include "stdio.h"
#include "esp_log.h"
#include "driver/i2c.h"
#include "sdkconfig.h"
#include "string.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "i2ctask.h"

extern const char *TAG;

static void i2c_slave_init(void) {
    i2c_config_t i2cSlave;

    i2cSlave.mode = I2C_MODE_SLAVE;
    i2cSlave.slave.slave_addr = I2C_ADDR;
    i2cSlave.slave.addr_10bit_en = 0;
    i2cSlave.scl_io_num = I2C_SCL_PIN;
    i2cSlave.sda_io_num = I2C_SDA_PIN;
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

void vTaskI2CReceive( void * xQueue ) {
    QueueHandle_t xNMEAQueue = (QueueHandle_t)xQueue;

    char nmeastr[SENT_BUF_SZ];
    uint8_t i2cdata[5];

    i2c_slave_init();

    while(1) {
        int i2cLen= i2c_slave_read_buffer(I2C_NUM_0, i2cdata, 5, 1000 / portTICK_PERIOD_MS);
        if (i2cLen == ESP_FAIL) {
            ESP_LOGE(TAG, "Failed to read from I2C!");
            continue;
        }
        if (i2cLen != 5) {
            ESP_LOGI(TAG, "Inconsistent I2C read: %d bytes, not 5", i2cLen);
            continue;
        }
        NMEA0183WindSentence(nmeastr, 
        (uint16_t)(i2cdata[0] << 8 | i2cdata[1]),
        i2cdata[3]);
        if (xQueueGenericSend(xNMEAQueue, nmeastr, 10 / portTICK_PERIOD_MS, queueSEND_TO_BACK) != pdPASS) {
            ESP_LOGE(TAG, "Failed to queue up NMEA message");
        }
    }
}
