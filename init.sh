# !/bin/bash

set -eux

DOTFILES_URL = https://github.com/wgdp444/dotfiles

if [ "$(uname)" == 'Darwin' ]; then
    brew update
    brew install git

    git clone DOTFILES_URL
    cd dotfiles/macos
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    sudo apt update
    sudo apt install

    git clone DOTFILES_URL
    cd dotfiles/debian
fi

../link.sh
./install.sh
