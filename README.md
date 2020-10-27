# MonitorKNXRF
This is a fork of MonitorKNXRF where the integration with OpenHab has been removed.
Instead the sensor data will be published to a MQTT Broker

## General

This program is developed to be used on Raspberry Pi 3 together with a CC1101 radiomodule.

The program will listen to interrupts generated from the CC1101. When an interrupt is recieved the data will be stored to a variable length buffer of class SensorKNXRF.
Every 15th second the program will send the data to a configured MQTT Broker.

## Pin layout

| Raspberry pin # | Name | CC1101 |
| --: | --- | --- |
| 17 | 3.3V              | VCC |
| 18 | GPIO24            | GDO0 |
| 19 | GPIO10 (SPI_MOSI) | SI |
| 20 | Ground            | GND |
| 21 | GPIO09 (SPI_MISO) | SO |
| 22 | GPIO25            | GDO2 |
| 23 | GPIO11 (SPI_CLK)  | SCLK1 |
| 24 | GPI008 (SP_CE0_N) | CSn |

Note: GDO0 is not used in the program. which GDO for interrupts to use is specifed in the configuration of the chip, see cc1101.cpp (look for IOCFG[0..2] and the data sheet for the CC1101.

## Example

Compile the program by running make:
```
openhabian@hab:~/MonitorKNXRF$ make
```

Run the program with debug level 2:
```
./knx-monitor
```
Change set temperature on any of your thermostats, and wait a minimum 15 seconds.
Press Ctrl+C to stop the program.
Then check the log:
```
grep -in monitorknxrf /var/log/syslog
...
24447:Jan  2 12:09:00 hab knx-monitor: MonitorKNXRF is requesting data from Openhab.
24448:Jan  2 12:09:00 hab knx-monitor: MonitorKNXRF got data from sensor 007402363C12 reading 2232 and 1950.
24451:Jan  2 12:09:00 hab knx-monitor: MonitorKNXRF: marcstate: 0x01

```
In this case the actual temperature is 22.32 C and the set temperature is 19.5 C.

To make the program running as a system service you need to copy the the systemd files as this:
```
sudo cp knx-monitor /usr/bin/.
sudo cp knx-monitor.service /etc/systemd/system/.
```

Manual start / stop the service 
```
sudo systemctl start knx-monitor.service
sudo systemctl stop knx-monitor.service
sudo systemctl status knx-monitor.service
```

Have the program started on system boot
```
sudo systemctl enable knx-monitor.service
```


## MQTT Topic
 * home/uponor/<SENSOR_ID>/temperature
 * home/uponor/<SENSOR_ID>/temperature-target
 * home/uponor/<SENSOR_ID>/battery-ok
 * ome/uponor/<SENSOR_ID>/rssi