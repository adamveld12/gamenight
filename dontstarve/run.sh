#!/bin/bash

cd /games/${APPID}/bin;

export DS_DIR="/data/clusters/${CLUSTER_NAME}";

if [ -f "${DS_DIR}/cluster.ini" ]; then
    echo "cluster.ini................OK"
else
    echo "WARN: NO cluster.ini DETECTED."
fi

if [ -f "${DS_DIR}/cluster_token.txt" ]; then
    echo "cluster_token.txt..........OK"
else
    echo "WARN: NO cluster_token.txt DETECTED."
fi

if [ -f "${DS_DIR}/${SHARD_NAME}/server.ini" ]; then
    echo "${SHARD_NAME}/server.ini...OK"
else
    echo "WARN: NO ${SHARD_NAME}/server.ini DETECTED."
fi

exec /games/${APPID}/bin/dontstarve_dedicated_server_nullrenderer \
    -persistent_storage_root /data \
    -conf_dir clusters \
    -disabledatacollection \
    -cluster ${CLUSTER_NAME} \
    -shard ${SHARD_NAME} \
    $@
