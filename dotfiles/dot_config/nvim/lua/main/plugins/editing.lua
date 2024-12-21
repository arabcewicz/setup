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
    config = function()
      require("nvim-surround").setup({
      })
    end
  },
  {
    'gbprod/substitute.nvim',
    config = function()
      require("substitute").setup({
        highlight_substituted_text = {
          enabled = true,
          timer = 300,
        },
        on_substitute = require("yanky.integration").substitute(),
      })

      local opts = { noremap = true, silent = true }
      require("legendary").keymaps({
        {
          "gr",
          { n = require('substitute').operator },
          description = "substitue: Operator",
          opts = opts,
        },
        {
          "grr",
          require('substitute').line,
          description = "substitue: Line",
          opts = opts,
        },
        {
          "gR",
          require('substitute').eol,
          description = "substitue: eol",
          opts = opts,
        },
      })
    end
  },

  {
    "folke/flash.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      require("flash").setup({
        modes = {
          char = {
            jump_labels = false
          }
        }
      })

      require("legendary").keymaps({
        {
          "<A-/>",
          {
            n = function() require('flash').jump() end,
            x = function() require('flash').jump() end,
            o = function() require('flash').jump() end
          },
          description = "flash: Flash",
        },
        {
          "<A-v>",
          {
            n = function() require('flash').treesitter() end,
            x = function() require('flash').treesitter() end,
            o = function() require('flash').treesitter() end
          },
          description = "flash: Treesitter",
        },
      })
    end
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    enabled = true,
    lazy = false,
    opts = {
      keymaps = {
        useDefaults = true
      },
    },
  },
  {
    "mg979/vim-visual-multi",
    enabled = true,
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
    enabled = true,
    config = function()
      require('move').setup({
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
      })

      require('legendary').keymaps({
        {
          '<C-j>',
          ':MoveLine(1)<CR>',
          description = "move: Move line down"
        },
        {
          '<C-k>',
          ':MoveLine(-1)<CR>',
          description = "move: Move line up"
        },
        {
          '<C-h>',
          ':MoveHChar(-1)<CR>',
          description = "move: Move char left"
        },
        {
          '<C-l>',
          ':MoveHChar(1)<CR>',
          description = "move: Move char right"
        },
        {
          '<leader>wf',
          ':MoveWord(1)<CR>',
          description = "move: Move word forward"
        },
        {
          '<leader>wb',
          ':MoveWord(-1)<CR>',
          description = "move: Move work backward"
        },
        {
          '<C-j>',
          { v = ':MoveBlock(1)<CR>' },
          description = "move: Move selected block up"
        },
        {
          '<C-k>',
          { v = ':MoveBlock(-1)<CR>' },
          description = "move: Move selected block down"
        },
        {
          '<C-h>',
          { v = ':MoveHBlock(-1)<CR>' },
          description = "move: Move selected block left"
        },
        {
          '<C-l>',
          { v = ':MoveHBlock(1)<CR>' },
          description = "move: Move selected block right"
        },
      })
    end
  },
  {
    'gbprod/yanky.nvim',
    enabled = true,
    lazy = false,
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

      require('legendary').keymaps({
        {
          'p',
          "<Plug>(YankyPutAfter)",
          mode = { 'n', 'x' },
          description = "yanky: Put after cursor"
        },
        {
          'P',
          "<Plug>(YankyPutBefore)",
          mode = { 'n', 'x' },
          description = "yanky: Put before cursor"
        },
        {
          'gp',
          "<Plug>(YankyGPutAfter)",
          mode = { 'n', 'x' },
          description = "yanky: Put after cursor and leave the cursor after",
        },
        {
          'gP',
          "<Plug>(YankyGPutBefore)",
          mode = { 'n', 'x' },
          description = "yanky: Put before cursor and leave the cursor after"
        },
        {
          "<C-n>",
          "<Plug>(YankyCycleForward)",
          description = "yanky: Cycle yank buffer forward"
        },
        {
          "<C-p>",
          "<Plug>(YankyCycleBackward)",
          description = "yanky: Cycle yank buffer backward"
        },
        {
          "<space>fv",
          ":Telescope yank_history<CR>",
          description = "yanky: List yank ring"
        },
        {
          -- defined on top of file
          "y",
          description = "yanky: Yank"
        },
      })

      require("telescope").load_extension("yank_history")

      -- vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
      -- vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")
      -- vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
      -- vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
      -- vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
      -- vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")
      -- vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
      -- vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
    end
  }


}
