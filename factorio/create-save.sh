#!/bin/bash
export GAME_SAVE_PATH=/data/saves/${DEFAULT_SAVE_FILE}.zip

if [[ -f /data/configs/map-gen-settings.json ]]; then
    /games/factorio/bin/x64/factorio --create ${GAME_SAVE_PATH} --map-gen-settings /data/configs/map-gen-settings.json
else
    /games/factorio/bin/x64/factorio --create ${GAME_SAVE_PATH} $@
fi