#!/bin/bash

if [ -z "${T_WORLD_NAME}" ]; then export T_WORLD_NAME="MobyWorld"; fi
if [ -z "${T_MAX_PLAYERS}" ]; then export T_MAX_PLAYERS=8; fi
if [ -z "${T_PORT}" ]; then export T_PORT=7777 fi
if [ -z "${T_PASSWORD}" ]; then export T_WORLD_NAME=""; fi
if [ -z "${T_MOTD}" ]; then export T_MOTD="Please don't cut the purple trees! Save the whales!"; fi
if [ -z "${T_WORLD_SIZE}" ]; then export T_WORLD_SIZE=2; fi
if [ -z "${T_DIFFICULTY}" ]; then export T_DIFFICULTY=0 fi
if [ -z "${T_SECURE}" ]; then export T_SECURE=1 fi
if [ -z "${T_LANG}" ]; then export T_SECURE="en/US" fi

cat << EOF >> /data/configs/serverconfig.txt
#Sets the name of the world when using autocreate
worldname=${T_WORLD_NAME}

#Sets the max number of players allowed on a server. Value must be between 1 and 255
maxplayers=${T_MAX_PLAYERS}

#Set the port number
port=${T_PORT}

#Set the server password
password=${T_PASSWORD}

#Set the message of the day
motd=${T_MOTD}

#Sets the folder where world files will be stored
worldpath=/data/saves/worlds/

#Load a world and automatically start the server.
world=/data/saves/worlds/world1.wld

#Creates a new world if none is found. World size is specified by: 1(small), 2(medium), and 3(large).
autocreate=${T_WORLD_SIZE}

#Sets world difficulty when using -autocreate. Options: 0(normal), 1(expert)
difficulty=${T_DIFFICULTY}

#The location of the banlist. Defaults to "banlist.txt" in the working directory.
banlist=/data/configs/banlist.txt

#Adds additional cheat protection.
secure=${T_SECURE}

#Sets the server language from its language code.  en/US = English de/DE = German it/IT = Italian fr/FR = French es/ES = Spanish ru/RU = Russian zh/Hans = Chinese pt/BR = Portuguese pl/PL = Polish
language=${T_LANG}
EOF
