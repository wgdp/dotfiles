local dap = require("dap")
dap.adapters.go = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = {'dap', '-l', '127.0.0.1:${port}'},
    }
}

-- nvim-dapデバッガ起動
vim.api.nvim_set_keymap("n", "<space>dc", ":lua require'dap'.continue()<CR>", { silent = true})
-- nvim-dapデバッガ情報表示切り替え
vim.api.nvim_set_keymap("n", "<space>dt", ":lua require'dapui'.toggle()<CR>", { silent = true})
-- ブレークポイント設置
vim.api.nvim_set_keymap("n", "<space>db", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true})
