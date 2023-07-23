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
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { "gruvbox-community/gruvbox" },
  { "b3nj5m1n/kommentary" },
  { 'fedepujol/move.nvim' },
  { "mg979/vim-visual-multi" },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.1' },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { 'renerocksai/telekasten.nvim' },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { 'nvim-treesitter/playground' },
  { 'ThePrimeagen/harpoon' },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "mfussenegger/nvim-dap" },
  { "scalameta/nvim-metals" },
}


local opts = {}
require("lazy").setup(plugins, opts)

