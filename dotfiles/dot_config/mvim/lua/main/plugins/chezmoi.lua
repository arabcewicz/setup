return {

  -- explodes, try it later
  -- "andre-kotake/nvim-chezmoi",
  -- dependencies = {
  --   { "nvim-lua/plenary.nvim" },
  --   { "nvim-telescope/telescope.nvim" },
  -- },
  -- opts = {
  --   source_path = "",
  --   -- Your custom config
  -- },
  -- priority = 10,
  -- config = function(_, opts)
  --   require("nvim-chezmoi").setup(opts)
  -- end,

  'xvzc/chezmoi.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require("chezmoi").setup {
      -- your configurations
    }
  end,
  init = function()
    -- run chezmoi edit on file enter
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { os.getenv("HOME") .. "/setup/dotfiles/*" },
      callback = function()
        vim.schedule(require("chezmoi.commands.__edit").watch)
      end,
    })
  end,
}
