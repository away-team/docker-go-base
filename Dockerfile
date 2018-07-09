FROM alpine:latest as alpine
RUN apk --no-cache add tzdata zip ca-certificates
WORKDIR /usr/share/zoneinfo
# -0 means no compression.  Needed because go's tz loader.
RUN zip -r -0 /zoneinfo.zip .

FROM scratch
# set the location for the zoneinfo file
ENV ZONEINFO /zoneinfo.zip
COPY --from=alpine /zoneinfo.zip /
# copy the ca certs
COPY --from=alpine /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
