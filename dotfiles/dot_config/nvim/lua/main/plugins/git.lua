return {
  {
    "echasnovski/mini-git",
    version = "*",
    main = 'mini.git',
    opts = {},
  },
  {
    "echasnovski/mini.diff",
    version = "*",
    opts = {},
  },
  -- {
  --   "NeogitOrg/neogit",
  --   enabled = false,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",  -- required
  --     "sindrets/diffview.nvim", -- optional - Diff integration
  --   },
  --   config = function()
  --     require('neogit').setup()
  --     local opts = { noremap = true, silent = true }
  --     require('legendary').keymaps({
  --       {
  --         '<leader>rr',
  --         ":Neogit<CR>",
  --         description = "neogit: Open",
  --         opts,
  --       },
  --
  --     })
  --   end
  -- },

  {
    "sindrets/diffview.nvim",
    enabled = true,
    opts = {
      default_args = {
        DiffviewOpen = { "--imply-local" },
      },
      keymaps = {
        view = {
          {
            "n",
            "<A-]>",
            function()
              local cursor = vim.api.nvim_win_get_cursor(0)
              vim.cmd("norm! ]c")
              if cursor[1] == vim.api.nvim_win_get_cursor(0)[1] then
                -- The cursor didn't move: go to the next entry
                require("diffview.actions").select_next_entry()
              end
            end,
          },
          {
            "n",
            "<A-[>",
            function()
              local cursor = vim.api.nvim_win_get_cursor(0)
              vim.cmd("norm! [c")
              if cursor[1] == vim.api.nvim_win_get_cursor(0)[1] then
                -- The cursor didn't move: go to the prev entry
                require("diffview.actions").select_prev_entry()
              end
            end,
          },
        },
      },
    },
    keys = {
      {
        "<leader>ro",
        ":DiffviewOpen<CR>:winc 2l<CR>",
        desc = "diffview: Open diff view",
      },
      {
        "<leader>rq",
        ":DiffviewClose<CR>",
        desc = "diffview: Close diff view",
      },
      {
        "<leader>rh",
        ":DiffviewFileHistory %<CR>",
        desc = "diffview: Show current file history",
      },
      {
        "<leader>rl",
        ":DiffviewFileHistory<CR>",
        desc = "diffview: Show git log",
      },
      {
        "<A-d>",
        ":DiffviewOpen HEAD --selected-file=% --imply-local<CR>:DiffviewToggleFiles<CR>",
        desc = "diffview: Open with current file selected",
      },
      -- { '<leader>rr', ":DiffviewRefresh<CR>", desc = "diffview: Refresh diff view" },
    },
  },
}
