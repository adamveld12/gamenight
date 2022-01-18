FROM gamenight/steamcmd:latest AS download

ARG VERSION="gn-wip-local"

ENV APPID=896660
ENV STEAM_USER="anonymous"
ENV VERSION="${VERSION}"

RUN /home/steam/install.sh

FROM ubuntu:latest as server

ENV VH_SERVER_NAME="Valheim Docker"
ENV VH_WORLD="World"
ENV VH_SERVER_PASSWORD=""
ENV VH_PUBLIC="1"
ENV PGID=1000
ENV PUID=1000

ENV LD_LIBRARY_PATH=/games/valheim/linux64:$LD_LIBRARY_PATH

COPY --from=download /games/896660/ /games/valheim/
COPY  ./run.sh /games/valheim/

WORKDIR /data

VOLUME /data

EXPOSE 2456/udp 2457/udp

ENTRYPOINT /games/valheim/run.sh
