# What to call the final executable
TARGET = knx-monitor

OBJS= monitorknxrf.o cc1101.o sensorKNXRF.o mosquittoClient.o

# What compiler to use
CC = g++

CFLAGS = -c -Wall -Iinclude/

LIBS = -lwiringPi -lsystemd -lmosquittopp

# Link the target with all objects and libraries
$(TARGET) : $(OBJS)
	$(CC)  -o $(TARGET) $(OBJS) $(LDFLAGS) $(LIBS)
		
$(OBJS) : monitorknxrf.cpp
	$(CC) $(CFLAGS) $< include/*.cpp
