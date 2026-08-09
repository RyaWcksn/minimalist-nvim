FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    neovim \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Go + tools
RUN curl -fsSL https://go.dev/dl/go1.22.5.linux-amd64.tar.gz | tar -C /usr/local -xzf -
ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/root/go
RUN go install github.com/go-delve/delve/cmd/dlv@latest && \
    go install github.com/fatih/gomodifytags@latest

# Install lua-language-server
RUN apt-get update && apt-get install -y \
    lua-language-server \
    && rm -rf /var/lib/apt/lists/*

# Copy config
COPY --chown=root:root . /root/.config/nvim

ENTRYPOINT ["nvim"]
