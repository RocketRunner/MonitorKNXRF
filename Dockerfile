FROM arm32v7/debian:10-slim

RUN apt-get update
RUN apt-get install libmosquittopp-dev
RUN apt-get install wiringpi
RUN apt-get install libsystemd-dev

RUN mkdir /home/knx
COPY . /home/knx/

WORKDIR /home/knx
RUN make
RUN ls -al
