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

vim.cmd [[
  let g:VM_maps                       = {}
  let g:VM_maps['Find Under']         = '<M-n>'
  let g:VM_maps['Find Subword Under'] = '<M-n>'
  let g:VM_maps['Select All']         = '<M-C-n>'
  let g:VM_maps['Start Regex Search'] = '<M-/>'
  let g:VM_maps["Add Cursor Down"]    = '<M-C-j>'
  let g:VM_maps["Add Cursor Up"]      = '<M-C-k>'
  let g:VM_maps["Skip Region"]        = '<M-x>'
]]

local plugins = {
  { "morhetz/gruvbox", config = function() vim.cmd([[ colorscheme gruvbox ]]) end },
  { "b3nj5m1n/kommentary", config = function()
      vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_line_default", {})
      vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {})
    end
  },
  { "mg979/vim-visual-multi" },
  { 'nvim-telescope/telescope.nvim',
     tag = '0.1.1',
     dependencies = { 'nvim-lua/plenary.nvim' },
     config = function()
       local builtin = require('telescope.builtin')
       vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
       vim.keymap.set('n', '<M-t>', builtin.find_files, {})
       vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
       vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
       vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
     end
  },
  { 'renerocksai/telekasten.nvim',
    dependencies = {'nvim-telescope/telescope.nvim'},
    config = function()
      require('telekasten').setup({
        -- home = vim.fn.expand("~/notes1"),
        home = vim.fn.expand("C:/Users/adamr/notes1"),
      })
    end
  },
}

local opts = {}
require("lazy").setup(plugins, opts)

