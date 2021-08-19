#!/bin/bash


# Install fish shell
./install_fish.sh


# Install Neovim
if [ "$(uname)" == 'Darwin' ]; then
    brew install neovim
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    sudo apt install neovim || apt install neovim
fi


for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue

    ln -s $f ~/$f
done