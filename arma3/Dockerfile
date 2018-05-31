FROM adamveld12/steamcmd:1.0.0


ARG steam_user
ARG steam_pass
ARG steam_guard

ENV APPID=233780
ENV SERVER_ARGS=

RUN STEAMUSER=$steam_user STEAMPASS=$steam_pass STEAMGUARD=$steam_guard /home/steam/install.sh

USER root

RUN useradd -m -s /bin/bash -g steam arma3 \
    && echo "arma3:arma3" | chpasswd \
    && chown -R arma3 /data /home/arma3 /games

USER arma3
WORKDIR /home/arma3

COPY ./run.sh /home/arma3/run.sh
COPY ./data /data

#2302 (default Arma 3 Game port) + (VON is now part of main gameport due to NAT issues)
#2303 (STEAM query, +1)
#2304 (Steam port, +2)
#2305 (VON port, +3 - not used atm. but allocated)
#2306 (BattlEye traffic, +4)
EXPOSE 2302/udp 2302/udp 2303/udp 2304/udp 2305/udp 2306/udp

VOLUME ["/data/saves", "/data/configs", "/data/mods", "/data/missions", "/data/profiles"]

ENTRYPOINT /home/arma3/run.sh
