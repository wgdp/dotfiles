" クリップボードにコピー
set clipboard=unnamedplus
" Nomarlモードへ切り替え
inoremap <silent> jj <ESC>
" 行番号表示
set number
" スベースを使う
set expandtab
" スペースの数
set shiftwidth=4
" 文字コード
set encoding=utf-8

" 設定読み込み
runtime! userautoload/init/*.vim
runtime! userautoload/plugins/*.vim
