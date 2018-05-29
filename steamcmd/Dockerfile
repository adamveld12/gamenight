FROM debian:8-slim

ENV STEAMUSER="anonymous"
ENV STEAMPASS=""
ENV APPID=

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y \
        ca-certificates \
        curl \
        lib32gcc1 \
        libstdc++6 \
        libstdc++6:i386 \
        sudo \
        tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && groupadd -r steam \
    && useradd -m -s /bin/bash -g steam -G sudo steam \
    && echo "steam:steam" | chpasswd \
    && mkdir -p /data/configs /data/logs /data/saves /games \
    && chown -R steam /data /games /home/steam/

USER steam
WORKDIR /home/steam

COPY ./data/ /data/
COPY ./install.sh /home/steam/install.sh

RUN mkdir -p /home/steam/.steam/sdk32 /home/steam/steamcmd \
    && curl http://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz -C /home/steam/steamcmd/ \
    && echo quit | /home/steam/steamcmd/steamcmd.sh \
    && ln -s /home/steam/steamcmd/linux32/steamclient.so /home/steam/.steam/sdk32/steamclient.so

VOLUME ["/data/configs", "/data/saves", "/data/logs"]

ENTRYPOINT /home/steam/install.sh && /data/configs/configure.sh