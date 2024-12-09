return {
  "NeogitOrg/neogit",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration
  },
  config = function()
    require('diffview').setup({
      default_args = {
        DiffviewOpen = { "--imply-local" }
      },
      keymaps = {
        view = {
          {
            "n", "<A-]>",
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
            "n", "<A-[>",
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
      }
    })

    require('neogit').setup()
    local opts = { noremap = true, silent = true }
    require('legendary').keymaps({
      {
        '<leader>rr',
        ":Neogit<CR>",
        description = "neogit: Open",
        opts,
      },
      {
        '<leader>ro',
        ":DiffviewOpen<CR>:winc 2l<CR>",
        -- function()
        --   vim.cmd("DiffviewOpen")
        --   vim.cmd("norm! winc l")
        --   vim.cmd("norm! winc l")
        -- end,
        description = "diffview: Open diff view",
        opts,
      },
      {
        '<leader>rq',
        ":DiffviewClose<CR>",
        description = "diffview: Close diff view",
        opts,
      },
      -- {
      --   '<leader>rr',
      --   ":DiffviewRefresh<CR>",
      --   description = "diffview: Refresh diff view",
      -- opts,
      -- },
      {
        '<leader>rh',
        ":DiffviewFileHistory %<CR>",
        description = "diffview: Show current file history",
        opts,
      },
      {
        '<leader>rl',
        ":DiffviewFileHistory<CR>",
        description = "diffview: Show git log",
        opts,
      },
      -- {
      --   '<A-[>',
      --   "[c",
      --   description = "previous chunk",
      --   opts,
      -- },
      -- {
      --   '<A-]>',
      --   "]c",
      --   description = "next chunk",
      --   opts,
      -- },
      {
        '<A-d>',
        ":DiffviewOpen HEAD --selected-file=% --imply-local<CR>:DiffviewToggleFiles<CR>",
        description = "diffview: Open with current file selected",
        opts,
      },

    })
  end
}
