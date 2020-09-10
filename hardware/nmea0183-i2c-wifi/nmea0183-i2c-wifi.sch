EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L RF_Module:ESP32-WROOM-32D U1
U 1 1 5F56873D
P 4850 3850
F 0 "U1" H 4850 3850 50  0000 C CNN
F 1 "ESP32-WROOM-32D" H 5300 2500 50  0000 C CNN
F 2 "RF_Module:ESP32-WROOM-32" H 4850 2350 50  0001 C CNN
F 3 "https://www.espressif.com/sites/default/files/documentation/esp32-wroom-32d_esp32-wroom-32u_datasheet_en.pdf" H 4550 3900 50  0001 C CNN
	1    4850 3850
	1    0    0    -1  
$EndComp
$Comp
L Logic_LevelTranslator:TXS0108EPW U2
U 1 1 5F56976D
P 8900 3850
F 0 "U2" H 8900 3850 50  0000 C CNN
F 1 "TXS0108EPW" H 9200 3200 50  0000 C CNN
F 2 "Package_SO:TSSOP-20_4.4x6.5mm_P0.65mm" H 8900 3100 50  0001 C CNN
F 3 "www.ti.com/lit/ds/symlink/txs0108e.pdf" H 8900 3750 50  0001 C CNN
	1    8900 3850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR013
U 1 1 5F56B058
P 8900 4950
F 0 "#PWR013" H 8900 4700 50  0001 C CNN
F 1 "GND" H 8905 4777 50  0000 C CNN
F 2 "" H 8900 4950 50  0001 C CNN
F 3 "" H 8900 4950 50  0001 C CNN
	1    8900 4950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR010
U 1 1 5F56B63C
P 4850 5550
F 0 "#PWR010" H 4850 5300 50  0001 C CNN
F 1 "GND" H 4855 5377 50  0000 C CNN
F 2 "" H 4850 5550 50  0001 C CNN
F 3 "" H 4850 5550 50  0001 C CNN
	1    4850 5550
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR012
U 1 1 5F56BE0F
P 8800 3000
F 0 "#PWR012" H 8800 2850 50  0001 C CNN
F 1 "+3.3V" H 8815 3173 50  0000 C CNN
F 2 "" H 8800 3000 50  0001 C CNN
F 3 "" H 8800 3000 50  0001 C CNN
	1    8800 3000
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR09
U 1 1 5F56CDD7
P 4850 2150
F 0 "#PWR09" H 4850 2000 50  0001 C CNN
F 1 "+3.3V" H 4865 2323 50  0000 C CNN
F 2 "" H 4850 2150 50  0001 C CNN
F 3 "" H 4850 2150 50  0001 C CNN
	1    4850 2150
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR014
U 1 1 5F56D5FA
P 9000 3000
F 0 "#PWR014" H 9000 2850 50  0001 C CNN
F 1 "+5V" H 9015 3173 50  0000 C CNN
F 2 "" H 9000 3000 50  0001 C CNN
F 3 "" H 9000 3000 50  0001 C CNN
	1    9000 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8800 3000 8800 3150
Text GLabel 5600 4050 2    50   Input ~ 0
SDA_LV
Text GLabel 5600 4150 2    50   Input ~ 0
SCL_LV
Wire Wire Line
	5600 4150 5450 4150
Wire Wire Line
	5450 4050 5600 4050
Wire Wire Line
	4850 2450 4850 2150
Wire Wire Line
	4850 5550 4850 5250
Text GLabel 8350 3550 0    50   Input ~ 0
SDA_LV
Text GLabel 8350 3650 0    50   Input ~ 0
SCL_LV
Text GLabel 9450 3550 2    50   Input ~ 0
SDA_HV
Text GLabel 9450 3650 2    50   Input ~ 0
SCL_HV
$Comp
L Connector:Conn_01x04_Male J1
U 1 1 5F573CCF
P 850 1200
F 0 "J1" H 958 1481 50  0000 C CNN
F 1 "Conn_01x04_Male" H 958 1390 50  0001 C CNN
F 2 "Connector_JST:JST_XH_B4B-XH-AM_1x04_P2.50mm_Vertical" H 850 1200 50  0001 C CNN
F 3 "~" H 850 1200 50  0001 C CNN
	1    850  1200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5F5760FC
P 1300 1100
F 0 "#PWR03" H 1300 850 50  0001 C CNN
F 1 "GND" H 1400 1100 50  0000 C CNN
F 2 "" H 1300 1100 50  0001 C CNN
F 3 "" H 1300 1100 50  0001 C CNN
	1    1300 1100
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR02
U 1 1 5F576BAC
P 1550 1000
F 0 "#PWR02" H 1550 850 50  0001 C CNN
F 1 "+12V" H 1565 1173 50  0000 C CNN
F 2 "" H 1550 1000 50  0001 C CNN
F 3 "" H 1550 1000 50  0001 C CNN
	1    1550 1000
	1    0    0    -1  
$EndComp
Text GLabel 1250 1300 2    50   Input ~ 0
SDA_HV
Text GLabel 1250 1400 2    50   Input ~ 0
SCL_HV
$Comp
L Connector:Conn_01x04_Male J2
U 1 1 5F57B4E4
P 2100 1100
F 0 "J2" H 2208 1381 50  0000 C CNN
F 1 "Prog" H 2200 800 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x04_P2.54mm_Vertical" H 2100 1100 50  0001 C CNN
F 3 "~" H 2100 1100 50  0001 C CNN
	1    2100 1100
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5F57C489
P 2850 1200
F 0 "#PWR05" H 2850 950 50  0001 C CNN
F 1 "GND" H 2855 1027 50  0000 C CNN
F 2 "" H 2850 1200 50  0001 C CNN
F 3 "" H 2850 1200 50  0001 C CNN
	1    2850 1200
	1    0    0    -1  
$EndComp
Text GLabel 2450 1100 2    50   Input ~ 0
BOOT
Text GLabel 2450 1300 2    50   Input ~ 0
TX
Text GLabel 2450 1200 2    50   Input ~ 0
RX
Text GLabel 5600 2750 2    50   Input ~ 0
TX
Text GLabel 5600 2950 2    50   Input ~ 0
RX
Wire Wire Line
	5600 2750 5450 2750
Wire Wire Line
	5600 2950 5450 2950
$Comp
L Regulator_Switching:LM2596T-5 U3
U 1 1 5F5926F0
P 2200 6900
F 0 "U3" H 2200 7000 50  0000 C CNN
F 1 "LM2596T-5" H 2200 7150 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-5_P3.4x3.7mm_StaggerOdd_Lead3.8mm_Vertical" H 2250 6650 50  0001 L CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm2596.pdf" H 2200 6900 50  0001 C CNN
	1    2200 6900
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR01
U 1 1 5F594506
P 1200 6700
F 0 "#PWR01" H 1200 6550 50  0001 C CNN
F 1 "+12V" H 1215 6873 50  0000 C CNN
F 2 "" H 1200 6700 50  0001 C CNN
F 3 "" H 1200 6700 50  0001 C CNN
	1    1200 6700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR04
U 1 1 5F595800
P 2200 7450
F 0 "#PWR04" H 2200 7200 50  0001 C CNN
F 1 "GND" H 2205 7277 50  0000 C CNN
F 2 "" H 2200 7450 50  0001 C CNN
F 3 "" H 2200 7450 50  0001 C CNN
	1    2200 7450
	1    0    0    -1  
$EndComp
$Comp
L Device:CP Cin1
U 1 1 5F5995D3
P 1200 7000
F 0 "Cin1" H 1318 7046 50  0000 L CNN
F 1 "680 uF" H 1318 6955 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D10.0mm_P5.00mm" H 1238 6850 50  0001 C CNN
F 3 "~" H 1200 7000 50  0001 C CNN
	1    1200 7000
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N5822 D1
U 1 1 5F59D801
P 2950 7200
F 0 "D1" V 2900 7000 50  0000 L CNN
F 1 "1N5822" V 3000 6850 50  0000 L CNN
F 2 "Diode_THT:D_DO-201AD_P15.24mm_Horizontal" H 2950 7025 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88526/1n5820.pdf" H 2950 7200 50  0001 C CNN
	1    2950 7200
	0    1    1    0   
$EndComp
Wire Wire Line
	2700 7000 2950 7000
Wire Wire Line
	2950 7000 2950 7050
$Comp
L Device:CP C2
U 1 1 5F5A2512
P 3750 7200
F 0 "C2" H 3868 7246 50  0000 L CNN
F 1 "220 uF" H 3868 7155 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 3788 7050 50  0001 C CNN
F 3 "~" H 3750 7200 50  0001 C CNN
	1    3750 7200
	1    0    0    -1  
$EndComp
$Comp
L Device:L L1
U 1 1 5F5A3B69
P 3300 7000
F 0 "L1" V 3250 7000 50  0000 C CNN
F 1 "33 uH" V 3400 7000 50  0000 C CNN
F 2 "Inductor_THT:L_Radial_D9.5mm_P5.00mm_Fastron_07HVP" H 3300 7000 50  0001 C CNN
F 3 "~" H 3300 7000 50  0001 C CNN
	1    3300 7000
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR06
U 1 1 5F5AB535
P 3750 6800
F 0 "#PWR06" H 3750 6650 50  0001 C CNN
F 1 "+5V" H 3765 6973 50  0000 C CNN
F 2 "" H 3750 6800 50  0001 C CNN
F 3 "" H 3750 6800 50  0001 C CNN
	1    3750 6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 7150 1200 7400
Wire Wire Line
	1200 7400 1600 7400
Wire Wire Line
	3750 7400 3750 7350
Wire Wire Line
	2950 7350 2950 7400
Connection ~ 2950 7400
Wire Wire Line
	2950 7400 3750 7400
Wire Wire Line
	2200 7450 2200 7400
Connection ~ 2200 7400
Wire Wire Line
	2200 7400 2950 7400
Wire Wire Line
	2950 7000 3150 7000
Connection ~ 2950 7000
Wire Wire Line
	3450 7000 3600 7000
Wire Wire Line
	3750 7000 3750 7050
Wire Wire Line
	3750 6800 3750 7000
Connection ~ 3750 7000
Wire Wire Line
	2700 6800 3600 6800
Wire Wire Line
	3600 6800 3600 7000
Connection ~ 3600 7000
Wire Wire Line
	3600 7000 3750 7000
$Comp
L Regulator_Linear:AMS1117-3.3 U4
U 1 1 5F5C7942
P 5200 7050
F 0 "U4" H 5350 6900 50  0000 C CNN
F 1 "AMS1117-3.3" H 5200 7201 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 5200 7250 50  0001 C CNN
F 3 "http://www.advanced-monolithic.com/pdf/ds1117.pdf" H 5300 6800 50  0001 C CNN
	1    5200 7050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR07
U 1 1 5F5C8CBE
P 4650 6800
F 0 "#PWR07" H 4650 6650 50  0001 C CNN
F 1 "+5V" H 4665 6973 50  0000 C CNN
F 2 "" H 4650 6800 50  0001 C CNN
F 3 "" H 4650 6800 50  0001 C CNN
	1    4650 6800
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR08
U 1 1 5F5CB13C
P 5200 7450
F 0 "#PWR08" H 5200 7200 50  0001 C CNN
F 1 "GND" H 5205 7277 50  0000 C CNN
F 2 "" H 5200 7450 50  0001 C CNN
F 3 "" H 5200 7450 50  0001 C CNN
	1    5200 7450
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR011
U 1 1 5F5CD66C
P 5700 6800
F 0 "#PWR011" H 5700 6650 50  0001 C CNN
F 1 "+3.3V" H 5715 6973 50  0000 C CNN
F 2 "" H 5700 6800 50  0001 C CNN
F 3 "" H 5700 6800 50  0001 C CNN
	1    5700 6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	5500 7050 5700 7050
Wire Wire Line
	5700 7050 5700 6800
$Comp
L Device:CP C4
U 1 1 5F5D4224
P 5700 7250
F 0 "C4" H 5750 7350 50  0000 L CNN
F 1 "10 uF" H 5800 7150 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D4.0mm_P2.00mm" H 5738 7100 50  0001 C CNN
F 3 "~" H 5700 7250 50  0001 C CNN
	1    5700 7250
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C3
U 1 1 5F5D4566
P 4650 7250
F 0 "C3" H 4700 7350 50  0000 L CNN
F 1 "10 uF" H 4750 7150 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D4.0mm_P2.00mm" H 4688 7100 50  0001 C CNN
F 3 "~" H 4650 7250 50  0001 C CNN
	1    4650 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 7100 5700 7050
Connection ~ 5700 7050
Wire Wire Line
	5700 7400 5200 7400
Connection ~ 5200 7400
Wire Wire Line
	5200 7400 5200 7350
Wire Wire Line
	4650 7400 5200 7400
$Comp
L Device:C C5
U 1 1 5F5DE4CE
P 6150 7250
F 0 "C5" H 6200 7350 50  0000 L CNN
F 1 "0.1 nF" H 6200 7150 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 6188 7100 50  0001 C CNN
F 3 "~" H 6150 7250 50  0001 C CNN
	1    6150 7250
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5F5DF509
P 4300 7250
F 0 "C1" H 4350 7350 50  0000 L CNN
F 1 "0.1 nF" H 4350 7150 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4338 7100 50  0001 C CNN
F 3 "~" H 4300 7250 50  0001 C CNN
	1    4300 7250
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 7400 5700 7400
Connection ~ 5700 7400
Wire Wire Line
	6150 7100 6150 7050
Wire Wire Line
	6150 7050 5700 7050
Wire Wire Line
	4300 7400 4650 7400
Connection ~ 4650 7400
Wire Wire Line
	4300 7050 4300 7100
Wire Wire Line
	5200 7450 5200 7400
NoConn ~ 5450 2850
NoConn ~ 5450 3050
Text GLabel 5600 2650 2    50   Input ~ 0
BOOT
Wire Wire Line
	5600 2650 5450 2650
NoConn ~ 5450 3150
NoConn ~ 5450 3250
NoConn ~ 5450 3350
NoConn ~ 5450 3450
NoConn ~ 5450 3550
NoConn ~ 5450 3650
NoConn ~ 5450 3750
NoConn ~ 5450 3850
NoConn ~ 5450 3950
NoConn ~ 5450 4250
NoConn ~ 5450 4350
NoConn ~ 5450 4450
NoConn ~ 5450 4550
NoConn ~ 5450 4650
NoConn ~ 5450 4750
NoConn ~ 5450 4850
NoConn ~ 5450 4950
NoConn ~ 4250 4350
NoConn ~ 4250 4250
NoConn ~ 4250 4150
NoConn ~ 4250 4050
NoConn ~ 4250 3950
NoConn ~ 4250 3850
NoConn ~ 4250 2950
NoConn ~ 4250 2850
NoConn ~ 4250 2650
NoConn ~ 8500 3450
Wire Wire Line
	2200 7200 2200 7400
Wire Wire Line
	9000 3150 9000 3000
Wire Wire Line
	1200 6700 1200 6800
Wire Wire Line
	1700 6800 1200 6800
Connection ~ 1200 6800
Wire Wire Line
	1200 6800 1200 6850
Wire Wire Line
	1700 7000 1600 7000
Wire Wire Line
	1600 7000 1600 7400
Connection ~ 1600 7400
Wire Wire Line
	1600 7400 2200 7400
Wire Wire Line
	4900 7050 4650 7050
Wire Wire Line
	4650 7050 4650 6800
Wire Wire Line
	4300 7050 4650 7050
Connection ~ 4650 7050
Wire Wire Line
	4650 7100 4650 7050
Wire Wire Line
	9450 3550 9300 3550
Wire Wire Line
	9450 3650 9300 3650
Wire Wire Line
	8500 3650 8350 3650
Wire Wire Line
	8350 3550 8500 3550
Wire Wire Line
	1050 1100 1300 1100
Wire Wire Line
	1050 1200 1550 1200
Wire Wire Line
	1550 1200 1550 1000
Wire Wire Line
	1050 1300 1250 1300
Wire Wire Line
	1250 1400 1050 1400
Wire Wire Line
	2300 1000 2850 1000
Wire Wire Line
	2850 1000 2850 1200
Wire Wire Line
	2450 1100 2300 1100
Wire Wire Line
	2450 1200 2300 1200
Wire Wire Line
	2300 1300 2450 1300
Wire Wire Line
	8900 4550 8900 4750
Wire Wire Line
	8900 4750 9700 4750
Wire Wire Line
	9700 4250 9300 4250
Connection ~ 8900 4750
Wire Wire Line
	8900 4750 8900 4950
Wire Wire Line
	8900 4750 8250 4750
Wire Wire Line
	8250 4250 8500 4250
Wire Wire Line
	8250 4150 8500 4150
Wire Wire Line
	8250 4150 8250 4250
Connection ~ 8250 4250
Wire Wire Line
	8250 4250 8250 4750
Wire Wire Line
	8250 4050 8500 4050
Connection ~ 8250 4150
Wire Wire Line
	8250 4150 8250 4050
Wire Wire Line
	8250 3950 8500 3950
Connection ~ 8250 4050
Wire Wire Line
	8250 4050 8250 3950
Wire Wire Line
	8250 3850 8500 3850
Connection ~ 8250 3950
Wire Wire Line
	8250 3950 8250 3850
Wire Wire Line
	8250 3750 8500 3750
Connection ~ 8250 3850
Wire Wire Line
	8250 3850 8250 3750
Wire Wire Line
	9700 4150 9300 4150
Wire Wire Line
	9700 4150 9700 4250
Connection ~ 9700 4250
Wire Wire Line
	9700 4250 9700 4750
Wire Wire Line
	9700 4050 9300 4050
Connection ~ 9700 4150
Wire Wire Line
	9700 4150 9700 4050
Wire Wire Line
	9700 3950 9300 3950
Connection ~ 9700 4050
Wire Wire Line
	9700 4050 9700 3950
Wire Wire Line
	9700 3850 9300 3850
Connection ~ 9700 3950
Wire Wire Line
	9700 3950 9700 3850
Wire Wire Line
	9700 3750 9300 3750
Wire Wire Line
	9700 3950 9700 3850
Connection ~ 9700 3850
Wire Wire Line
	9700 3850 9700 3750
$EndSCHEMATC
