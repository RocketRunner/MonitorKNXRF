FROM arm32v7/debian:10-slim

RUN apt-get update
RUN apt-get -y install libmosquittopp-dev
RUN apt-get -y install wiringpi
RUN apt-get -y install libsystemd-dev

RUN mkdir /home/knx
COPY . /home/knx/

WORKDIR /home/knx
RUN make
RUN ls -al
