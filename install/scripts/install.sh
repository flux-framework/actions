#!/bin/bash

set -eEu -o pipefail



printf "Flux Version: ${FLUX_VERSION}\n"
printf "Install Root: ${install_root}\n"
printf "Use sudo: ${use_sudo}\n"

SUDO=""
if [[ "${use_sudo}" == "true" ]]; then
    SUDO="sudo"
fi

# Install Flux dependencies
${SUDO} apt-get update \
 && ${SUDO} apt-get -qq install -y --no-install-recommends \
        automake \
        libsodium-dev \
        libzmq3-dev \
        libczmq-dev \
        libjansson-dev \
        libmunge-dev \
        libncursesw5-dev \
        lua5.3 \
        liblua5.3-dev \
        liblz4-dev \
        libsqlite3-dev \
        uuid-dev \
        libhwloc-dev \
        libmpich-dev \
        libs3-dev \
        libevent-dev \
        libarchive-dev \
        python3 \
        python3-dev \
        python3-pip \
        python3-sphinx \
        libtool \
        git \
        build-essential &&
        ldconfig && \
        rm -rf /var/lib/apt/lists/*

# The python on the path will be found
python -m pip install cffi pyaml jsonschema

wget https://github.com/flux-framework/flux-core/releases/download/v${FLUX_VERSION}/flux-core-${FLUX_VERSION}.tar.gz && \
    tar -xzf flux-core-${FLUX_VERSION}.tar.gz && \
    cd flux-core-${FLUX_VERSION} && \
    chmod +x etc/gen-cmdhelp.py && \
    ./configure --prefix=${install_root} && \
    make && \
    ${SUDO} make install && \
    ${SUDO} ldconfig
