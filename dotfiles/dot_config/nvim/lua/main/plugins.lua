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

local plugins = {
  { "ellisonleao/gruvbox.nvim", config = function() vim.cmd([[ colorscheme gruvbox ]]) end },
  { "b3nj5m1n/kommentary", keys = { "<C-_>", "<Plug>kommentary_line_defaul", mode = "n" } }
  --[[ { "b3nj5m1n/kommentary", config = function()
      vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_defaul", {})
    end
  } ]]

}

local opts = {}
require("lazy").setup(plugins, opts)

