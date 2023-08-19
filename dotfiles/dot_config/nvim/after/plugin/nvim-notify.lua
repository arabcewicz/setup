require("notify").setup({
  -- background_colour = "#000000",
  timeout = 2000,
  stages = 'static',
  top_down = false,

})
vim.notify = require("notify")

vim.keymap.set("n", "<leader>fn", ":Telescope notify<CR>", { noremap = true, silent = true })
