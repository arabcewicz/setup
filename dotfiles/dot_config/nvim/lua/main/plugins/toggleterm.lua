return {
  'akinsho/toggleterm.nvim',
  enabled = true,
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = "<A-\\>",
      hide_numbers = true,
      direction = "float",
    })

    local Terminal = require('toggleterm.terminal').Terminal
    local sbt      = Terminal:new({
      cmd = "sbt",
      count = 2,
      direction = "float",
    })

    local lazygit  = Terminal:new({
      cmd = "lazygit",
      count = 0,
      hidden = true,
    })

    vim.keymap.set("t", [[<C-\><C-n>]], "<A-Esc>", { noremap = true, silent = true, desc = "Exit terminal mode" })
    vim.keymap.set("n", "<A-b>", function() sbt:toggle() end,
      { noremap = true, silent = true, desc = "Run sbt in dedicated terminal" })
    vim.keymap.set("n", "<A-r>", function() lazygit:toggle() end,
      { noremap = true, silent = true, desc = "Run lazygit in dedicated terminal" })
  end
}
