#!/bin/bash

export ispub="0"
if [ "${VH_PUBLIC}" = "1" ]; then
    ispub="1"
fi

export _PASSWORD_ARG="-password ${VH_SERVER_PASSWORD}"
if [[ -z "${VH_SERVER_PASSWORD}" ]]; then
    _PASSWORD_ARG="-password"
fi

PUSER=valheim;
if [ -z "$(cat /etc/group | grep ${PGID})"  ]; then
    addgroup -q --gecos "" --gid ${PGID} ${PUSER};
fi

if [ -z "$(cat /etc/passwd | grep ${PUID})"  ]; then
    adduser -q --gecos "" --uid ${PUID} --gid ${PGID} --disabled-password --disabled-login --no-create-home ${PUSER};
fi

chown -R ${PUID}:${PGID} /data;
chown -R ${PUID}:${PGID} /games;

exec su valheim -c "export LD_LIBRARY_PATH=\"./linux64:$LD_LIBRARY_PATH\"; \
                    export SteamAppID=892970; \
                    echo \"Starting Valheim (\${SteamAppID}) server\"; \
                    cd /games/valheim; \
                    /games/valheim/valheim_server.x86_64 -nographics -batchmode \
                                                          -savedir /data \
                                                          -port 2456 \
                                                          -name \"${VH_SERVER_NAME}\" ${_PASSWORD_ARG}  \
                                                          -world \"${VH_WORLD}\" \
                                                          -public \"${ispub}\"; \
                    echo \"Valheim (\${SteamAppID}) server exited with code \$?\";"

