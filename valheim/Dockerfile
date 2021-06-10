FROM gamenight/steamcmd:latest AS download


ENV APPID=896660
ENV STEAM_USER="anonymous"

RUN /home/steam/install.sh

FROM debian:stable-slim

ENV VH_SERVER_NAME="Valheim Docker"
ENV VH_WORLD="World"
ENV VH_SERVER_PASSWORD=""
ENV VH_PUBLIC="1"
ENV APPID=896660

ENV LD_LIBRARY_PATH=/games/${APPID}/linux64:$LD_LIBRARY_PATH

RUN useradd -m -s /bin/bash valheim \
    && echo "valheim:valheim" | chpasswd \
    && rm -rf /data/* \
    && mkdir -p /data /games \
    && chown -R valheim:valheim /data /games

USER valheim

COPY --from=download --chown=valheim:valheim /games/${APPID}/ /games/${APPID}/
COPY --chown=valheim:valheim ./run.sh /home/valheim

WORKDIR /games/${APPID}/

VOLUME ["/data"]

EXPOSE 2456/udp 2457/udp


ENTRYPOINT [ "/home/valheim/run.sh" ]
