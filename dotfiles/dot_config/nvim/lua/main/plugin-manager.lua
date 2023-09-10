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
  -- basics
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { "gruvbox-community/gruvbox" },

  -- tools
  {
    'mrjones2014/legendary.nvim',
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },
  { 'rmagatti/auto-session' },


  -- editing
  { 'gbprod/yanky.nvim' },
  { 'gbprod/substitute.nvim' },
  { 'fedepujol/move.nvim' },
  {
    "mg979/vim-visual-multi",
    -- bindings has to be set before plugin is loaded
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ['Find Under']         = '<M-n>',
        ['Find Subword Under'] = '<M-n>',
        ['Remove Region']      = '<M-p>',
        ['Select All']         = '<M-S-n>',
        ['Start Regex Search'] = '<M-/>',
        ['Add Cursor Down']    = '<C-S-j>',
        ['Add Cursor Up']      = '<C-S-k>',
        ['Skip Region']        = '<M-b>',
      }
    end,
  },
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
  -- { "SmiteshP/nvim-navic" },
  { 'mrjones2014/smart-splits.nvim' },
  { 'akinsho/bufferline.nvim',            version = "*" },
  { "lukas-reineke/indent-blankline.nvim" },
  { 'yamatsum/nvim-cursorline' },
  { 'rcarriga/nvim-notify' },
  { 'levouh/tint.nvim' }, -- dim inactive window
  {
    "nvim-zh/colorful-winsep.nvim",
    config = true,
    event = { "WinNew" },
  },

  -- navigation
  { 'nvim-telescope/telescope.nvim',              tag = '0.1.1' },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { 'nvim-telescope/telescope-ui-select.nvim' }, -- more UI section
  { 'ThePrimeagen/harpoon' },
  { 'famiu/bufdelete.nvim' },
  { 'vim-scripts/BufOnly.vim' },

  -- git
  { 'sindrets/diffview.nvim' },
  { "NeogitOrg/neogit" },

  -- treesitter
  { "nvim-treesitter/nvim-treesitter",            build = ":TSUpdate" },
  { 'nvim-treesitter/playground' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },

  -- programming
  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },
  -- programming: completion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- programming: lsp
  { "neovim/nvim-lspconfig" },
  { "scalameta/nvim-metals" },
  { "mfussenegger/nvim-dap" },
  { 'onsails/lspkind-nvim' },

  -- note taking
  { 'renerocksai/telekasten.nvim' },
  { 'epwalsh/obsidian.nvim' },
}


local opts = {
  ui = {
    border = "single"
  }
}
require("lazy").setup(plugins, opts)
