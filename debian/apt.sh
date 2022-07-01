# apt周り

# リポジトリ追加
sudo add-apt-repository ppa:lazygit-team/release
sudo add-apt-repository ppa:longsleep/golang-backports

sudo apt update -y

sudo apt install -y \
    lazygit \
    wget \
    golang

# neovim用
sudo apt install -y \
    ninja-build \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \cmake \
    g++ \
    pkg-config \
    unzip \
    curl \
    doxygen
