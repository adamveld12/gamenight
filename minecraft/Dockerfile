FROM openjdk:8-jre-alpine3.7

ENV MINECRAFT_VERSION=1.16.4
ENV PATH=${PATH}:/usr/lib/jvm/default-java/bin
ENV JVM_MEMORY_SIZE=1024m

ADD https://launcher.mojang.com/v1/objects/35139deedbd5182953cf1caa23835da59ca3d7cd/server.jar /games/minecraft/server.jar

COPY ./run.sh /games/minecraft/
COPY ./data/ /data/
COPY ./data/configs/server.properties /data/configs/server.properties.example

WORKDIR /games/minecraft/

RUN addgroup minecraft \
    && adduser -D -G minecraft minecraft \
    && mkdir -p /games/minecraft /data \
    && chmod +x /games/minecraft/run.sh \
    && chown -cR minecraft /games /data

USER minecraft

EXPOSE 25565

VOLUME ['/data/saves', '/data/configs']

ENTRYPOINT /games/minecraft/run.sh
