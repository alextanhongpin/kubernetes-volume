FROM golang:1.11-stretch AS builder

WORKDIR /app
COPY main.go main.go
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

RUN adduser -S -D -H -h /app appuser
USER appuser

FROM alpine:3.8
RUN apk --no-cache add ca-certificates


# RUN adduser -S -D -H -h /app appuser
# USER appuser
WORKDIR /app

RUN mkdir -p data

RUN adduser -S -D -H -h /data appuser
USER appuser

COPY --from=builder /app . 

CMD ["./app"]
