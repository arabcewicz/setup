return {
  {
    'lewis6991/gitsigns.nvim',
    enabled = false,
    -- event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "<A-]>", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "<A-[>", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Prev Hunk")
        map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
        map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
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
    }
    ,
    keys = {
      { '<leader>ro', ":DiffviewOpen<CR>:winc 2l<CR>",                                                  desc = "diffview: Open diff view" },
      { '<leader>rq', ":DiffviewClose<CR>",                                                             desc = "diffview: Close diff view" },
      { '<leader>rh', ":DiffviewFileHistory %<CR>",                                                     desc = "diffview: Show current file history" },
      { '<leader>rl', ":DiffviewFileHistory<CR>",                                                       desc = "diffview: Show git log" },
      { '<A-d>',      ":DiffviewOpen HEAD --selected-file=% --imply-local<CR>:DiffviewToggleFiles<CR>", desc = "diffview: Open with current file selected" },
      -- { '<leader>rr', ":DiffviewRefresh<CR>", desc = "diffview: Refresh diff view" },
    }
  }
}
