#!/bin/bash

cd /games/${APPID}/bin
exec /games/${APPID}/bin/dontstarve_dedicated_server_nullrenderer \
    -conf_dir /data/configs \
    -persistent_storage_root /data/saves $@