FROM arm32v7/debian:10-slim

RUN apt-get update && apt-get install -y \
  libmosquittopp-dev \
  libsystemd-dev \
  --no-install-recommends

#RUN apt-get -y install wiringpi

RUN mkdir /home/knx
COPY . /home/knx/
WORKDIR /home/knx
RUN ls -al
RUN ./make
RUN ls -al
