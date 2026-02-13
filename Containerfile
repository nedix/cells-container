ARG ALPINE_VERSION=3.23
ARG BUSYBOX_VERSION=1.37.0
ARG CELLS_VERSION=4.4.17
ARG JQ_VERSION=1.6

FROM alpine:${ALPINE_VERSION} AS build

ARG CELLS_VERSION
ARG JQ_VERSION

WORKDIR /build/pydio

RUN case "$(uname -m)" in \
        aarch64|arm*) CELLS_ARCHITECTURE="arm64"; \
        ;; amd64|x86_64) CELLS_ARCHITECTURE="amd64"; \
        ;; *) echo "Unsupported architecture: $(uname -m)"; exit 1; ;; \
    esac \
    && apk add \
        ca-certificates \
    && wget "https://download.pydio.com/pub/cells/release/${CELLS_VERSION}/linux-${CELLS_ARCHITECTURE}/cells" \
    && wget -O jq "https://download.pydio.com/pub/linux/tools/jq-linux64-v${JQ_VERSION}" \
    && wget -O entrypoint.sh "https://raw.githubusercontent.com/pydio/cells/v${CELLS_VERSION}/tools/docker/images/cells/docker-entrypoint.sh" \
    && chmod +x \
        cells \
        entrypoint.sh \
        jq

FROM busybox:${BUSYBOX_VERSION}-glibc

COPY --link --from=build /build/pydio/cells /usr/bin/cells
COPY --link --from=build /build/pydio/jq /usr/bin/jq
COPY --link --from=build /build/pydio/entrypoint.sh /entrypoint.sh
COPY --link --from=build /etc/ssl/certs /etc/ssl/certs

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cells", "start", "--bind", ":80", "--site_no_tls"]

EXPOSE 80

VOLUME /var/cells
