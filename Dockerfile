FROM alpine

ARG TARGETOS
ARG TARGETARCH
ARG VERSION

RUN set -x \
	&& apk add --update ca-certificates curl zip

RUN set -x \
	&& curl -LO https://github.com/moparisthebest/static-curl/archive/refs/heads/master.zip \
	&& unzip master.zip \
	&& cd static-curl-master \
	&& ARCH=${TARGETARCH} ./build.sh

RUN set -x \
	&& curl -fsSL https://get.helm.sh/helm-$VERSION-${TARGETOS}-${TARGETARCH}.tar.gz | tar -zxv



FROM busybox

ARG TARGETOS
ARG TARGETARCH
ARG VERSION

LABEL org.opencontainers.image.source https://github.com/appscodelabs/helm-docker

COPY --from=0 /tmp/release/curl-$TARGETARCH /usr/bin/curl
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=0 /${TARGETOS}-${TARGETARCH}/helm /usr/bin/helm
