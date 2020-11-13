FROM arm32v7/alpine:3.12

RUN apt-get install libsystemd-dev
RUN apt-get install wiringpi
RUN apt-get install libmosquittopp-dev

RUN mkdir /home/knx
COPY . /home/knx/

WORKDIR /home/knx
RUN make
RUN ls -al
