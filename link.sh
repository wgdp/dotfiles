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
mkdir -p ~/.config/fish/
ln -sfn ~/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
ln -sfn ~/dotfiles/.config/fish/fish_plugins ~/.config/fish/fish_plugins
