FROM gamenight/steamcmd:1.2.0

ENV APPID=896660
ENV LD_LIBRARY_PATH=/games/${APPID}/linux64:$LD_LIBRARY_PATH

RUN /home/steam/install.sh

USER root

RUN useradd -m -s /bin/bash -g steam valheim \
    && echo "valheim:valheim" | chpasswd \
    && rm -rf /data/* \
    && mkdir -p /data \
    && chown -R valheim:steam /data /games

USER valheim

COPY --chown=valheim:steam ./run.sh /home/valheim

WORKDIR /games/${APPID}/

VOLUME ["/data"]

EXPOSE 2456/udp 2457/udp


ENTRYPOINT [ "/home/valheim/run.sh" ]
