return {
  'rcarriga/nvim-notify',
  enabled = false,
  config = function()
    require("notify").setup({
      -- background_colour = "#000000",
      -- timeout = 2000,
      stages = 'static',
      top_down = false,

    })
    vim.notify = require("notify")

    -- require('legendary').keymaps({
    --   {
    --     "<leader>fn",
    --     ":Telescope notify<CR>",
    --     description = "notify: List recent notifications"
    --   },
    -- })
  end
}
