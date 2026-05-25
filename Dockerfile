FROM golang:1.22.5 as base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

WORKDIR /app

COPY --from=base /app/main /app/main 

COPY --from=base /app/static /app/static

EXPOSE 8080

CMD ["/app/main"]

