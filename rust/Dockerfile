FROM gamenight/steamcmd:1.0.0

ENV APPID=258550

RUN /home/steam/install.sh

USER root

RUN apt-get update \
    && apt-get install -y \
      libsqlite3-0 \
      libsqlite3-dev \
      libsqlite3-0:i386 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && useradd -m -s /bin/bash -g steam rust \
    && echo "rust:rust" | chpasswd \
    && chown -R rust /data /home/rust /games

USER rust
WORKDIR /home/rust

COPY ./run.sh /home/rust/run.sh
COPY ./data /data

#UDP:28015 // Gameserver
#TCP:28016 // Serverlist
#TCP:28017 // RC
EXPOSE 28015/udp 28016/tcp 28017/tcp

VOLUME ["/data/saves", "/data/configs"]

ENTRYPOINT /home/rust/run.sh
