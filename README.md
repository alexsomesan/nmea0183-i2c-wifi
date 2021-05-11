# NMEA0183 WiFi bridge for NASA Clipper Wind instrument

Reads wind data from a NASA Clipper wind instrument via I2C and sends out NMEA0183 wind messages via WiFi.

# Hardware needed

At the very minimum, a prototype can be assembled with just an ESP32 dev board and a 5 pin DIN plug, by connecting the I2C and power lines from the connector directly to the board. The NASA unit output 5V level I2c, but ESP32 is 5V tolerrant so a level converter is not mandatory (still nice though). [TODO: add pinnout diagram]

The hardware folder contains an untested design (KiCAD 5) for an integrted board with power regulators and level shifters, which should give the most robust solution.