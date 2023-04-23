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
  { "morhetz/gruvbox", config = function() vim.cmd([[ colorscheme gruvbox ]]) end },
  { "b3nj5m1n/kommentary", config = function()
      vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
      vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {})
    end
  },
  {
    "mg979/vim-visual-multi",
    config = function()
      vim.cmd([[ source keymaps.vim ]])
    end
  }

}

local opts = {}
require("lazy").setup(plugins, opts)

