FROM golang:alpine as builder

ENV GOPATH /go

WORKDIR /go/src

COPY . /go/src/octave

RUN cd /go/src/octave && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" .

FROM alpine

WORKDIR /app

COPY --from=builder /go/src/octave /app
COPY .env /app

# EXPOSE

CMD ["./octave"]