FROM openjdk:17-alpine

ARG MINECRAFT_VERSION_HASH=a16d67e5807f57fc4e550299cf20226194497dc2
ENV MINECRAFT_VERSION=1.17
ENV JAVA_OPTS=-XX:+UseG1GC
ENV PATH=${PATH}:/usr/lib/jvm/default-java/bin
ENV JVM_MEMORY_SIZE=1024m

ADD  https://launcher.mojang.com/v1/objects/${MINECRAFT_VERSION_HASH}/server.jar /games/minecraft/server.jar

WORKDIR /data

RUN addgroup minecraft \
    && adduser -D -G minecraft minecraft \
    && mkdir -p /games/minecraft /data \
    && chown -cR minecraft /games

COPY --chown=minecraft:minecraft ./run.sh /games/minecraft/
COPY --chown=minecraft:minecraft ./data/configs/server.properties /games/minecraft/server.properties.example

USER minecraft

EXPOSE 25565 25575

VOLUME /data

ENTRYPOINT /games/minecraft/run.sh
