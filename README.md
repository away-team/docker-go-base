# docker-go-base
scratch container with ca certs and tzdata


# Usage

Externally built binary:
```
FROM awayteam/docker-go-base:latest
EXPOSE 8080
ADD bin/app /app
CMD ["/app"]
```

Multi stage build (adjust path and build command as needed):
```
FROM golang:alpine as builder
WORKDIR /go/src/<repo>
COPY . .
RUN CGO_ENABLED=0 go build -a -ldflags "-s" -o /go/bin/app src/main/*.go

FROM awayteam/docker-go-base:latest
EXPOSE 8080
COPY --from=builder /go/bin/app /app
CMD ["/app"]
```
