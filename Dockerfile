FROM golang:1.18.1-alpine3.14 AS build-env
RUN apk add --no-cache build-base
RUN go install -v github.com/projectdiscovery/tinydns/cmd/tinydns@latest

FROM alpine:3.15.4
RUN apk add --no-cache bind-tools ca-certificates
COPY --from=build-env /go/bin/tinydns /usr/local/bin/tinydns
ENTRYPOINT ["tinydns"]