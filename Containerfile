ARG ALPINE_VERSION=3.21
ARG ARCHITECTURE
ARG BUSYBOX_VERSION=1.37.0
ARG CELLS_VERSION=4.4.8
ARG JQ_VERSION=1.6

FROM alpine:${ALPINE_VERSION} AS build

ARG ARCHITECTURE
ARG CELLS_VERSION
ARG JQ_VERSION

WORKDIR /build/pydio

RUN test -n "$ARCHITECTURE" || case $(uname -m) in \
        aarch64) ARCHITECTURE=arm64; ;; \
        amd64) ARCHITECTURE=amd64; ;; \
        arm64) ARCHITECTURE=arm64; ;; \
        armv8b) ARCHITECTURE=arm64; ;; \
        armv8l) ARCHITECTURE=arm64; ;; \
        x86_64) ARCHITECTURE=amd64; ;; \
        *) echo "Unsupported architecture, exiting..."; exit 1; ;; \
    esac \
    && apk add \
        ca-certificates \
    && wget "https://download.pydio.com/pub/cells/release/${CELLS_VERSION}/linux-${ARCHITECTURE}/cells" \
    && wget -O jq "https://download.pydio.com/pub/linux/tools/jq-linux64-v${JQ_VERSION}" \
    && wget -O entrypoint.sh "https://raw.githubusercontent.com/pydio/cells/v${CELLS_VERSION}/tools/docker/images/cells/docker-entrypoint.sh" \
    && wget -O libdl.so.2 "https://raw.githubusercontent.com/pydio/cells/v${CELLS_VERSION}/tools/docker/images/cells/libdl.so.2" \
    && chmod +x \
        cells \
        entrypoint.sh \
        jq

FROM busybox:${BUSYBOX_VERSION}-glibc

COPY --link --from=build /build/pydio/cells /usr/bin/cells
COPY --link --from=build /build/pydio/jq /usr/bin/jq
COPY --link --from=build /build/pydio/libdl.so.2 /lib64/libdl.so.2
COPY --link --from=build /build/pydio/entrypoint.sh /entrypoint.sh
COPY --link --from=build /etc/ssl/certs /etc/ssl/certs

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cells", "start"]

EXPOSE 8080

VOLUME /var/cells
