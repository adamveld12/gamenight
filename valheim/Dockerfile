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

ENV LD_LIBRARY_PATH=/games/valheim/linux64

RUN useradd -u 1000 -o -s /bin/bash -d /data valheim

COPY --from=download \
	 --chown=valheim:valheim /games/896660/ /games/valheim/

COPY --chown=valheim:valheim ./run.sh /games/valheim/


VOLUME /data

EXPOSE 2456/udp 2457/udp

USER valheim

WORKDIR /data

ENTRYPOINT ["/games/valheim/run.sh"]
