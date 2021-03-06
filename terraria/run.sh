#!/bin/bash

if [ -f /data/configs/serverconfig.txt ]; then
  echo "using existing config"
else
  echo "generating config based on env"
  ./generate_config.sh
fi

ln -s /data/configs/serverconfig.txt serverconfig.txt

exec /games/terraria/TerrariaServer.bin.x86_64 $@
