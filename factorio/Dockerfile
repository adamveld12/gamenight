FROM ubuntu:latest

ARG VERSION=stable
ENV VERSION=${VERSION}
ENV PATH=/games/factorio/bin/x64:${PATH}

ENV DEFAULT_SAVE_FILE=game_save


RUN apt-get update \
  && apt-get install -y ca-certificates curl xz-utils tar \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && groupadd -r factorio \
  && useradd -m -s /bin/bash -g factorio factorio \
  && echo "factorio:factorio" | chpasswd \
  && mkdir -p /data/configs /games \
  && chown -R factorio /games /data

USER factorio
WORKDIR /games/

RUN curl -sSL "https://factorio.com/get-download/${VERSION}/headless/linux64" -o /games/factorio.tar.xz \
  && xz -d /games/factorio.tar.xz \
  && tar -xf /games/factorio.tar \
  && rm -rf /games/factorio.tar.xz /games/factorio.tar

COPY --chown=factorio:factorio ./data /data
COPY --chown=factorio:factorio ./create-save.sh /games/factorio/bin/x64/
COPY --chown=factorio:factorio ./start.sh /games/factorio/bin/x64/

EXPOSE 34197/udp
EXPOSE 34198/udp

VOLUME /data

WORKDIR /games/factorio

CMD ["/bin/bash", "/games/factorio/bin/x64/start.sh"]
