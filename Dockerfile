FROM nevstokes/php-src:fetchdeps AS fetchdeps

ARG PHP_SRC_VERSION

COPY --from=nevstokes/php-src:hashes /versioninfo .

RUN if [ -z "${PHP_SRC_VERSION}" ]; then head -1 versioninfo > /tmp/versioninfo ; else grep -F ${PHP_SRC_VERSION}. versioninfo > /tmp/versioninfo ; fi

RUN read PHP_VERSION PHP_HASH < /tmp/versioninfo \
    && axel -qo php.tar.xz https://secure.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror \
    && axel -qo php.tar.xz.asc https://secure.php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror \
    && echo "$PHP_HASH *php.tar.xz" | sha256sum -c -

RUN gpg --batch --verify php.tar.xz.asc php.tar.xz


FROM scratch

ARG PHP_SRC_VERSION
ARG PHP_VERSION_FULL

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

COPY --from=fetchdeps /php.tar.xz .

LABEL org.opencontainers.image.authors="Nev Stokes <mail@nevstokes.com>" \
    org.opencontainers.image.description="Verified latest source of PHP v$PHP_SRC_VERSION" \
    org.opencontainers.image.version="$PHP_VERSION_FULL" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.source=$VCS_URL \
    org.opencontainers.image.revision=$VCS_REF
