#!/usr/bin/env bash

set -eo pipefail; [[ "$TRACE" ]] && set -x

if [[ "$(id -u)" -ne 0 ]]; then
    echo 'install-dev-tools requires root' >&2
    exit 1
fi

apk add --no-cache \
    curl \
    strace \
    tcpflow \
    tcpdump
