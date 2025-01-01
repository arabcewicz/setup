return {
  {
    "j-hui/fidget.nvim",
    enabled = true,
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      }
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = true,
    main = "ibl",
    opts = {},
    -- config = function()
    --   vim.opt.list = true
    --   vim.opt.listchars:append "eol:?"
    --
    --   require("ibl").setup {
    --   }
    -- end
  },
  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
      require("output_panel").setup()
      require('legendary').keymaps({
        {
          '<A-|>',
          ":OutputPanel<CR>",
          description = "output-panel: Toggle output panel (lsp server logs)",
        },
      })
    end
  },

  {
    "rmagatti/goto-preview",
    enabled = true,
    config = function()
      require("goto-preview").setup {
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true,                                        -- Focus the floating window when opening it.
        dismiss_on_move = false,                                     -- Dismiss the floating window when moving the cursor.
        force_close = true,                                          -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe",                                          -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true,                       -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
      }


      require("legendary").keymaps({
        {
          '<leader>pd',
          function() require('goto-preview').goto_preview_definition() end,
          description = "goto-preview: Preview definition"
        },
        {
          '<leader>pt',
          function() require('goto-preview').goto_preview_type_definition() end,
          description = "goto-preview: Preview type definition"
        },
        {
          '<leader>pi',
          function() require('goto-preview').goto_preview_implementation() end,
          description = "goto-preview: Preview implementation"
        },
        {
          '<leader>pD',
          function() require('goto-preview').goto_preview_declaration() end,
          description = "goto-preview: Preview declaration"
        },
        {
          '<leader>pq',
          function() require('goto-preview').close_all_win() end,
          description = "goto-preview: Close all preview windows"
        },
        {
          '<leader>pr',
          function() require('goto-preview').goto_preview_references() end,
          description = "goto-preview: Preview references"
        },
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = true,
    config = function()
      local function metals_status()
        return vim.g["metals_status"] or ""
      end

      -- local navic = require("nvim-navic")

      -- vim-visual-multi's status line doesn't work well with lualine, so disabling it
      vim.g.VM_set_statusline = 0 -- disable VM's statusline updates to prevent clobbering
      vim.g.VM_silent_exit = 1    -- because the status line already tells me the mode

      require('lualine').setup {
        options = {
          theme = "catppuccin",
          -- section_separators = '',
          -- component_separators = '',
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            'mode',
          },
          lualine_b = {
            -- 'buffers',
            'branch',
          },
          lualine_c = {
            {
              function() return require('possession.session').get_session_name() or '' end
            },
            -- "navic",
            metals_status,
            -- vim-visual-multi status line poor integration with lualine
            --[[ {
        function()
          if vim.b['visual_multi'] then
            local ret = vim.api.nvim_exec2('call b:VM_Selection.Funcs.infoline()', { output = true })
            print(ret.output)
            return string.match(ret.output, 'M.*')
          else
            return ''
          end
        end
      }, ]]
          },
          lualine_x = {
            {
              'filename',
              newfile_status = true,
              path = 0,
            },
            'filesize',
            'encoding',
            'fileformat',
            'filetype'
          },
          lualine_y = { 'branch', 'diff', 'diagnostics' },
          lualine_z = { 'progress', 'location', 'selectioncount' }
        },
        --[[ tabline = {
    lualine_c = { "buffers" }
  }, ]]
        -- extensions = { 'quickfix', 'nvim-tree' }

      }
    end
  },
}
