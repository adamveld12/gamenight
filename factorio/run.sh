#!/bin/bash

docker run -it -v $PWD/_data/saves:/data/saves -v $PWD/_data/configs:/data/configs --entrypoint bash adamveld12/factorio