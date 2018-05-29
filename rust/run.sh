#!/bin/bash

export SAVES=/data/saves
export CONFIGS=/data/configs

IFS=$'\n'
for cfgArg in $(cat /data/configs/server.cfg)
do
  echo $cfgArg
  if [ ${cfgArg:0:1} == "#" ]; then
    echo -n ""
  else
    CONFIG_ARGS=$(echo -n "${CONFIG_ARGS} +${cfgArg}");
  fi
done

mkdir -p /data/logs

cd /games/${APPID}
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`dirname $0`/RustDedicated_Data/Plugins/x86_64
./RustDedicated -batchmode ${CONFIG_ARGS} -logfile 2>&1
cd /home/rust
