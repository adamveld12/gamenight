FROM debian:9.6-slim

ARG VERSION=44_12

ENV VERSION=${VERSION}
ENV LANG=en_US.utf-8
ENV LC_ALL=en_US.utf-8

RUN apt-get update \
    && apt-get install -y \
    curl \
    tar \
    bzip2 \
    libc6 \
    libgtk2.0-0 \
    libgcc1 \
    libglib2.0-0 \
    libglu1-mesa \
    libsdl-image1.2 \
    libsdl-ttf2.0-0 \
    libstdc++6 \
    locales \
    sed \
    zlib1g \
    && apt-get clean

RUN mkdir -p /games/ \
    && curl "http://www.bay12games.com/dwarves/df_${VERSION}_linux.tar.bz2" -o /games/df_linux.tar.bz2 \
    && tar -xjf /games/df_linux.tar.bz2 -C /games/  \
    && mv /games/df_linux /games/df \
    && rm -rf /games/df_linux.tar.bz2 /games/df_linux \
    && sed -i 's/\[PRINT_MODE:2D\]/[PRINT_MODE:TEXT]/' /games/df/data/init/init.txt \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen

WORKDIR /games/df/

VOLUME /games/df/data/save

CMD /games/df/df
