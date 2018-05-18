#!/bin/ash
if [ -d '/data/saves/world' ]; then
  echo "found previous save at /data/saves/world....";
else
  mkdir -p /data/saves/world/
fi

cat <<EOF > ./eula.txt
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
eula=true
EOF

ln -s /data/configs/server.properties server.properties
ln -s /data/saves/world/ world

java -Xmx${JVM_MEMORY_SIZE} -Xms${JVM_MEMORY_SIZE} -jar server.jar nogui