FROM openjdk:8-jre-alpine3.7

ENV MINECRAFT_VERSION=1.12.2
ENV PATH=${PATH}:/usr/lib/jvm/default-java/bin
ENV JVM_MEMORY_SIZE=1024m

ADD  https://launcher.mojang.com/mc/game/${MINECRAFT_VERSION}/server/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar /games/minecraft/server.jar
COPY ./run.sh /games/minecraft/
COPY ./data/ /data/
COPY ./data/configs/server.properties /data/configs/server.properties.example

WORKDIR /games/minecraft/

RUN addgroup minecraft \
    && adduser -D -G minecraft minecraft \
    && mkdir -p /games/minecraft /data \
    && chown -cR minecraft /games /data

USER minecraft

EXPOSE 25565

VOLUME ['/data/saves', '/data/configs']

ENTRYPOINT ['/games/minecraft/run.sh']
