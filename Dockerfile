# syntax=docker/dockerfile:1

# ── Build stage: install tools ──────────────────────────────────────────────
FROM node:20-alpine AS builder

RUN corepack enable && corepack prepare pnpm@9 --activate

RUN npm install -g \
    typescript \
    typescript-language-server \
    @tailwindcss/language-server \
    sqls

RUN apk add --no-cache go curl bash \
    && curl -fsSL https://go.dev/dl/go1.22.5.linux-amd64.tar.gz | tar -C /usr/local -xzf - \
    && export PATH=$PATH:/usr/local/go/bin \
    && go install github.com/go-delve/delve/cmd/dlv@latest \
    && go install github.com/fatih/gomodifytags@latest \
    && go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

RUN curl -sL https://github.com/LuaLS/lua-language-server/releases/download/3.13.5/lua-language-server-3.13.5-linux-x64.tar.gz \
    | tar xz -C /usr/local

# ── Runtime stage: minimal image ─────────────────────────────────────────────
FROM alpine:3.20

ENV DEBIAN_FRONTEND=noninteractive

RUN apk add --no-cache \
    neovim \
    bash \
    curl \
    git \
    nodejs \
    npm \
    lua-language-server \
    go \
    unzip

COPY --from=builder /usr/local/go /usr/local/go
COPY --from=builder /usr/local/bin/dlv /usr/local/bin/dlv
COPY --from=builder /usr/local/bin/gomodifytags /usr/local/bin/gomodifytags
COPY --from=builder /usr/local/bin/golangci-lint /usr/local/bin/golangci-lint
COPY --from=builder /usr/local/bin/typescript* /usr/local/bin/
COPY --from=builder /usr/local/bin/sqls /usr/local/bin/
COPY --from=builder /usr/local/bin/lua-language-server /usr/local/bin/

ENV PATH=$PATH:/usr/local/go/bin:/root/go/bin
ENV GOPATH=/root/go

# Pre-download LSP binaries for slow-clang installs if needed
# rust-analyzer: apk add rust-analyzer  # or download binary

COPY --chown=root:root . /root/.config/nvim

ENTRYPOINT ["nvim"]
