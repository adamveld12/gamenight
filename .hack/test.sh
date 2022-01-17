#!/bin/bash

if [ "$2" = "force" ]; then
	.hack/build.sh $1;
fi

docker run -it --rm --name ${1} \
	-v "$PWD/${1}/run.sh:/games/${1}/run.sh:ro" \
	-e PUID=1000 \
	-e PGID=1000 \
	--entrypoint=sh \
	gamenight/${1}:latest;
