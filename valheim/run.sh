#!/bin/bash

export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppID=892970

export ispub="0"
if [ "${VH_PUBLIC}" = "1" ]; then
    ispub="1"
fi

echo "Starting server PRESS CTRL-C to exit"
/games/${APPID}/valheim_server.x86_64 -port 2456 -nographics -batchmode \
-savedir /data \
-name "${VH_SERVER_NAME}" \
-password "${VH_SERVER_PASSWORD}" \
-world "${VH_WORLD}" \
-public "${ispub}"
