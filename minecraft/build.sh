#!/bin/bash

if [ -z ${MINECRAFT_VERSION} ]; then
    MINECRAFT_VERSION="1.12.2"
fi

docker build -t adamveld12/minecraft-server:${MINECRAFT_VERSION} .
docker tag adamveld12/minecraft-server:${MINECRAFT_VERSION} minecraft-server
