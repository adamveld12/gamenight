#!/bin/ash

cat <<EOF > /data/eula.txt
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
eula=true
EOF

mkdir -p '/data/configs' '/data/world' '/data/plugins';

chown -R minecraft:minecraft /data;

CONFIG_FILES=$(find /configs -type f -name '*.properties' -o -name '*.yml')
for file in ${CONFIG_FILES}; do
    cp -vf "${file}" /data/configs/;
done


su minecraft -c "java -Xmx${JVM_MEMORY_SIZE} -Xms512m ${JAVA_OPTS} -jar /games/minecraft/server.jar --nogui"
