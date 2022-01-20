-- 多分packerがインストールされてなかったらインストールするやつ
local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

-- プラグインを追加する際はこの中に書く
require'packer'.startup(function()
    -- プラグイン管理ツール
    use {'wbthomason/packer.nvim', opt = true}
    -- ハイライトなどの強化
    use {'nvim-treesitter/nvim-treesitter', run  = ':TSUpdate'}

    -- use {'neoclide/coc.nvim', branch = 'release'}
    -- Git周り
    use 'APZelos/blamer.nvim'
    -- Gitのコミット履歴を行ごとに表示できるやつ
    use 'airblade/vim-gitgutter'
    -- ファイラ
    use 'lambdalisue/fern.vim'
    -- ステータスラインカスタマイズ
    -- use 'itchyny/lightline.vim'
    -- カッコ補完等
    use 'cohama/lexima.vim'
    -- vim上からコマンド実行できるやつ
    use 'thinca/vim-quickrun'
    -- nvim-lsp
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    -- 補完 
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-vsnip"
    use "hrsh7th/cmp-buffer"
    -- ファインダー
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- スニペット
    use "hrsh7th/vim-vsnip"
    -- テーマ
    use 'EdenEast/nightfox.nvim'
    -- wakatime
    use 'wakatime/vim-wakatime'

    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- 多分neovim起動時に自動でpacker compileしてくれるやつ
vim.cmd([[autocmd BufWritePost init.lua source <afile> | PackerCompile]])

-- lsp周りのキー設定
-- 各操作に関しては以下の公式ドキュメントに書いてあるっぽい
-- https://neovim.io/doc/user/lsp.html
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  -- カーソル下のシンボルの定義元にジャンプ(公式ドキュメントによると実装してないlspが多いため通常はdefinitionを使うのが良さそう？)
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- カーソル下のシンボルの定義元にジャンプ
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  -- カーソル下の関数とかの詳細を表示する
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- 使用先ジャンプ。pyrightでは対応してなくて使えないっぽい。。。
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- シグネチャヘルプ
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- パスを入力して、入力したパス配下のフォルダーをワークスペースに追加する。
  -- 実行するとパスの入力を求められるやつ。
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- パスを入力して、入力したパス配下のフォルダーをワークスペースから削除する。
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- 現在のワークスペースをリスト表示する。
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  -- カーソル下の変数の型の定義元にジャンプする。
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  -- カーソルの下のシンボルのすべての参照元ごと名前を変更する。便利そう。
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  -- 現在のカーソル位置で使用可能なコードアクション？を選択できるらしい。使い方は現状不明
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- カーソル下のシンボルのすべての参照を表示する。
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- 行のエラーとか表示
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  -- 一個前のエラーに移動
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  -- 一個先のエラーに移動
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  -- エラーメッセージをロケーションリストに追加する
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  -- フォー待ったー
  buf_set_keymap("n", "<space>for", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    opts.on_attach = on_attach

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
    opts.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
end)

vim.opt.completeopt = "menu,menuone,noselect"

-- 補完ツールの設定
local cmp = require"cmp"
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  })
})

-- lspのメッセージ表示設定
vim.diagnostic.config({
  virtual_text = true, -- そのまま右側に出てくるのがうざいのでオフにする
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

local markdown = {
  lintCommand = "npx --no-install textlint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m [%trror/%r]"}
}

local language_settings = {
    markdown = {markdown},
}

-- textlintをefm-langserver(汎用LSP)で動かす用の設定
-- efm-langserverを事前にインストールしておく
-- LspInstallでefmをインストールするとバグるので、brewやgo get等でインストールする。
require("lspconfig")["efm"].setup {
    filetypes = {"markdown"},
    settings = {
        rootMarkers = {".textlintrc"},
        languages = language_settings
    }
}
