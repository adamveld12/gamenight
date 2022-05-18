FROM debian:9.6-slim

ARG VERSION=1436

ENV VERSION=${VERSION}

WORKDIR /games/terraria


ADD  https://terraria.org/api/download/pc-dedicated-server/terraria-server-${VERSION}.zip  /games/terraria.zip
COPY ./data /data
COPY ./run.sh /games/terraria/run.sh
COPY ./generate_config.sh /games/terraria/generate_config.sh

RUN apt-get update \
  && apt-get install -y unzip \
  && apt-get clean

RUN  unzip ../terraria.zip \
  && cp -R ${VERSION}/Linux/* /games/terraria \
  && rm -rf ${VERSION} terraria.zip

RUN groupadd terraria \
  && useradd -d /games/terraria -g terraria -u 1000 -o -s /bin/bash terraria \
  && mkdir -p /games/terraria /data/configs /data/saves \
  && chmod +x /games/terraria/run.sh /games/terraria/TerrariaServer.bin.* \
  && chown -cR terraria:terraria /games /data/ \
  && chmod -R u=rwx,g=rwx,o=rx /data/

#Sets the name of the world when using autocreate
ENV T_WORLD_NAME "MobyWorld"

#Sets the max number of players allowed on a server. Value must be between 1 and 255
ENV T_MAX_PLAYERS 8

#Set the server password
ENV T_PASSWORD ""

#Set the message of the day
ENV T_MOTD "Save the whales!"

#Creates a new world if none is found. World size is specified by: 1(small), 2(medium), and 3(large).
ENV T_WORLD_SIZE 2

#Sets world difficulty when using -autocreate. Options: 0(normal), 1(expert)
ENV T_DIFFICULTY 0

#Adds additional cheat protection.
ENV T_SECURE 1

#Sets the server language from its language code.  en/US = English de/DE = German it/IT = Italian fr/FR = French es/ES = Spanish ru/RU = Russian zh/Hans = Chinese pt/BR = Portuguese pl/PL = Polish
ENV T_LANG "en/US"

USER terraria

VOLUME ["/data/saves", "/data/configs"]

EXPOSE 7777

ENTRYPOINT ["/games/terraria/run.sh"]
CMD ["-config /data/configs/serverconfig.txt"]
