FROM gamenight/steamcmd:latest AS download

ENV APPID=343050

RUN /home/steam/install.sh

FROM debian:stable-slim

USER root

RUN apt-get update \
    && apt-get install -y libcurl4-gnutls-dev:i386 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m -s /bin/bash dontstarve \
    && echo "dontstarve:dontstarve" | chpasswd \
    && rm -rf /data/* \
    && chown -R dontstarve:dontstarve /data /home/dontstarve /games/

ENV APPID=343050
ENV CLUSTER_NAME=default
ENV SHARD_NAME=Master

WORKDIR /home/dontstarve

USER dontstarve

COPY --chown=donstarve --from=download /games/${APPID}/ /games/${APPID}/
COPY --chown=dontstarve ./data/ /data/
COPY --chown=dontstarve ./run.sh /home/dontstarve/run.sh
COPY --chown=dontstarve ./data/clusters/ /data/clusters/

EXPOSE 10999/udp

VOLUME /data

ENTRYPOINT [ "/home/dontstarve/run.sh"]
