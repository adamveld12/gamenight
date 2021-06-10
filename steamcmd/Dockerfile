FROM debian:8-slim

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
    && mkdir -p /data/configs /data/logs /data/saves /games /tmp \
    && chown -R steam /data /games /home/steam/ /tmp

# Steam user to login with
ENV STEAM_USER="anonymous"

# Steam password used to authenticate
ENV STEAM_PASS=""

# Steam guard OTP if logging in with an account that has Steam guard enabled
ENV STEAM_GUARD=""

# Disable login command, useful if mounting a steam profile
ENV NO_LOGIN=""

# APP ID for the application you want to install. Mostly useful in base images. See https://developer.valvesoftware.com/wiki/Dedicated_Servers_List
ENV APPID=""

USER steam
WORKDIR /home/steam

COPY --chown=steam:steam ./data/ /data/
COPY --chown=steam:steam ./install.sh /home/steam/install.sh

RUN mkdir -p /home/steam/.steam/sdk32 /home/steam/Steam \
    && curl http://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz -C /home/steam/Steam/ \
    && echo quit | /home/steam/Steam/steamcmd.sh \
    && ln -s /home/steam/Steam/linux32/steamclient.so /home/steam/.steam/sdk32/steamclient.so


# where user accounts are stored, useful if you want to simply mount an already authenticated user or cache user authentication data for reuse
VOLUME ["/home/steam/Steam/userdata/"]

ENTRYPOINT /home/steam/install.sh && /data/configs/configure.sh
