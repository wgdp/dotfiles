-- lazy.nvim初期インストール用
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
    -- ハイライトなどの強化
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
    -- Git周り
    'APZelos/blamer.nvim', 
    -- Gitのコミット履歴を行ごとに表示できるやつ
    'airblade/vim-gitgutter', 
    -- use 'lambdalisue/fern.vim' -- ファイラ
    -- ステータスラインカスタマイズ
    {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    },
    -- カッコ補完等
    'cohama/lexima.vim',
    -- vim上からコマンド実行できるやつ
    -- use 'thinca/vim-quickrun'
    -- nvim-lsp
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- lspの表示を立地にするやつ
    {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        local saga = require("lspsaga")

        -- saga.init_lsp_saga({
        --     -- your configuration
        -- })
    end,
    },
    -- スニペット
    "L3MON4D3/LuaSnip",
    "onsails/lspkind-nvim",
    -- 補完
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    -- ファインダー
    'nvim-lua/plenary.nvim', -- require
    'nvim-telescope/telescope.nvim',
    -- テーマ
    "EdenEast/nightfox.nvim",
    -- webアイコン設定用
    'kyazdani42/nvim-web-devicons',
    -- git周りの表現改善
    {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('gitsigns').setup()
        end
    },

    -- コメントアウト
    "tyru/caw.vim",
    -- デバッガ
    "mfussenegger/nvim-dap", -- require
    {
        "rcarriga/nvim-dap-ui",
        config = function ()
            vim.fn.sign_define('DapBreakpoint', {text='', texthl='', linehl='', numhl=''})
            vim.fn.sign_define('DapStopped', {text='🔴', texthl='', linehl='', numhl=''})
            require('dapui').setup()
            require('dap.ext.vscode').load_launchjs()
        end
    },
    -- ジャンプ
    {
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    },
    -- goimports 自動でやってくれるやつ
    "mattn/vim-goimports",
    -- d2
    "terrastruct/d2-vim",
})

-- プラグインを追加する際はこの中に書く

require('modules/lsp')
require('modules/cmp')
require('modules/hop')
require('modules/treesitter')
require('modules/telescope')
require('modules/blamer')
require('modules/lualine')
require('modules/vim-goimports')
require('modules/dap')
