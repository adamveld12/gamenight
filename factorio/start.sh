#!/bin/bash
export GAME_SAVE_PATH=/data/saves/${DEFAULT_SAVE_FILE}.zip

mkdir -p /data/logs
touch /data/logs/console.log

/games/factorio/bin/x64/factorio --verbose \
                                 --start-server ${GAME_SAVE_PATH} \
                                 --server-id /data/server_id \
                                 --console-log /data/logs/console.log \
                                 --mod-directory /data/mods \
                                 --map-gen-settings /data/configs/map-gen-settings.json \
                                 --map-settings /data/configs/map-settings.json \
                                 --server-settings /data/configs/server-settings.json
