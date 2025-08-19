FROM debian:12

RUN apt-get update; \
    apt-get install -y minidlna minissdpd net-tools iproute2

COPY --chmod=755 files/start.sh /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]
