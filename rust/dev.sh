#!/bin/bash

docker build -t r .

docker run -it --rm \
  -v $PWD/run.sh:/home/rust/run.sh \
  -v $PWD/data/configs/server.cfg:/data/configs/server.cfg \
  --entrypoint bash \
  -p 28015:28015/udp \
  -p 28015:28015/tcp \
  -p 28016:28016/tcp \
  -p 28017:28017/tcp r
