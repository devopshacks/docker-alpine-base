FROM alpine:3.4

ENV USER=app \
    CONFD_VERSION=0.11.0 \
    CONFD_PREFIX=/ \
    CONFD_OPTIONS="-onetime -backend env"

RUN \
    echo "Create app user and group" \
    && addgroup -g 1000 app \
    && adduser -u 1000 -D -G app -s /bin/false app \

    && echo "Installing packages" \
    && apk add --no-cache \
        bash \
        su-exec \
        make \
        curl \

    && echo "Installing confd" \
    && curl -sSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /bin/confd \
    && chmod +x /bin/confd \
    && mkdir -p /etc/confd/{conf.d,templates}

COPY docker_entrypoint.sh /docker_entrypoint.sh

ENTRYPOINT ["/docker_entrypoint.sh"]
