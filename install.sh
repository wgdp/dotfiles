#!/bin/bash

set -eux

# シンボリックリンク
./link.sh

# Install app
if [ "$(uname)" == 'Darwin' ]; then
    ./macos/install.sh
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    ./debian/install.sh
fi

# Install fish
./install_fish.sh

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

# Cargo
cargo install \
    cargo-update \
    zellij

# Go
# デバッガ
go install github.com/go-delve/delve/cmd/dlv@latest

