#!/bin/ash
mkdir -p '/data/logs'
mkdir -p '/data/world'
mkdir -p '/data/plugins'

cat <<EOF > /games/minecraft/eula.txt
#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
eula=true
EOF

ln -s /games/minecraft/eula.txt /data/eula.txt


echo "pulling plugins from MINECRAFT_PLUGINS env var";
for PLUGINJAR in ${MINECRAFT_PLUGINS}
do
    if [ -f ${PLUGINJAR} ]; then
        echo "${PLUGINJAR} already installed... skipping";
    else
        curl -sL ${PLUGINJAR}  > /data/plugins;
    fi
done

exec java -Xmx${JVM_MEMORY_SIZE} -Xms512m ${JAVA_OPTS} \
          -jar /games/minecraft/server.jar --nogui
