#!/bin/bash

docker build --build-arg steam_user=$STEAMUSER --build-arg steam_pass=$STEAMPASS -t arma3 .

docker run -it --rm \
  -v $PWD/run.sh:/home/arma/run.sh \
  -v $PWD/data/configs:/data/configs/ \
  -v $PWD/data/saves/:/data/saves/ \
  --name arma3 \
  --entrypoint bash \
  -p 28015:28015/udp \
  -p 28015:28015/udp \
  -p 28016:28016/udp \
  -p 28017:28017/udp arma3
