-- 24bitカラーを有効にする
-- felineにいる
vim.o.termguicolors = true

require('plugins')

-- カラースキーム
vim.cmd("colorscheme nightfox")

-- jjでNormalモード
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })
-- 行番号表示
vim.wo.number = true
-- クリップボードにコピー
vim.o.clipboard = 'unnamedplus'
-- 文字コード
vim.o.encoding = 'utf-8'
-- ハイライト
vim.o.cursorline = true
-- スペルチェック
vim.wo.spell = true
vim.bo.spelllang = 'en,cjk'
-- 折り返さない
vim.o.wrap = false
-- フォント
vim.opt.guifont = { "HackGen35Nerd Console", "h14" }

-- ステータスバー
-- ファイル名表示
-- vim.o.statusline = '%F'
-- 変更チェック表示
-- vim.o.statusline = vim.o.statusline..'%m'
-- -- 読み込み専用かどうか表示
-- vim.o.statusline = vim.o.statusline..'%r'
-- -- ヘルプページなら[HELP]と表示
-- vim.o.statusline = vim.o.statusline..'%h'
-- -- プレビューウィンドウ奈良[Preview]と表示
-- vim.o.statusline = vim.o.statusline..'%w'
-- -- これ以降は右寄せ表示
-- vim.o.statusline = vim.o.statusline..'%='
-- -- ファイルエンコーディング
-- vim.o.statusline = vim.o.statusline..'[ENC=%{&fileencoding}]'
-- -- 現在行数/全行数
-- vim.o.statusline = vim.o.statusline..'[LOW=%l/%L]'
-- -- ステータスラインを常に表示
vim.o.laststatus = 2

-- インデント
-- 改行する前のインデントを計測
vim.o.autoindent = true
-- 次のインデントを自動調整
vim.o.smartindent = true
-- 高度な自動インデント
vim.o.smarttab = true
-- スペースを使う
vim.o.expandtab = true
-- タブ使用時のスペースの数
vim.o.tabstop = 4
-- スペースの数
vim.o.shiftwidth = 4

