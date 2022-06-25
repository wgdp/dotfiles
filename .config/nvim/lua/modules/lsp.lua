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
        vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.cmd("autocmd BufWritePre *.go lua OrgImports(1000)")
