#!/bin/bash

docker build --build-arg VERSION=44_12 -t adamveld12/df .
docker run -it --rm  adamveld12/df
