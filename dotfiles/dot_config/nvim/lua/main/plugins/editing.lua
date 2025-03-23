return {
  {
    'echasnovski/mini.ai',
    enabled = true,
    version = '*',
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          d = { "%f[%d]%d+" },                                                    -- digits
          e = {                                                                   -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line('$'),
              col = math.max(vim.fn.getline('$'):len(), 1)
            }
            return { from = from, to = to }
          end,
          u = ai.gen_spec.function_call(),                           -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    opts = {}
  },
  {
    'echasnovski/mini.operators',
    version = '*',
    opts = {},
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    opts = {},
  },
  {
    'echasnovski/mini.splitjoin',
    enabled = true,
    version = '*',
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- Created for both Normal and Visual modes.
      mappings = {
        toggle = 'gJ',
        split = '',
        join = '',
      },

      -- Detection options: where split/join should be done
      detect = {
        -- Array of Lua patterns to detect region with arguments.
        -- Default: { '%b()', '%b[]', '%b{}' }
        brackets = nil,

        -- String Lua pattern defining argument separator
        separator = ',',

        -- Array of Lua patterns for sub-regions to exclude separators from.
        -- Enables correct detection in presence of nested brackets and quotes.
        -- Default: { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
        exclude_regions = nil,
      },

      -- Split options
      split = {
        hooks_pre = {},
        hooks_post = {},
      },

      -- Join options
      join = {
        hooks_pre = {},
        hooks_post = {},
      },
    }
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    opts = {},
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          jump_labels = false
        }
      }
    },
    keys = {
      -- { "<A-/>", function() require('flash').jump() end,       mode = { "n", "x", "o" },                            desc = "flash: Flash" },
      { "<A-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "<A-S>", mode = { "n", "x", "o" }, function() require('flash').treesitter() end, desc = "flash: Treesitter" },
      -- { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    }
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = {
      keymaps = {
        useDefaults = false
      },
      textobjs = {
        subword = {
          noCamelToPascalCase = false,
        },
      },

    },
    keys = {
      { "ac", mode = { "o", "x" }, function() require("various-textobjs").subword("outer") end },
      { "ic", mode = { "o", "x" }, function() require("various-textobjs").subword("inner") end },
    }
  },
  {
    "mg979/vim-visual-multi",
    -- bindings has to be set before plugin is loaded
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ['Find Under']         = '<C-M-n>',
        ['Find Subword Under'] = '<C-M-n>',
        ['Remove Region']      = '<C-M-p>',
        ['Select All']         = '<C-M-a>',
        ['Start Regex Search'] = '<C-M-/>',
        ['Add Cursor Down']    = '<C-S-j>',
        ['Add Cursor Up']      = '<C-S-k>',
        ['Skip Region']        = '<C-M-x>',
      }
    end,
  },
  {
    'gbprod/yanky.nvim',
    event = "VeryLazy",
    config = function()
      -- has to be before setup; otherwise 'preserve_cursor_position' doesn't work
      vim.keymap.set({ "n", "x" }, "y", '<Plug>(YankyYank)')

      local mapping = require("yanky.telescope.mapping")
      require("yanky").setup({
        ring = {
          ignore_registers = { "_" },
        },
        picker = {
          telescope = {
            use_default_mappings = false,
            mappings = {
              default = mapping.put("p"),
              i = {
                ["<A-p>"] = mapping.put("p"),
                ["<A-S-p>"] = mapping.put("P"),
                ["<A-d>"] = mapping.delete(),
                ["<A-a>"] = mapping.set_register("a"),
                ["<A-b>"] = mapping.set_register("b"),
                ["<A-c>"] = mapping.set_register("c"),
              },
              n = {
                p = mapping.put("p"),
                P = mapping.put("P"),
                d = mapping.delete(),
                ra = mapping.set_register("a"),
                rb = mapping.set_register("b"),
                rc = mapping.set_register("c"),
              },
            }
          }
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = false,
          on_yank = true,
          timer = 300,
        },
        preserve_cursor_position = {
          enabled = true,
        },
      })
      require("telescope").load_extension("yank_history")
    end,
    keys = {
      { "y",         '<Plug>(YankyYank)',           desc = "yanky: Yank",                                         mode = { "n", "x" } },
      { 'p',         "<Plug>(YankyPutAfter)",       desc = "yanky: Put after cursor",                             mode = { 'n', 'x' } },
      { 'P',         "<Plug>(YankyPutBefore)",      desc = "yanky: Put before cursor",                            mode = { 'n', 'x' } },
      { 'gp',        "<Plug>(YankyGPutAfter)",      desc = "yanky: Put after cursor and leave the cursor after",  mode = { 'n', 'x' } },
      { 'gP',        "<Plug>(YankyGPutBefore)",     desc = "yanky: Put before cursor and leave the cursor after", mode = { 'n', 'x' } },
      { "<C-n>",     "<Plug>(YankyCycleForward)",   desc = "yanky: Cycle yank buffer forward" },
      { "<C-p>",     "<Plug>(YankyCycleBackward)",  desc = "yanky: Cycle yank buffer backward" },
      { "<space>fv", ":Telescope yank_history<CR>", desc = "yanky: List yank ring" },
    },
  },
  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    -- event = "LazyFile",
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end,              desc = "todo-comments: Next Todo Comment" },
      { "[t",         function() require("todo-comments").jump_prev() end,              desc = "todo-comments: Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                                   desc = "todo-comments: Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "todo-comments: Todo/Fix/Fixme (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>",                                         desc = "todo-comments: Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",                 desc = "todo-comments: Todo/Fix/Fixme" },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "grug-far: Search and Replace",
      },
    },
  },
  {
    "LunarVim/bigfile.nvim",
    enabled = true,
    opts = {
      filesize = 2,      -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = { "*" }, -- autocmd pattern or function see <### Overriding the detection of big files>
      features = {       -- features to disable
        "indent_blankline",
        "illuminate",
        "lsp",
        "treesitter",
        "syntax",
        "matchparen",
        "vimopts",
        -- "filetype",
      }
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        {
          "<leader>H",
          function()
            require("harpoon"):list():add()
          end,
          desc = "harpoon: Add file",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "harpoon: Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "harpoon: select file " .. i,
        })
      end
      return keys
    end,
  }
}
