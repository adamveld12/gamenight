#!/bin/bash
if [ -z "$STEAMUSER" ]; then
  export STEAMUSER="anonymous"
  export STEAMPASS=""
fi;


if [ -z "$APPID" ]; then
  echo "An APPID environment variable must be defined";
  exit 1
fi;

if [ -z "$STEAMGUARD" ]; then
  /home/steam/steamcmd/steamcmd.sh \
        +@ShutdownOnFailedCommand 1 \
        +@NoPromptForPassword 1 \
        +login $STEAMUSER $STEAMPASS \
        +force_install_dir /games/$APPID/ \
        +app_update $APPID validate \
        +exit;
else
  /home/steam/steamcmd/steamcmd.sh \
        +@ShutdownOnFailedCommand 1 \
        +@NoPromptForPassword 1 \
        +login $STEAMUSER $STEAMPASS \
        +exit;

  sleep 1;
  echo "logging in with steam guard";

  /home/steam/steamcmd/steamcmd.sh \
        +@ShutdownOnFailedCommand 1 \
        +@NoPromptForPassword 1 \
        +set_steam_guard_code $STEAMGUARD \
        +login $STEAMUSER $STEAMPASS \
        +force_install_dir /games/$APPID/ \
        +app_update $APPID validate \
        +logout \
        +exit;
fi;
