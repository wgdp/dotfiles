#! /bin/bash

# neovim
NEOVIM_VERSION="v0.7.2"

cd /tmp
git clone https://github.com/neovim/neovim
cd /tmp/neovim
git checkout $NEOVIM_VERSION

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

sudo mv ./build/bin/nvim /user/bin/nvim

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

