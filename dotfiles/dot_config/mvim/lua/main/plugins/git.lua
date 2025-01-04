return {
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          -- map('n', ']c', function()
          map('n', '<A-]>', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end)

          -- map('n', '[c', function()
          map('n', '<A-[>', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end)

          -- Actions
          map('n', '<leader>hs', gitsigns.stage_hunk)
          map('n', '<leader>hr', gitsigns.reset_hunk)
          map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<leader>hS', gitsigns.stage_buffer)
          map('n', '<leader>hu', gitsigns.undo_stage_hunk)
          map('n', '<leader>hR', gitsigns.reset_buffer)
          map('n', '<leader>hp', gitsigns.preview_hunk)
          map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
          map('n', '<leader>hd', gitsigns.diffthis)
          map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
          map('n', '<leader>td', gitsigns.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
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
