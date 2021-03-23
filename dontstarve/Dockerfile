FROM gamenight/steamcmd:1.2.0

ENV APPID=343050
ENV CLUSTER_NAME=default
ENV SHARD_NAME=Master

RUN /home/steam/install.sh

USER root

RUN apt-get update \
    && apt-get install -y libcurl4-gnutls-dev:i386 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -m -s /bin/bash -g steam dontstarve \
    && echo "dontstarve:dontstarve" | chpasswd \
    && rm -rf /data/* \
    && chown -R dontstarve:steam /data /home/dontstarve /games

USER dontstarve
WORKDIR /home/dontstarve

COPY --chown=dontstarve:steam ./data/ /data/
COPY --chown=dontstarve:steam ./run.sh /home/dontstarve/run.sh
COPY --chown=dontstarve:steam ./data/clusters/ /data/clusters/

VOLUME ["/data"]

EXPOSE 10999/udp


ENTRYPOINT [ "/home/dontstarve/run.sh", "-bind_ip 0.0.0.0", "-console"]
