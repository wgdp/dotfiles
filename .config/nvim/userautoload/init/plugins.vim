call plug#begin('~/.local/share/nvim/plugged')
" coc.vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 曖昧ファイル検索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" 括弧補完
Plug 'cohama/lexima.vim'
" カラースキーム
Plug 'arcticicestudio/nord-vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" Git Blame
Plug 'APZelos/blamer.nvim'
" 差分表示
Plug 'airblade/vim-gitgutter'
" ファイラー
Plug 'lambdalisue/fern.vim'
" ステータスライン
Plug 'itchyny/lightline.vim'
" Zen Mode!!
Plug 'junegunn/goyo.vim'
" Nim
Plug 'alaviss/nim.nvim'
call plug#end()
