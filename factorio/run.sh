#!/bin/bash
export GAME_SAVE_PATH=/data/saves/${SAVE_FILE:-world}.zip



if ! [ -f "${GAME_SAVE_PATH}" ]; then
    echo "No save file found, generating save `${GAME_SAVE_PATH}` with settings found in `/data/configs/{map-gen-settings,map-gen-presets}.json`";
    /games/factorio/create-save.sh;
fi

mkdir -p '/data/logs';

PUSER=factorio;
if [ -z "$(cat /etc/group | grep ${PGID})"  ]; then
    addgroup -q --gecos "" --gid ${PGID} ${PUSER};
fi

if [ -z "$(cat /etc/passwd | grep ${PUID})"  ]; then
    adduser -q --gecos "" --uid ${PUID} --gid ${PGID} --disabled-password --disabled-login --no-create-home ${PUSER};
fi

chown -R ${PUID}:${PGID} /data;
chown -R ${PUID}:${PGID} /games;

exec su ${PUSER} -c "echo \"Starting Factorio server\"; \
                    /games/factorio/bin/x64/factorio --verbose \
                                 --start-server \"${GAME_SAVE_PATH}\" \
                                 --server-id /data/server_id \
                                 --console-log /data/logs/console.log \
                                 --mod-directory /data/mods \
                                 --map-gen-settings /data/configs/map-gen-settings.json \
                                 --map-settings /data/configs/map-settings.json \
                                 --server-settings /data/configs/server-settings.json; \
                    echo \"Factorio server exited with code \$?\";"
