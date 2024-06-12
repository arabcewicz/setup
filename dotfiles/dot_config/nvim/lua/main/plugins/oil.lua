return {
  'stevearc/oil.nvim',
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true,

      },
    })

    require('legendary').keymaps({
      {
        '<A-e>',
        ":Oil<CR>",
        description = "oil: Start in normal windows",
      },
      {
        '<S-A-e>',
        ":Oil --float<CR>",
        description = "oil: Start in floating windows",
      },
    })
  end,

  dependencies = { "nvim-tree/nvim-web-devicons" },
}
