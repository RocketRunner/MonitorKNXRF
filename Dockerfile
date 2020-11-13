FROM arm32v7/debian:10-slim

RUN apt-get update && apt-get install -y \
  libmosquittopp-dev \
  libsystemd-dev \
  build-essential \
  --no-install-recommends

#RUN apt-get -y install wiringpi

RUN mkdir /home/knx
COPY . /home/knx/
WORKDIR /home/knx
RUN make --always-make
