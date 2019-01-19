FROM openjdk:8-jre-alpine3.7

ENV MINECRAFT_VERSION=1.13.2
ENV PATH=${PATH}:/usr/lib/jvm/default-java/bin
ENV JVM_MEMORY_SIZE=1024m

ADD https://launcher.mojang.com/v1/objects/3737db93722a9e39eeada7c27e7aca28b144ffa7/server.jar /games/minecraft/server.jar
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
