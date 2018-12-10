#!/bin/bash

docker build --build-arg steam_user=$STEAMUSER --build-arg steam_pass=$STEAMPASS -t arma3 .

docker run -it --rm \
  -v $PWD/run.sh:/home/arma/run.sh \
  -v $PWD/data/configs:/data/configs/ \
  -v $PWD/data/saves/:/data/saves/ \
  --name arma3 \
  --entrypoint bash \
  -p 2302:2302/udp \
  -p 2303:2303/udp \
  -p 2304:2304/udp \
  -p 2305:2305/udp \
  -p 2306:2306/udp \
  arma3
