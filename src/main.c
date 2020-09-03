#include <stdio.h>
#include "esp_log.h"
#include "driver/i2c.h"
#include "sdkconfig.h"

#define DATA_LENGTH 128
#define I2C_ADDR 0x3F
#define I2C_SLAVE_TX_BUF_LEN (2 * DATA_LENGTH) /*!< I2C slave tx buffer size */
#define I2C_SLAVE_RX_BUF_LEN (2 * DATA_LENGTH) /*!< I2C slave rx buffer size */

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
    if (i2c_reset_rx_fifo(I2C_NUM_0) != ESP_OK){
        ESP_LOGE(TAG, "Failed to reset I2C EX FIFO.\n");
    }
    if (i2c_reset_rx_fifo(I2C_NUM_0) != ESP_OK){
        ESP_LOGE(TAG, "Failed to reset I2C RX FIFO.\n");
    }
    if (i2c_reset_tx_fifo(I2C_NUM_0) != ESP_OK){
        ESP_LOGE(TAG, "Failed to reset I2C TX FIFO.\n");
    }
    if (i2c_filter_enable(I2C_NUM_0, 6)  != ESP_OK){
        ESP_LOGE(TAG, "Failed to I2C SCL filtering.\n");
    }
    ESP_LOGI(TAG, "I2C slave started.\n");
}

void app_main() {
    uint8_t i2cdata[5];
    i2c_slave_init();
    while(1) {
        int i2cLen= i2c_slave_read_buffer(I2C_NUM_0, i2cdata, 5, 1000 / portTICK_PERIOD_MS);
        if (i2cLen != ESP_FAIL) {
            for(int i = 0; i < i2cLen; i++) {
               printf("%02X ", i2cdata[i]);
            }
            printf("\n");
        } else
            ESP_LOGE(TAG, "Failed to read from I2C!");
    }
}