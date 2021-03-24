#!/bin/bash
export BRANCH=$GITHUB_REF;
export SHA=$(git rev-parse --short=6 HEAD);

docker login -u adamveld12 -p ${DOCKER_PASSWORD}

function build() {
  local buildDir=$1;
  local tag=$2;
  local df=$3;

  local imageName="gamenight/${buildDir}"

  if [ -z "$df" ]; then
    df="Dockerfile";
  fi

  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nBuilding '${imageName}'\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  docker build --build-arg "STEAM_USER=${STEAMUSER}" --build-arg "STEAM_PASS=${STEAMPASS}" \
              --label "maintainer=adam@vdhsn.com" \
              --label "created=$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
              -t "${imageName}:${tag}" \
              -f "${buildDir}/${df}" \
              ${buildDir};

  if [ "${BRANCH}" = "/refs/head/master" ]; then
    docker tag "${imageName}:${tag}" "${imageName}:latest";
  fi

  docker push -a -q ${imageName};
}
