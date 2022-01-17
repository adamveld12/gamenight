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
ENV PGID=1000
ENV PUID=1000

ENV LD_LIBRARY_PATH=/games/${APPID}/linux64:$LD_LIBRARY_PATH

COPY --from=download /games/${APPID}/ /games/${APPID}/
COPY  ./run.sh /games/${APPID}/

WORKDIR /data

VOLUME /data

EXPOSE 2456/udp 2457/udp

ENTRYPOINT /games/${APPID}/run.sh
