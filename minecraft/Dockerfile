FROM eclipse-temurin:26.0.2_10-jdk-alpine-3.24
ARG VERSION=26.2
# https://papermc.io/downloads/paper
ARG MINECRAFT_SERVER_URL=https://fill-data.papermc.io/v1/objects/a8c9140c3075bd7c04973e9cdc491b21bfe6bad472b674ef932a4ae0fec19629/paper-26.2-119.jar

LABEL org.opencontainers.image.authors="adam@vdhsn.com"
LABEL org.opencontainers.image.source=""
LABEL org.opencontainers.image.documentation=""
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.title="Gamenight Minecraft Server"
LABEL org.opencontainers.image.description="A Minecraft server running PaperMC with Aikar's flags."
LABEL org.opencontainers.image.vendor="VDHSN"
LABEL org.opencontainers.image.version=${VERSION}

ENV VERSION=${VERSION}
# GC Args: https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/
ENV JAVA_OPTS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
ENV JVM_MEMORY_SIZE=1024M

RUN addgroup -g 1000 minecraft \
	&& adduser -D -u 1000 -G minecraft minecraft \
	&& apk add --no-cache sudo

COPY --chown=minecraft:minecraft ./run.sh /games/minecraft/
COPY --chown=minecraft:minecraft ./data/configs/ /config/

ADD --chown=minecraft:minecraft ${MINECRAFT_SERVER_URL} /games/minecraft/server.jar

EXPOSE 25565 25575

WORKDIR /data
VOLUME /data

CMD ["/games/minecraft/run.sh"]
