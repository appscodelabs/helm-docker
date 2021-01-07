FROM debian

ARG OS
ARG ARCH
ARG VERSION

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl

RUN set -x \
	&& curl -fsSL https://get.helm.sh/helm-$VERSION-$OS-$ARCH.tar.gz | tar -zxv



FROM busybox

ARG OS
ARG ARCH
ARG VERSION

LABEL org.opencontainers.image.source https://github.com/appscodelabs/helm-docker

COPY --from=0 /$OS-$ARCH/helm /usr/bin/helm
