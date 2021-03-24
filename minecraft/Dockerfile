FROM openjdk:8-jre-alpine3.7

ENV MINECRAFT_VERSION=1.16.5
ENV JAVA_OPTS=-XX:+UseG1GC
ENV PATH=${PATH}:/usr/lib/jvm/default-java/bin
ENV JVM_MEMORY_SIZE=1024m

ADD https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar /games/minecraft/server.jar

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
