FROM ubuntu:latest as builder

ARG VERSION=stable
ENV VERSION=${VERSION}

RUN apt-get update && apt-get install -y curl xz-utils tar

WORKDIR /games

RUN  curl -sSL -N "https://factorio.com/get-download/${VERSION}/headless/linux64" -o /games/factorio.tar.xz \
  && xz -d /games/factorio.tar.xz \
  && tar -xf /games/factorio.tar \
  && rm -rf /games/factorio.tar.xz /games/factorio.tar

FROM ubuntu:latest as server

ARG VERSION=stable
ENV VERSION=${VERSION}
ENV PGID=1000
ENV PUID=1000
ENV SAVE_FILE=world

COPY --from=builder /games/factorio/ /games/factorio/
COPY ./configs /configs
COPY ./run.sh /games/factorio/

WORKDIR /data

EXPOSE 34197/udp
EXPOSE 34198/udp

VOLUME /data

ENTRYPOINT /games/factorio/run.sh
