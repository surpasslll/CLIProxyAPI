# 使用最新的 Go 1.24 镜像作为构建环境
FROM golang:1.24-alpine AS builder

WORKDIR /app

# 复制依赖文件并下载
COPY go.mod go.sum ./
RUN go mod download

# 复制源代码并编译
COPY . .
RUN go build -o main ./cmd/server

# 使用轻量的 alpine 镜像运行
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/main .

# 暴露端口
EXPOSE 8080

CMD ["./main"]
