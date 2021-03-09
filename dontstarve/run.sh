#!/bin/bash

cd /games/${APPID}/bin
exec /games/${APPID}/bin/dontstarve_dedicated_server_nullrenderer \
    -persistent_storage_root /data \
    -conf_dir ./configs $@