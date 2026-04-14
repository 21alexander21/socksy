FROM alpine:3.21 AS builder

RUN apk add --no-cache gcc musl-dev git make \
    && git clone --depth 1 https://github.com/rofl0r/microsocks.git /src \
    && cd /src \
    && make CFLAGS="-O2 -s -static"

FROM scratch

COPY --from=builder /src/microsocks /microsocks

USER 65534:65534

ENTRYPOINT ["/microsocks"]
