FROM arm32v7/debian:10-slim

RUN apt-get update && apt-get install -y \
  libmosquittopp-dev \
  libsystemd-dev \
  build-essential \
  git-core \
  --no-install-recommends

WORKDIR /home/knx

#RUN git clone https://github.com/WiringPi/WiringPi.git
#RUN cd WiringPi && ./build

#COPY . /home/knx/
COPY include ./include
COPY Makefile .
COPY knx-monitor.service .
COPY monitorknxrf.cpp .
#RUN make --always-make
#RUN chmod +x knx-monitor

#COPY ./knx-monitor /home/knx/

#ENTRYPOINT ["/home/knx/knx-monitor"]
