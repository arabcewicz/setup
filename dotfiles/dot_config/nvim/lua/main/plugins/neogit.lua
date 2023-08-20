local neogit = require("neogit")

neogit.setup({
  kind = "tab",
  integrations = {
    -- If enabled, use telescope for menu selection rather than vim.ui.select.
    -- Allows multi-select and some things that vim.ui.select doesn't.
    telescope = true,
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
    -- The diffview integration enables the diff popup.
    --
    -- Requires you to have `sindrets/diffview.nvim` installed.
    diffview = true,
  },
})

require("legendary").keymaps({
  {
    '<leader>gg',
    ":Neogit<CR>",
    "neogit: Open Git console"
  },
  {
    '<leader>gl',
    ":Neogit log<CR>",
    "neogit: Open Git log"
  },
  {
    '<leader>gp',
    ":Neogit push<CR>",
    "neogit: Push changes to remote"
  },
})
