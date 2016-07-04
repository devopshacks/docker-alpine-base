FROM alpine:3.4

ENV USER=app \
    CONFD_VERSION=0.11.0 \
    CONFD_PREFIX=/ \
    CONFD_OPTIONS="-backend env"

RUN \
    echo "Create app user and group" \
    && addgroup -g 1000 ${USER} \
    && adduser -u 1000 -D -G ${USER} -s /bin/false ${USER} \

    && echo "Install packages" \
    && apk add --no-cache \
        bash \
        su-exec \
        make \
        curl \

    && echo "Install confd" \
    && curl -sSL https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 -o /bin/confd \
    && chmod +x /bin/confd \
    && mkdir -p /etc/confd/{conf.d,templates} \

    && echo "Clean up" \
    && apk del curl

COPY entrypoint.sh /usr/local/bin/docker-entrypoint
COPY install-dev-tools.sh /usr/local/bin/install-dev-tools
COPY devopshacks-logo /etc/devopshacks-logo
COPY devopshacks-release /etc/devopshacks-release
COPY setup_bash_prompt.sh /etc/profile.d/setup_bash_prompt.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
