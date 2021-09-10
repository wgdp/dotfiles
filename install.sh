#!/bin/bash

set -eux


for file in .??*
do
    [[ "$file" == ".git" ]] && continue
    [[ "$file" == ".DS_Store" ]] && continue
    [[ "$file" == ".gitignore" ]] && continue
    [[ "$file" == ".config" ]] && continue
    ln -sfn $file ~/$file
    echo " $file のリンクが作成されました。"
done

mkdir -p ~/.config
for dir in "$PWD/.config/"*
do
    bn="$(basename "$dir")"
    [[ "$bn" == "fish" ]] && continue

    ln -sfn "$dir" ~/.config/
    echo "$bn のリンクが作成されました。"
done
    

# fish
mkdir -p ~/.config/fish
ln -sfn "~/dotfiles/.config/fish/config.fish" "~/.config/config.fish"
ln -sfn "~/dotfiles/.config/fish/fish_plugin" "~/.config/fish_plugin"


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
