#!/bin/bash
export BRANCH=$GITHUB_REF;
export SHA=$(git rev-parse --short=6 HEAD);
export BUILD_DATE=$(date --iso-8601=minutes)

if [ ! -z "${DOCKER_PASSWORD}" ]; then
  docker login -u adamveld12 -p ${DOCKER_PASSWORD}
fi

function build() {
  local buildDir=$1;

  # WIP = only build
  # RELEASE = build and tag with the versions.txt, and then push
  local tag_mode=${2:-"WIP"};

  local imageName="gamenight/${buildDir}";

  if [ -z "$buildDir" ]; then
    echo "No build directory specified";
    exit 1;
  fi


  local version=$(cat "./versions.txt" | grep ${buildDir} | awk '{print $2}');

  if [ -z "${version}" ]; then
    echo "${buildDir} can not be tagged because it is not in the versions.txt file or entry is missing verion.";
    exit 0;
  fi

  case "$tag_mode" in
    "WIP")
      local tag="pr-${version}-${SHA}";
      ;;
    "RELEASE")
      local tag=${version};
      ;;
    *)
      echo "Unknown tag mode, should be WIP or RELEASE: ${tag_mode}";
      exit 1;
      ;;
  esac

  echo "Detected ${buildDir} version: ${version}";

  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nBuilding '${imageName}'\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  docker build --build-arg "STEAM_USER=${STEAM_USER}" --build-arg "STEAM_PASS=${STEAM_PASS}" \
               --build-arg "VERSION=${version}" \
               --label="org.opencontainers.image.created=${BUILD_DATE}" \
               --label="org.opencontainers.image.source=https://github.com/adamveld12/gamenight.git" \
               --label="org.opencontainers.image.url=https://github.com/adamveld12/gamenight" \
               --label="org.opencontainers.image.revision=${SHA}" \
               --label="org.gamenight.version=${tag}" \
               --label="org.gamenight.game-id=${buildDir}" \
               --label="org.opencontainers.image.licenses=MIT" \
               --label="org.opencontainers.image.authors=Adam Veldhousen <adam@vdhsn.com>" \
              -t "${imageName}:${tag}" \
              -t "${imageName}:${SHA}" \
              -t "${imageName}:latest" \
              -t "ghcr.io/${imageName}:${tag}" \
              -t "ghcr.io/${imageName}:${SHA}" \
              -t "ghcr.io/${imageName}:latest" \
              -f "${buildDir}/Dockerfile" \

              ${buildDir};

  if [ "${tag_mode}" = "RELEASE" ]; then
    echo "Releasing ${imageName}:${tag}";
    docker push "${imageName}:${SHA}";
    docker push "${imageName}:latest";
    docker push "${imageName}:${tag}";
  fi;
}

if ! [ -z "$1" ]; then
  build $1 $2;
fi
