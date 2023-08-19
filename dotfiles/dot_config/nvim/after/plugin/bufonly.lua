local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<M-S-w>', ":BufOnly<CR>", opts)
