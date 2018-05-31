#!/bin/bash


ln -s /data/missions /games/${APPID}/mpmissions

/games/${APPID}/arma3server -netlog \
                            -name=server \
                            -profiles=/data/profiles \
                            -cfg=/data/configs/basic.cfg \
                            -config=/data/configs/server.cfg \
                            ${SERVER_ARGS}
