#!/bin/bash

export APP_COMMAND="+app_update $APPID validate"
if [[ -z "$APPID" ]]; then
  APP_COMMAND=""
fi;

if [[ -z "$STEAM_USER" ]]; then
  export STEAM_USER="anonymous";
  export STEAM_PASS="";
fi;

export LOGIN_COMMAND="";
if [[ -z "$NO_LOGIN" ]]; then
  export LOGIN_COMMAND="+login $STEAM_USER $STEAM_PASS $STEAM_GUARD";
fi;

exec /home/steam/Steam/steamcmd.sh \
      +@sSteamCmdForcePlatformType linux \
      +force_install_dir /games/$APPID/ \
      ${LOGIN_COMMAND} ${APP_COMMAND} +exit;
