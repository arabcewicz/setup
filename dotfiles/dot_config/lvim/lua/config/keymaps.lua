-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move to window using the <ctrl> hjkl keys
vim.keymap.del("n", "<C-h>", { desc = "Go to Left Window", remap = true })
vim.keymap.del("n", "<C-j>", { desc = "Go to Lower Window", remap = true })
vim.keymap.del("n", "<C-l>", { desc = "Go to Right Window", remap = true })
vim.keymap.del("n", "<C-k>", { desc = "Go to Upper Window", remap = true })
vim.keymap.del("i", "<M-j>")
vim.keymap.del("v", "<M-j>")
vim.keymap.del("i", "<M-k>")
vim.keymap.del("v", "<M-k>")
-- Move Lines
vim.keymap.set("n", "<C-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<C-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" }) -- TODO: it's overriten somewhere
vim.keymap.set("v", "<C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
