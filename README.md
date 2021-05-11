# NMEA0183 WiFi bridge for NASA Clipper Wind instrument

Reads wind data from a NASA Clipper wind instrument via I2C and sends out NMEA0183 wind messages via WiFi.

# Hardware needed

At the very minimum, a prototype can be assembled with just an ESP32 dev board and a 5 pin DIN plug, by connecting the I2C and power lines from the connector directly to the board. The NASA unit output 5V level I2c, but ESP32 is 5V tolerrant so a level converter is not mandatory (still nice though).

[TODO: add pinnout diagram]

```
ESP32         < --- >  NASA 5 Pin DIN connector
-----------------------------------------------
GPIO21 (SDA)  < --- >  PIN 3
GPIO22 (SCL)  < --- >  PIN 1
GND           < --- >  PIN 2
```

The hardware folder contains an untested design (KiCAD 5) for an integrted board with power regulators and level shifters, which should give the most robust solution.

# Installation

To build the code, you need to install the official Espressif SDK, as explained here: https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/#installation-step-by-step

With the ESP-IDF successfully installed, connect the ESP32 board via USB and flash it with the following command:
```
idf.py partition_table-flash flash
```

Once that completes without erros, the board is ready to use. You need to connect it to a WiFi network (e.g. and OpenPlotter WiFi network).

To setup wifi, the board starts it's own WiFi network called "nasa-clipper-wind". Connect to that and wait for the login pop-up to show up. In the pop-up window you will be able to browse available networks and connect to the network of your choice. Once setup, the board will remember this network and connect to it on startup.