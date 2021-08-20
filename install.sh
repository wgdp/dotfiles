#!/bin/bash


# Install fish shell
./install_fish.sh


# Install Neovim
if [ "$(uname)" == 'Darwin' ]; then
    brew install neovim
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # vscode-neovimにはneovim0.5以上が必要なため
    echo "\n" | sudo add-apt-repository ppa:neovim-ppa/unstable || echo "\n" | add-apt-repository ppa:neovim-ppa/unstable
    sudo apt install -y neovim || apt install -y neovim
fi


for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".gitignore" ]] && continue

    ln -s $f ~/$f
done