return {
  "mhanberg/output-panel.nvim",
  event = "VeryLazy",
  enabled = false,
  config = function()
    require("output_panel").setup()
    require('legendary').keymaps({
      {
        '<A-|>',
        ":OutputPanel<CR>",
        description = "output-panel: Toggle output panel (lsp server logs)",
      },
    })
  end
}
