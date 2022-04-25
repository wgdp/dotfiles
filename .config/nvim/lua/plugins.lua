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
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    -- Git周り
    use 'APZelos/blamer.nvim'
    -- Gitのコミット履歴を行ごとに表示できるやつ
    use 'airblade/vim-gitgutter'
    -- ファイラ
    use 'lambdalisue/fern.vim'
    -- ステータスラインカスタマイズ
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- カッコ補完等
    use 'cohama/lexima.vim'
    -- vim上からコマンド実行できるやつ
    use 'thinca/vim-quickrun'
    -- nvim-lsp
    use "neovim/nvim-lspconfig"
    use "williamboman/nvim-lsp-installer"
    -- スニペット
    use "hrsh7th/vim-vsnip"
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
    -- テーマ
    use "EdenEast/nightfox.nvim"
    -- wakatime
    use "wakatime/vim-wakatime"
    -- webアイコン設定用
    use 'kyazdani42/nvim-web-devicons'
    -- git周りの表現改善
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    }
    
    -- デバッガ
    use {
        "rcarriga/nvim-dap-ui",
        requires = {
            "mfussenegger/nvim-dap",
            "leoluz/nvim-dap-go",
        },
        config = function ()
            vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapStopped', {text='🔴', texthl='', linehl='', numhl=''})
            require('dapui').setup()
            require('dap-go').setup()
            require('dap.ext.vscode').load_launchjs()
        end
    }
end)


-- 自動でpacker compileしてくれるやつ
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


-- markdownのlint用。
local markdown = {
  lintCommand = "npx --no-install textlint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m [%trror/%r]"}
}

local language_settings = {
    markdown = {markdown},
}

-- lsp installer
-- nvim-lsp-installer経由でインストールする場合は、lspconfigではなこちらにlspの設定書くとcmdとかを自動設定してくれるのでこっちに書く
local pid = vim.fn.getpid()
local enhance_server_opts = {
    ["sumneko_lua"] = function(opts)    -- luaのlsp。vimとuseの警告がうるさいので除外している
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim", "use"}
                }
            }
        }
    end,
    ["efm"] = function(opts)
        opts.settings = {
            filetypes = {"markdown"},
            settings = {
                rootMarkers = {".textlintrc"},
                languages = language_settings
            }
        }
    end,
    ["omnisharp"] = function(opts)
        opts.cmd = {
            "/Users/shiraga-t/.local/share/nvim/lsp_servers/omnisharp/omnisharp/run",
            "--languageserver",
            "--hostPID",
            tostring(pid)
	}
        opts.root_dir = require("lspconfig").util.root_pattern("*.csproj","*.sln")
    end
}

-- nvim-lsp-installerのセットアップ
local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    -- キーコンフィグとか前で定義したやつを入れる
    opts.on_attach = on_attach

    if enhance_server_opts[server.name] then
        enhance_server_opts[server.name](opts)
    end
    opts.capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
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
  virtual_text = false,  -- 右側にそのまま出てくるやつ。割とうるさいのでうるさすぎるようならfalseにする。
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- エラー時のアイコン
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- エラーメッセージをホバーウィンドウに表示
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- 保存時にgo fmtを実行
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit)
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.cmd("autocmd BufWritePre *.go lua OrgImports(1000)")

