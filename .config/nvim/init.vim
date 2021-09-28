" 設定読み込み
runtime! userautoload/init/*.vim
runtime! userautoload/plugins/*.vim
" カラースキーム
syntax enable
colorscheme nord
" コメントの色が気に入らないので変更
hi Comment ctermfg=gray
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
" ハイライト
set cursorline

" ステータスバー
" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[LOW=%l/%L]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2
