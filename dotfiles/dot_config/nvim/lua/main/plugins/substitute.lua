return {
  'gbprod/substitute.nvim',
  config = function()
    require("substitute").setup({
      highlight_substituted_text = {
        enabled = true,
        timer = 300,
      },
      on_substitute = require("yanky.integration").substitute(),
    })

    local opts = { noremap = true, silent = true }
    require("legendary").keymaps({
      {
        "s",
        -- "gr", -- doesn't work, hmm
        { n = require('substitute').operator, x = require('substitute').visual },
        description = "substitue: Operator",
        opts = opts,
      },
      {
        -- "grr",
        "ss",
        require('substitute').line,
        description = "substitue: Line",
        opts = opts,
      },
      {
        -- "gR",
        "S",
        require('substitute').eol,
        description = "substitue: eol",
        opts = opts,
      },
    })
    -- vim.keymap.set("n", "<leader>s", require('substitute.range').operator, { noremap = true })
    -- vim.keymap.set("x", "<leader>s", require('substitute.range').visual, { noremap = true })
    -- vim.keymap.set("n", "<leader>ss", require('substitute.range').word, { noremap = true })
  end
}
