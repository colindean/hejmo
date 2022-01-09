#!/usr/bin/env bash

INSTALL_GUIDE_URL="https://github.com/alacritty/alacritty/blob/master/INSTALL.md"

if [ "$(uname -s)" == "Darwin" ];
    brew install alacritty
    exit 0
fi

# Sigh, I wish they'd package this...

if ! command -v rustc; then
    echo "Setting up Rust..."
    bash setup-rust.sh
fi

if command -v apt; then
    apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
else
    echo "Install dependencies manually: ${INSTALL_GUIDE_URL}"
fi

if ! infocmp alacritty; then
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
fi

echo "Installing desktop files..."

sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

echo "Installing man pages..."

sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

BASH_COMPLETION_DIR="${BASH_COMPLETION_DIR:-/etc/bash_completion.d}"

echo "Copying bash completions to ${BASH_COMPLETION_DIR}"
sudo cp extra/completions/alacritty.bash "${BASH_COMPLETION_DIR}/alacritty"

