FROM golang:alpine as builder

RUN apk --no-cache add bash make openssl
COPY . /go/src/github.com/bakins/php-fpm-exporter
RUN cd /go/src/github.com/bakins/php-fpm-exporter && ./script/build

FROM alpine
COPY --from=builder /go/src/github.com/bakins/php-fpm-exporter/php-fpm-exporter.linux.amd64 /php-fpm-exporter

EXPOSE     9253

ENTRYPOINT [ "/php-fpm-exporter" ]
