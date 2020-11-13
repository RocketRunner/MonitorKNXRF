FROM arm32v7/debian:10-slim

RUN apt-get update && apt-get install -y \
  libmosquittopp-dev \
  libsystemd-dev \
  --no-install-recommends

WORKDIR /home/knx
COPY ./knx-monitor /home/knx/
RUN chmod +x knx-monitor

ENTRYPOINT ["knx-monitor"]
