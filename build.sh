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
  docker build --build-arg "STEAM_USER=${STEAM_USER}" --build-arg "STEAM_PASS=${STEAM_PASS}" \
               --label="org.opencontainers.image.created=$(BUILD_DATE)" \
               --label="org.opencontainers.image.source=https://github.com/adamveld12/gamenight.git" \
               --label="org.opencontainers.image.url=https://github.com/adamveld12/gamenight" \
               --label="org.opencontainers.image.revision=$(COMMIT_SHA)" \
               --label="org.opencontainers.image.licenses=MIT" \
               --label="org.opencontainers.image.authors=Adam Veldhousen <adam@vdhsn.com>" \
              -t "${imageName}:${tag}" \
              -f "${buildDir}/${df}" \
              ${buildDir};

  if [ "${BRANCH}" = "refs/heads/master" ]; then
    docker tag "${imageName}:${tag}" "${imageName}:latest";
  fi

  docker push -a -q ${imageName};
}
