#ifndef _I2C_TASK_H
#define _I2C_TASK_H

#define SENT_BUF_SZ 30
#define DATA_LENGTH 128
#define I2C_ADDR 0x3F
#define I2C_SLAVE_TX_BUF_LEN (2 * DATA_LENGTH) /*!< I2C slave tx buffer size */
#define I2C_SLAVE_RX_BUF_LEN (2 * DATA_LENGTH) /*!< I2C slave rx buffer size */
#define I2C_SCL_PIN 22
#define I2C_SDA_PIN 21

void vTaskI2CReceive( void * xQueue );

#endif

