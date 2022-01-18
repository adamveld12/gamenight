#!/bin/bash

if [ -f /configs/serverconfig.txt ]; then
  echo "using existing config"
else
  echo "generating config based on env"
cat <<EOF >> /configs/serverconfig.txt
#Sets the name of the world when using autocreate
worldname=${T_WORLD_NAME:-MobyWorld}

#Sets the max number of players allowed on a server. Value must be between 1 and 255
maxplayers=${T_MAX_PLAYERS:-8}

#Set the port number
port=${T_PORT:-7777}

#Set the server password
password=${T_PASSWORD}

#Set the message of the day
motd=${T_MOTD:-"Please don't cut the purple trees! Save the whales!"}

#Sets the folder where world files will be stored
worldpath=/data/saves/worlds/

#Load a world and automatically start the server.
world=/data/saves/worlds/world1.wld

#Creates a new world if none is found. World size is specified by: 1(small), 2(medium), and 3(large).
autocreate=${T_WORLD_SIZE:-2}

#Sets world difficulty when using -autocreate. Options: 0(normal), 1(expert)
difficulty=${T_DIFFICULTY:-0}

#The location of the banlist. Defaults to "banlist.txt" in the working directory.
banlist=/configs/banlist.txt

#Adds additional cheat protection.
secure=${T_SECURE:-1}

#Sets the server language from its language code.  en/US = English de/DE = German it/IT = Italian fr/FR = French es/ES = Spanish ru/RU = Russian zh/Hans = Chinese pt/BR = Portuguese pl/PL = Polish
language=${T_LANG:-"en/US"}
EOF

fi

mkdir -p "/data/saves";

PUSER=terraria;
if [ -z "$(cat /etc/group | grep ${PGID})"  ]; then
    addgroup -q --gecos "" --gid ${PGID} ${PUSER};
fi

if [ -z "$(cat /etc/passwd | grep ${PUID})"  ]; then
    adduser -q --gecos "" --uid ${PUID} --gid ${PGID} --disabled-password --disabled-login --no-create-home ${PUSER};
fi

chown -R ${PUID}:${PGID} /data;
chown -R ${PUID}:${PGID} /configs;
chown -R ${PUID}:${PGID} /games;


exec su ${PUSER} -c "/games/terraria/TerrariaServer.bin.x86_64 -config /configs/serverconfig.txt"
