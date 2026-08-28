#!/bin/bash
export BRANCH=$GITHUB_REF;
export SHA=$(git rev-parse --short=6 HEAD);
# BSD date (macos) has no --iso-8601, so spell the format out
export BUILD_DATE=$(date -u +%Y-%m-%dT%H:%MZ)

# architectures to build each image for
export PLATFORMS="${PLATFORMS:-linux/amd64,linux/arm64}"

# prefer podman if it's installed, transparently standing in for docker
export CONTAINER_ENGINE="docker"
if command -v podman > /dev/null 2>&1; then
  echo "Using podman in place of docker";
  export CONTAINER_ENGINE="podman"
  function docker() {
    podman "$@";
  }
fi

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

  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\nBuilding '${imageName}' for ${PLATFORMS}\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

  local build_args=(
    --platform "${PLATFORMS}"
    --build-arg "STEAM_USER=${STEAM_USER}"
    --build-arg "STEAM_PASS=${STEAM_PASS}"
    --build-arg "VERSION=${version}"
    --label="org.opencontainers.image.created=${BUILD_DATE}"
    --label="org.opencontainers.image.source=https://github.com/adamveld12/gamenight.git"
    --label="org.opencontainers.image.url=https://github.com/adamveld12/gamenight"
    --label="org.opencontainers.image.revision=${SHA}"
    --label="org.gamenight.version=${tag}"
    --label="org.gamenight.game-id=${buildDir}"
    --label="org.opencontainers.image.licenses=MIT"
    --label="org.opencontainers.image.authors=Adam Veldhousen <adam@vdhsn.com>"
    -f "${buildDir}/Dockerfile"
  );

  local tags=(
    "docker.io/${imageName}:${tag}"
    "docker.io/${imageName}:${SHA}"
    "docker.io/${imageName}:latest"
    "ghcr.io/${imageName}:${tag}"
    "ghcr.io/${imageName}:${SHA}"
    "ghcr.io/${imageName}:latest"
  );

  if [ "${CONTAINER_ENGINE}" = "podman" ]; then
    # a multi arch build has to land in a manifest list, not a plain image,
    # and podman refuses to build one over a name a plain image already holds
    podman manifest rm "${tags[0]}" > /dev/null 2>&1 || podman rmi "${tags[0]}" > /dev/null 2>&1;
    podman build "${build_args[@]}" --manifest "${tags[0]}" "${buildDir}" || return 1;

    local t;
    for t in "${tags[@]:1}"; do
      podman tag "${tags[0]}" "${t}";
    done

    if [ "${tag_mode}" = "RELEASE" ]; then
      echo "Releasing ${imageName}:${tag}";
      for t in "${tags[@]}"; do
        podman manifest push --all "${t}" "docker://${t}";
      done
    fi;
  else
    local tag_args=();
    local t;
    for t in "${tags[@]}"; do
      tag_args+=(-t "${t}");
    done

    # buildx can't load a manifest list into the local image store, so a
    # release has to push straight out of the build
    local output=(--output "type=image,push=false");
    if [ "${tag_mode}" = "RELEASE" ]; then
      echo "Releasing ${imageName}:${tag}";
      output=(--push);
    fi;

    docker buildx build "${build_args[@]}" "${tag_args[@]}" "${output[@]}" "${buildDir}";
  fi;
}

if ! [ -z "$1" ]; then
  build $1 $2;
fi
