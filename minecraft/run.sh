#!/bin/ash
mkdir -p '/data/logs'
mkdir -p '/data/world'

cat <<EOF > /games/minecraft/eula.txt
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
eula=true
EOF

ln -s /games/minecraft/eula.txt /data/eula.txt

cd /data
exec java -Xmx${JVM_MEMORY_SIZE} -Xms512m \
          -jar /games/minecraft/server.jar --nogui 
