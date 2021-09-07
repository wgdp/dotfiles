#!/bin/bash

set -eux

for file in .??*
do
    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue
    [[ "$file" == ".config" ]] && continue
    echo $file
    ln -sfn $file ~/$file
done

# fish
mkdir -p "$HOME/.config/fish/"
ln -sfn "$PWD/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
ln -sfn "$PWD/.config/fish/fish_plugins" "$HOME/.config/fish/fish_plugins"


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

# Install starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
