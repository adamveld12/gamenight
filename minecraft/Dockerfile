FROM openjdk:8-jre-alpine3.7

ENV MINECRAFT_VERSION=1.16.4
ENV PATH=${PATH}:/usr/lib/jvm/default-java/bin
ENV JVM_MEMORY_SIZE=1024m

ADD https://launcher.mojang.com/v1/objects/35139deedbd5182953cf1caa23835da59ca3d7cd/server.jar /games/minecraft/server.jar

WORKDIR /games/minecraft/

RUN addgroup minecraft \
    && adduser -D -G minecraft minecraft \
    && mkdir -p /games/minecraft /data \
    && chmod +x /games/minecraft/run.sh \
    && chown -cR minecraft /games


COPY --chown=minecraft:minecraft ./run.sh /games/minecraft/
COPY --chown=minecraft:minecraft ./data/ /data/
COPY --chown=minecraft:minecraft ./data/configs/server.properties /data/configs/server.properties.example

USER minecraft

EXPOSE 25565

VOLUME ["/data"]

ENTRYPOINT /games/minecraft/run.sh
