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

    -- コメントアウト
    use "tyru/caw.vim"
    
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

    -- ジャンプ
    use {
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }
end)

-- 自動でpacker compileしてくれるやつ
vim.cmd([[autocmd BufWritePost init.lua source <afile> | PackerCompile]])

require('modules/lsp')
require('modules/cmp')
require('modules/hop')
require('modules/treesitter')
require('modules/telescope')
require('modules/blamer')
require('modules/lualine')
require('dap-go').setup()

