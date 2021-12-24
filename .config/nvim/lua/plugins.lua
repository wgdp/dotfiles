vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    
    use {'neoclide/coc.nvim', branch = 'release'}
    use 'APZelos/blamer.nvim'
    use 'airblade/vim-gitgutter'
    use 'lambdalisue/fern.vim'
    use 'itchyny/lightline.vim'
    use 'cohama/lexima.vim'
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'EdenEast/nightfox.nvim'
end)
