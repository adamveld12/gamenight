#!/bin/bash
export GAME_SAVE_PATH=/data/saves/${SAVE_FILE:-world}.zip

if ! [ -f "${GAME_SAVE_PATH}" ]; then 
    create-save.sh;
fi

mkdir -p '/data/logs';

if [ -z "$(cat /etc/group | grep ${PGID})"  ]; then
    addgroup -g ${PGID} factorio;
fi

if [ -z "$(cat /etc/passwd | grep ${PUID})"  ]; then
    adduser -u ${PUID} -G factorio -D -h /data factorio;
fi

chown -R ${PUID}:${PGID} /data;
chown -R ${PUID}:${PGID} /games;

exec su factorio -c "/games/factorio/bin/x64/factorio --verbose \
                                 --start-server \"${GAME_SAVE_PATH}\" \
                                 --server-id /data/server_id \
                                 --console-log /data/logs/console.log \
                                 --mod-directory /data/mods \
                                 --map-gen-settings /data/configs/map-gen-settings.json \
                                 --map-settings /data/configs/map-settings.json \
                                 --server-settings /data/configs/server-settings.json"