# Container for building and testing cmake-examples with default cmake v3.5.1
FROM ubuntu:16.04
MAINTAINER vertigo235

ENV OS="Linux"
ENV BUILD_ENV="1.0.6"
ENV OSTYPE="linux-gnu"
ENV JAVA_TOOL_OPTIONS="-Djava.net.preferIPv4Stack=true"
ENV GPG_TTY=$(tty)
ENV TERM="xterm"

RUN apt-get update && apt-get install -y build-essential \
    sudo \
    cmake \
    libboost-all-dev \
    libprotobuf-dev \
    protobuf-compiler \
    clang-3.6 \
    clang-format-3.6 \
    ninja-build \
    wget \
    unzip \
    zip \
    git \
    srecord \
    vim-common \
    gawk \
    curl \
    doxygen \
    graphviz \
    plantuml \
    python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#- Prusa Build ENV
RUN mkdir /build-env \
    && cd /build-env \
    && mkdir PF-build-env-$BUILD_ENV/ \
    && wget https://github.com/mkbel/PF-build-env/releases/download/$BUILD_ENV/PF-build-env-Linux64-$BUILD_ENV.zip \
    && unzip PF-build-env-Linux64-$BUILD_ENV.zip -d PF-build-env-$BUILD_ENV/

ADD setup.sh /setup.sh
RUN chmod +x /setup.sh

CMD ["/bin/bash"]
ENTRYPOINT ["/setup.sh"]
