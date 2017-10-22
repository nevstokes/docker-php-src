FROM alpine:3.6 AS src

COPY version.xsl .

RUN set -euxo pipefail

# Requirements
RUN apk update && apk add --no-cache \
        ca-certificates \
        gnupg \
        libressl \
        libxslt-dev

# Define, fetch and check
RUN wget -q https://secure.php.net/releases/feed.php -O - | xsltproc version.xsl - | grep ^7\\.1 > /tmp/versioninfo \
        && IFS=":" read PHP_VERSION PHP_HASH < /tmp/versioninfo \
        && wget -q https://secure.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror -O php.tar.xz \
        && wget -q https://secure.php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror -O php.tar.xz.asc \
        && echo "$PHP_HASH *php.tar.xz" | sha256sum -c -

# Import keys (php.net/gpg-keys.php#gpg-7.1)
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys \
    A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 \
    528995BFEDFBA7191D46839EF9BA0ADA31CBD89E

# Verify
RUN gpg --batch --verify php.tar.xz.asc php.tar.xz


# Blank slate
FROM scratch

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

COPY --from=src /php.tar.xz .

LABEL maintainer="Nev Stokes <mail@nevstokes.com>" \
    description="Verified latest source of PHP v7.1" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vcs-url=$VCS_URL \
    org.label-schema.vcs-ref=$VCS_REF
