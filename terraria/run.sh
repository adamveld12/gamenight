#!/bin/bash

if [ -f /data/configs/serverconfig.txt ]; then
  echo "using existing config"
else
  echo "generating config based on env"
  ./generate_config.sh
fi

exec /games/terraria/TerrariaServer.bin.x86_64 $@
