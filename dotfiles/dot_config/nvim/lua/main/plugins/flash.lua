return {
  "folke/flash.nvim",
  event = "VeryLazy",
  config = function()
    require("flash").setup({
      modes = {
        char = {
          jump_labels = true
        }
      }
    })

    require("legendary").keymaps({
      {
        "<Enter>",
        {
          n = function() require('flash').jump() end,
          x = function() require('flash').jump() end,
          o = function() require('flash').jump() end
        },
        description = "flash: Flash",
      },
      {
        "<C-m>",
        {
          n = function() require('flash').treesitter() end,
          x = function() require('flash').treesitter() end,
          o = function() require('flash').treesitter() end
        },
        description = "flash: Treesitter",
      },
    })
  end
  -- stylua: ignore
  -- keys = {
  --   { "<C-Enter>", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "flash: Start flash" },
  --   { "<C-M>",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --   --   { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --   --   { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --   --   { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  -- },
}
