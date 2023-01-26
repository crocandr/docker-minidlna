FROM debian:10

RUN apt-get update && apt-get install -y minidlna minissdpd net-tools

COPY files/start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh

ENTRYPOINT /opt/start.sh
