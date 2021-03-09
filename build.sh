#!/bin/bash

function build(){
  local buildDir=$1;
  local imageName=$2;

  echo "Building ${imageName}"
  docker build --build-arg STEAM_USER=${STEAMUSER} --build-arg STEAM_PASS=${STEAMPASS} -t ${imageName} ./${buildDir}
  docker push -q ${imageName}
}

TAG="1.2.0"

build ./steamcmd "gamenight/steamcmd:${TAG}";

for D in */; do
    echo "~~~~~BUILDING $D~~~~~~"
    build $D "gamenight/${D%?}:${TAG}" &
done;

time wait;

echo "done"
