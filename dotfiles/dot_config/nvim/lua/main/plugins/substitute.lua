require("substitute").setup({
  highlight_substituted_text = {
    enabled = true,
    timer = 300,
  },
  on_substitute = require("yanky.integration").substitute(),
})

require("legendary").keymaps({
  {
    "s",
    { n = require('substitute').operator, x = require('substitute').visual },
    description = "substitue: Operator",
  },
  {
    "ss",
    require('substitute').line,
    description = "substitue: Line",

  },
  {
    "S",
    require('substitute').eol,
    description = "substitue: eol",
  },
})
-- vim.keymap.set("n", "<leader>s", require('substitute.range').operator, { noremap = true })
-- vim.keymap.set("x", "<leader>s", require('substitute.range').visual, { noremap = true })
-- vim.keymap.set("n", "<leader>ss", require('substitute.range').word, { noremap = true })
