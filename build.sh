#!/bin/bash
function build() {
  local buildDir=$1;
  local imageName=$2;
  local tag=$3;
  local df=$4;

  if [ -z "$df" ]; then
    df="Dockerfile";
  fi

  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nBuilding '${imageName}'\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  docker build --build-arg "STEAM_USER=${STEAMUSER}" --build-arg "STEAM_PASS=${STEAMPASS}" \
              -t "${imageName}:${tag}" \
              -f "${buildDir}/${df}" \
              ${buildDir};

  if [ "${BRANCH}" = "master" ]; then
    docker tag "${imageName}:${tag}" "${imageName}:latest";
  fi

  docker push -a -q ${imageName};
}

TAG="1.2.1"
build ./steamcmd "gamenight/steamcmd" "${TAG}";
build ./dontstarve "gamenight/dontstarve" "${TAG}" &
build ./minecraft "gamenight/minecraft" "1.16.5" &
build ./minecraft "gamenight/minecraft" "1.16.5-paper" "Dockerfile.paper" &
build ./terraria "gamenight/terraria" "1353" &
build ./factorio "gamenight/factorio" "stable" &
build ./rust "gamenight/rust" "stable" &

time wait;

echo "done"
