return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
  },
  config = function()
    require('neogit').setup()
    require('legendary').keymaps({
      {
        '<leader>ro',
        ":DiffviewOpen<CR>",
        description = "diffview: Open diff view"
      },
      {
        '<leader>rq',
        ":DiffviewClose<CR>",
        description = "diffview: Close diff view"
      },
      {
        '<leader>rr',
        ":DiffviewRefresh<CR>",
        description = "diffview: Refresh diff view"
      },
      {
        '<leader>rh',
        ":DiffviewFileHistory %<CR>",
        description = "diffview: Show current file history"
      },
      {
        '<leader>rl',
        ":DiffviewFileHistory<CR>",
        description = "diffview: Show git log"
      },
    })
  end
}
