FROM arm32v7/debian:10-slim

RUN apt-get update && apt-get install -y \
  libmosquittopp-dev \
  libsystemd-dev \
  build-essential \
  git-core \
  --no-install-recommends

#RUN apt-get -y install wiringpi

RUN mkdir /home/knx

RUN cd /home/knx
RUN git clone git://git.drogon.net/wiringPi
RUN cd wiringPi && ./build

RUN cd /home/knx
COPY . /home/knx/
RUN make --always-make

WORKDIR /home/knx
