# !/bin/bash

set -eux

cd /tmp

# install go task
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

# install git
sudo apt update | apt update
sudo apt install git | apt install git

# clone dotfiles
git clone https://github.com/wgdp444/dotfiles
cd dotfiles
./install.sh
