FROM openjdk:17-alpine

ARG VERSION=1.18.1

ARG MINECRAFT_VERSION_HASH=125e5adf40c659fd3bce3e66e67a16bb49ecc1b9
ENV VERSION=${VERSION}
ENV JAVA_OPTS=-XX:+UseG1GC
ENV PATH=${PATH}:/usr/lib/jvm/default-java/bin

ENV JVM_MEMORY_SIZE=1024m
ENV PUID=1000
ENV PGID=1000

ADD https://launcher.mojang.com/v1/objects/${MINECRAFT_VERSION_HASH}/server.jar /games/minecraft/server.jar

RUN apk add --no-cache --purge sudo

COPY ./run.sh /games/minecraft/
COPY ./data/configs/server.properties /configs/server.properties

EXPOSE 25565 25575

WORKDIR /data

VOLUME /data

ENTRYPOINT /games/minecraft/run.sh
