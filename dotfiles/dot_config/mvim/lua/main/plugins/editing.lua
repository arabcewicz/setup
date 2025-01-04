return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {}
  },
  {
    'gbprod/substitute.nvim',
    opts = {
      highlight_substituted_text = {
        enabled = true,
        timer = 300,
      },
      on_substitute = function() require("yanky.integration").substitute() end,
    },
    keys = {
      { "gr",  function() require('substitute').operator() end, desc = "substitue: Operator" },
      { "grr", function() require('substitute').line() end,     desc = "substitue: Line" },
      { "gR",  function() require('substitute').eol() end,      desc = "substitue: eol" },
    },
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
      { "<A-/>", function() require('flash').jump() end,       mode = { "n", "x", "o" }, desc = "flash: Flash" },
      { "<A-v>", function() require('flash').treesitter() end, mode = { "n", "x", "o" }, desc = "flash: Treesitter" },
    }
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = false,
    opts = {
      keymaps = {
        useDefaults = true
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    -- bindings has to be set before plugin is loaded
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ['Find Under']         = '<M-n>',
        ['Find Subword Under'] = '<M-n>',
        ['Remove Region']      = '<M-p>',
        ['Select All']         = '<M-S-n>',
        ['Start Regex Search'] = '<M-/>',
        ['Add Cursor Down']    = '<C-S-j>',
        ['Add Cursor Up']      = '<C-S-k>',
        ['Skip Region']        = '<M-b>',
      }
    end,
  },
  {
    'fedepujol/move.nvim',
    opts = {
      line = {
        enable = true, -- Enables line movement
        indent = true  -- Toggles indentation
      },
      block = {
        enable = true, -- Enables block movement
        indent = true  -- Toggles indentation
      },
      word = {
        enable = true, -- Enables word movement
      },
      char = {
        enable = true -- Enables char movement
      }
    },
    keys = {
      { '<C-j>',      ':MoveLine(1)<CR>',    desc = "move: Move line down" },
      { '<C-k>',      ':MoveLine(-1)<CR>',   desc = "move: Move line up" },
      { '<C-h>',      ':MoveHChar(-1)<CR>',  desc = "move: Move char left" },
      { '<C-l>',      ':MoveHChar(1)<CR>',   desc = "move: Move char right" },
      { '<leader>wf', ':MoveWord(1)<CR>',    desc = "move: Move word forward" },
      { '<leader>wb', ':MoveWord(-1)<CR>',   desc = "move: Move work backward" },
      { '<C-j>',      ':MoveBlock(1)<CR>',   desc = "move: Move selected block up",    mode = "v" },
      { '<C-k>',      ':MoveBlock(-1)<CR>',  desc = "move: Move selected block down",  mode = "v" },
      { '<C-h>',      ':MoveHBlock(-1)<CR>', desc = "move: Move selected block left",  mode = "v" },
      { '<C-l>',      ':MoveHBlock(1)<CR>',  desc = "move: Move selected block right", mode = "v" },
    }
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
  }
}
