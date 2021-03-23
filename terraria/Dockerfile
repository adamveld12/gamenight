FROM debian:9.6-slim

ARG VERSION=1353

ENV VERSION=${VERSION}

WORKDIR /games/terraria

ADD https://terraria.org/server/terraria-server-${VERSION}.zip /games/terraria.zip
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
  && mkdir -p /games/terraria /data \
  && chmod +x /games/terraria/run.sh /games/terraria/TerrariaServer.bin.* \
  && chown -cR terraria /games /data

USER terraria

VOLUME ["/data/saves", "/data/configs"]

EXPOSE 7777

ENTRYPOINT ["/games/terraria/run.sh"]
CMD ["-config ./serverconfig.txt"]
