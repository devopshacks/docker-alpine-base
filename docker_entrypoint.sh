#!/usr/bin/env bash

set -e

echo "Running confd with prefix ${CONFD_PREFIX}"
confd -prefix ${CONFD_PREFIX} ${CONFD_OPTIONS}

exec su-exec ${USER} "$@"
