return {
  "mhanberg/output-panel.nvim",
  event = "VeryLazy",
  config = function()
    require("output_panel").setup()
    require('legendary').keymaps({
      {
        '<A-o>',
        ":OutputPanel<CR>",
        description = "output-panel: Toggle output panel (lsp server logs)",
      },
    })
  end
}