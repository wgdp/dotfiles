# dotfiles

## 概要

基本自分用です。

## Install

```bash
cd
git clone https://github.com/wgdp/dotfiles
cd dotfiles
./init.sh
```

## 現状手動でやってね😇😇😇

- brew caskとかで自動化しておきたい
    - Alacrittyインストール
    - Google日本語入力インストール
        - （Mac Only）[Macにおけるバックスラッシュの入力方法](https://qiita.com/miyohide/items/6cb8967282d4b2db0f61)を確認して ¥ -> \ にしておく
    - Chromeインストール
        - Bitwardenの拡張インストール
        - Vimiumのインストール
- HHKBの接続設定
    - https://www.karakaram.com/switching-hhkb-hybrid-bluetooth-connection/
- GitHubの設定
    - SSH
        - [ここを見る](https://qiita.com/shizuma/items/2b2f873a0034839e47ce)
    - 仕事用環境の場合dotfilesは`git config --local`で設定しとく(それ以外は--globalでも良さそう)

