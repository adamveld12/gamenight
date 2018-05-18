#!/bin/bash
echo "/data/configs/configure.sh (AKA this very file)  gets called by steamcmd after running the install.sh by default"
echo "You should overwrite /data/configs/configure.sh by mounting a volume at /data/configs and using your own."
echo "The game specfied by the APPPID $APPID was installed at /home/steam/games/$APPID/"