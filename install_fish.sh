#!/bin/bash

FISH_REPO_NAME="ppa:fish-shell/release-3"
FISHER_INSTALL_CMD="curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish"


# Mac
if [ "$(uname)" == 'Darwin' ]; then
    brew install fish
    brew install curl
# Linux
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    # Linux || Docker
    sudo apt install -y software-properties-common curl || apt install -y software-properties-common curl
    echo "\n" | sudo apt-add-repository $FISH_REPO_NAME || echo "\n" | apt-add-repository $FISH_REPO_NAME
    sudo apt update || apt update
    sudo apt install -y fish || apt install -y fish
fi

# Install fisher
fish -c "curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish"
cat $HOME/dotfiles/.config/fish/fish_plugins | while read line
do
    fish -c "fisher install $line"
done


# Change default shell
echo /usr/local/bin/fish | sudo tee -a /etc/shells || echo /usr/local/bin/fish | tee -a /etc/shells
sudo chsh -s /usr/local/bin/fish || chsh -s /user/local/bin/fish