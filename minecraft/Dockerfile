FROM alpine/java:21-jdk

ARG VERSION=1.21.7
ARG MINECRAFT_SERVER_URL=https://fill-data.papermc.io/v1/objects/9adbd99ce7b42c9f0cb205686d83f0208a93fa6d215bb28196e12d0aaf49c2d8/paper-1.21.7-17.jar

LABEL org.opencontainers.image.authors="adam@vdhsn.com"
LABEL org.opencontainers.image.source=""
LABEL org.opencontainers.image.documentation=""
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.title="Gamenight Minecraft Server"
LABEL org.opencontainers.image.description="A Minecraft server running PaperMC with Aikar's flags."
LABEL org.opencontainers.image.vendor="VDHSN"
LABEL org.opencontainers.image.version=${VERSION}

ENV VERSION=${VERSION}
ENV JAVA_OPTS="-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"
ENV JVM_MEMORY_SIZE=1024M

RUN addgroup -g 1000 minecraft \
	&& adduser -D -u 1000 -G minecraft minecraft \
	&& apk add --no-cache sudo

COPY --chown=minecraft:minecraft ./run.sh /games/minecraft/
COPY --chown=minecraft:minecraft ./data/configs/ /configs/

ADD --chown=minecraft:minecraft ${MINECRAFT_SERVER_URL} /games/minecraft/server.jar

EXPOSE 25565 25575

WORKDIR /data
VOLUME /data

CMD ["/games/minecraft/run.sh"]
