return {
  {
    "mg979/vim-visual-multi",
    -- bindings has to be set before plugin is loaded
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ["Find Under"] = "<C-M-n>",
        ["Find Subword Under"] = "<C-M-n>",
        ["Remove Region"] = "<C-M-p>",
        ["Select All"] = "<C-M-a>",
        ["Start Regex Search"] = "<C-M-/>",
        ["Add Cursor Down"] = "<C-S-j>",
        ["Add Cursor Up"] = "<C-S-k>",
        ["Skip Region"] = "<C-M-b>",
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    enabled = false,
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    opts = {
      keymaps = {
        useDefaults = true,
      },
    },
  },
  {
    "echasnovski/mini.splitjoin",
    enabled = true,
    version = "*",
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- Created for both Normal and Visual modes.
      mappings = {
        toggle = "gJ",
        split = "",
        join = "",
      },

      -- Detection options: where split/join should be done
      detect = {
        -- Array of Lua patterns to detect region with arguments.
        -- Default: { '%b()', '%b[]', '%b{}' }
        brackets = nil,

        -- String Lua pattern defining argument separator
        separator = ",",

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
    },
  },
  {
    "gbprod/substitute.nvim",
    opts = {
      highlight_substituted_text = {
        enabled = true,
        timer = 300,
      },
      on_substitute = require("yanky.integration").substitute(),
    },
    keys = {
      {
        "<leader>r",
        function()
          require("substitute").operator()
        end,
        desc = "substitue: operator",
      },
      {
        "<leader>rr",
        function()
          require("substitute").line()
        end,
        desc = "substitue: line",
      },
      {
        "<leader>R",
        function()
          require("substitute").eol()
        end,
        desc = "substitue: eol",
      },
    },
  },
}
