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
  },
  {
    "mhanberg/output-panel.nvim",
    event = "VeryLazy",
    keys = {
      { '<A-|>', ":OutputPanel<CR>", desc = "output-panel: Toggle output panel (lsp server logs)" },
    }
  },

  {
    "rmagatti/goto-preview",
    opts =
    {
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
    },
    keys = {
      { '<leader>pd', function() require('goto-preview').goto_preview_definition() end,      desc = "goto-preview: Preview definition" },
      { '<leader>pt', function() require('goto-preview').goto_preview_type_definition() end, desc = "goto-preview: Preview type definition" },
      { '<leader>pi', function() require('goto-preview').goto_preview_implementation() end,  desc = "goto-preview: Preview implementation" },
      { '<leader>pD', function() require('goto-preview').goto_preview_declaration() end,     desc = "goto-preview: Preview declaration" },
      { '<leader>pq', function() require('goto-preview').close_all_win() end,                desc = "goto-preview: Close all preview windows" },
      { '<leader>pr', function() require('goto-preview').goto_preview_references() end,      desc = "goto-preview: Preview references" },
    }
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
            {
              function() return require 'jsonpath'.get() or '' end
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
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      {
        "<leader>fe",
        function()
          -- require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)",      remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
    },
    config = function(_, opts)
      -- local function on_move(data)
      --   Snacks.rename.on_rename_file(data.source, data.destination)
      -- end
      --
      -- local events = require("neo-tree.events")
      -- opts.event_handlers = opts.event_handlers or {}
      -- vim.list_extend(opts.event_handlers, {
      --   { event = events.FILE_MOVED,   handler = on_move },
      --   { event = events.FILE_RENAMED, handler = on_move },
      -- })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}
