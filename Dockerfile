FROM alpine:3.21 AS builder

RUN apk add --no-cache gcc musl-dev git make \
    && git clone --depth 1 https://github.com/rofl0r/microsocks.git /src \
    && cd /src \
    && make CFLAGS="-O2 -s -static"

FROM alpine:3.21

RUN adduser -D -H -u 10000 socksy

COPY --from=builder /src/microsocks /usr/local/bin/microsocks

USER socksy

ENTRYPOINT ["microsocks"]
