FROM debian:12

RUN apt-get update && apt-get install -y minidlna minissdpd net-tools iproute2

COPY files/start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh

ENTRYPOINT /opt/start.sh
