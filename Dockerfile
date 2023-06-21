FROM golang:1.20 AS build

WORKDIR /app

COPY go.mod ./
COPY main.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-s -w" -o main .

FROM scratch

COPY --from=build /app/main /

CMD ["/main"]

