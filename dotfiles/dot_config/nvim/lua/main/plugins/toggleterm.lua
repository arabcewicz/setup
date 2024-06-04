return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = "<C-/>",
      hide_numbers = true,
      direction = "float",
    })

    local Terminal = require('toggleterm.terminal').Terminal
    local sbt      = Terminal:new({
      cmd = "sbt",
      count = 2,
      direction = "float",
    })

    require('legendary').keymaps({
      {
        '<A-Esc>',
        { t = [[<C-\><C-n>]] },
        description = "Exit terminal mode",
      },
      {
        '<A-b>',
        function() sbt:toggle() end,
        description = "Run sbt in dedicated terminal",
      },
    })
  end
}
