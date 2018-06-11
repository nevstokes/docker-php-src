FROM alpine:3.7 AS src

COPY version.xsl .

RUN apk --update-cache upgrade && apk add \
        ca-certificates \
        libxslt-dev

RUN wget -q https://secure.php.net/releases/feed.php -O - | xsltproc version.xsl - > versioninfo

FROM scratch

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL

COPY --from=src /versioninfo .

LABEL org.opencontainers.image.authors="Nev Stokes <mail@nevstokes.com>" \
    org.opencontainers.image.description="Current PHP release versions and hashes" \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.source=$VCS_URL \
    org.opencontainers.image.revision=$VCS_REF
