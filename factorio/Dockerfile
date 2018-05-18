FROM debian:9.3-slim

ARG VERSION=stable
ENV VERSION=${VERSION}
ENV PATH=/games/factorio/bin/x64:${PATH}

ENV DEFAULT_SAVE_FILE=game_save


RUN apt-get update \
    && apt-get install -y \
        ca-certificates \
        curl \
        xz-utils \
        tar \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && groupadd -r factorio \
    && useradd -m -s /bin/bash -g factorio factorio \
    && echo "factorio:facorio" | chpasswd \
    && mkdir -p /data/configs /games \
    && chown -R factorio /games /data

USER factorio
WORKDIR /games/

RUN curl -L "https://www.factorio.com/get-download/${VERSION}/headless/linux64" -o /games/factorio.tar.xz \
  && xz -d /games/factorio.tar.xz \
  && tar -xf /games/factorio.tar \
  && rm -rf /games/factorio.tar.xz /games/factorio.tar

COPY ./data /data
COPY ./create-save.sh /games/factorio/bin/x64/
COPY ./start.sh /games/factorio/bin/x64/

EXPOSE 34197
EXPOSE 34198


VOLUME ['/data/saves', '/data/configs', '/data/mods']

ENTRYPOINT ['/games/factorio/bin/x64/factorio']