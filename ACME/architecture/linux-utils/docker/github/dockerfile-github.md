## Build
FROM golang:1.19-alpine AS build

LABEL maintainer="Marvin Hosea"

RUN apk add --no-cache git ca-certificates

ARG GITHUB_TOKEN
ENV CGO_ENABLED=0 GO111MODULE=on GOOS=linux TOKEN=$GITHUB_TOKEN

RUN go env -w GOPRIVATE=github.com/marvinhosea/*
## Or you could use ENV GOPRIVATE=github.com/username

RUN git config --global url."https://${TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
# Gitlab
# RUN git config  --global url."https://oauth2:${TOKEN}@gitlab.com".insteadOf "https://gitlab.com"


WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .

RUN go build -installsuffix cgo -ldflags '-s -w' -o main ./...

## Deploy
FROM scratch as final

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build /app .

ENTRYPOINT ["./main"]