FROM docker.io/gamenight/steamcmd:latest AS download

ARG VERSION="gn-wip-local"

ENV APPID=1690800
ENV STEAM_USER="anonymous"
ENV VERSION="${VERSION}"

RUN /home/steam/install.sh

FROM docker.io/ubuntu:latest as server

ENV LD_LIBRARY_PATH=/games/satisfactory/linux64:/games/satisfacory/linux32

RUN apt-get update \
	&& apt-get install -y ca-certificates \
					# curl \
					# lib32gcc1 \
					# libstdc++6 \
					# libstdc++6:i386 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -u 1000 -o -s /bin/bash -d /games/satisfactory satisfactory

# Satisfactory install files
COPY --from=download \
	 --chown=satisfactory:satisfactory /games/${APPID}/* /games/satisfactory/

# Include steam api client libs
COPY --from=download \
	--chown=satisfactory:satisfactory /home/steam/Steam/linux32/* /games/satisfacory/linux32/

COPY --chown=satisfactory:satisfactory ./config/* /games/satisfactory/FactoryGame/Saved/Config/LinuxServer/

COPY --chown=satisfactory:satisfactory ./run.sh /games/satisfactory/

# VOLUME /games/satisfacory/FactoryGame/Saved

EXPOSE 7777/udp 15000/udp 15777/udp

USER satisfactory

WORKDIR /games/satisfactory

ENTRYPOINT ["/games/satisfactory/run.sh"]

CMD ["log"]
