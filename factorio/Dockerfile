FROM ubuntu:latest

ARG VERSION=stable
ENV VERSION=${VERSION}
ENV PGID=1000
ENV PUID=1000
ENV SAVE_FILE=world

ENV PATH=/games/factorio/bin/x64:${PATH}

RUN apt-get update \
  && apt-get install -y ca-certificates curl xz-utils tar \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN curl -sSL "https://factorio.com/get-download/${VERSION}/headless/linux64" -o /games/factorio.tar.xz \
  && xz -d /games/factorio.tar.xz \
  && tar -xf /games/factorio.tar \
  && rm -rf /games/factorio.tar.xz /games/factorio.tar

COPY ./data /data
COPY ./create-save.sh /games/factorio/
COPY ./run.sh /games/factorio/

WORKDIR /data

EXPOSE 34197/udp
EXPOSE 34198/udp

VOLUME /data

ENTRYPOINT /games/factorio/run.sh
