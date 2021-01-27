FROM alpine:latest
# packages
RUN apk update && apk add bash pkgconfig gcc g++ libc-dev go && apk add protobuf protobuf-dev=3.13.0-r2 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main
# linter
RUN wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.35.2

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]