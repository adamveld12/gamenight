#!/bin/bash

export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppID=892970

export ispub="0"
if [ "${VH_PUBLIC}" = "1" ]; then
    ispub="1"
fi

export _PASSWORD_ARG="-password ${VH_SERVER_PASSWORD}"
if [[ -z "${VH_SERVER_PASSWORD}" ]]; then
    _PASSWORD_ARG="-password"
fi

if [ -z "$(cat /etc/group | grep ${PGID})"  ]; then
    addgroup -g ${PGID} valheim;
fi

if [ -z "$(cat /etc/passwd | grep ${PUID})"  ]; then
    adduser -u ${PUID} -G valheim -D -h /data valheim;
fi

chown -R ${PUID}:${PGID} /data;
chown -R ${PUID}:${PGID} /games;

exec su valheim -c "/games/${APPID}/valheim_server.x86_64  -nographics -batchmode \
                                                           -savedir /data \
                                                           -port 2456 \
                                                           -name \"${VH_SERVER_NAME}\" ${_PASSWORD_ARG}  \
                                                           -world \"${VH_WORLD}\"  \
                                                           -public \"${ispub}\""
