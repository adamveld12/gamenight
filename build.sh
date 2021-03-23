#!/bin/bash
function build(){
  local buildDir=$1;
  local imageName=$2;
  local dockerfile=${3:-Dockerfile};

  echo "Building ${imageName}"
  docker build --build-arg STEAM_USER=${STEAMUSER} --build-arg STEAM_PASS=${STEAMPASS} -t ${imageName} -f ${dockerfile} ./${buildDir}
  docker push -q ${imageName}
}

TAG="1.2.0"

build ./steamcmd "gamenight/steamcmd:${TAG}";
build ./dontstarve "gamenight/dontstarve:${TAG}" &
build ./minecraft "gamenight/minecraft:1.16.5" &
build ./minecraft "gamenight/minecraft:1.16.5-paper" Dockerfile.paper &
build ./terraria "gamenight/terraria:1353" &
build ./factorio "gamenight/factorio:stable" &

time wait;

echo "done"
