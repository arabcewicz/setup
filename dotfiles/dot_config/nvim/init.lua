vim.g.mapleader = " "

P = function(v)
  print(vim.inspect(v))
  return v
end

vim.keymap.set('n', '<leader><leader>f', '<cmd>luafile %<cr>')

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

local opts = {
  ui = {
    border = "single"
  },
  change_detection = {
    notify = false,
  },
}
require("lazy").setup("main/plugins", opts)
