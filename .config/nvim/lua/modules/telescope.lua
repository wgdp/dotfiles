require('telescope').setup{
    file_ignore_patterns = {
        "^node_modules/",
        "^vendor/"
    }

}
vim.api.nvim_set_keymap('n', '<space>f', '<Cmd>Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>r', '<Cmd>Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<space>h', '<Cmd>Telescope buffers<CR>', { noremap = true, silent = true })
