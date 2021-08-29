FROM debian

ARG TARGETOS
ARG TARGETARCH
ARG VERSION

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl

RUN set -x \
	&& curl -fsSL https://get.helm.sh/helm-$VERSION-${TARGETOS}-${TARGETARCH}.tar.gz | tar -zxv



FROM busybox

ARG TARGETOS
ARG TARGETARCH
ARG VERSION

LABEL org.opencontainers.image.source https://github.com/appscodelabs/helm-docker

COPY --from=0 /${TARGETOS}-${TARGETARCH}/helm /usr/bin/helm
