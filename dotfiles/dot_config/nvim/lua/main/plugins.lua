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
  -- basics
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { "gruvbox-community/gruvbox" },

  -- editing
  { "b3nj5m1n/kommentary" },
  { 'fedepujol/move.nvim' },
  { "mg979/vim-visual-multi" },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup({}) end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  { 'vim-scripts/argtextobj.vim' },
  -- { "kana/vim-textobj-user" }, -- required for textobj-entire
  -- { "kana/vim-textobj-entire",   depends = "kana/vim-textobj-user" },

  -- UI
  { 'nvim-lualine/lualine.nvim' },
  { "SmiteshP/nvim-navic" },
  { 'mrjones2014/smart-splits.nvim' },
  -- navigation
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
  },
  { 'ThePrimeagen/harpoon' },

  -- telescope
  { 'nvim-telescope/telescope.nvim',   tag = '0.1.1' },
  -- { "nvim-telescope/telescope-file-browser.nvim" },

  -- treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { 'nvim-treesitter/playground' },

  -- programming
  -- completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- lsp
  { "neovim/nvim-lspconfig" },
  { "scalameta/nvim-metals" },
  { "mfussenegger/nvim-dap" },
  { 'onsails/lspkind-nvim' },

  -- note taking
  { 'renerocksai/telekasten.nvim' },
  { 'epwalsh/obsidian.nvim' },
}


local opts = {}
require("lazy").setup(plugins, opts)
