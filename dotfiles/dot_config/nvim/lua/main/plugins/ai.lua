return {
  {
    'github/copilot.vim',
    enabled = false,
  },
  {
    "yetone/avante.nvim",
    enabled = true,
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "deepseek",
      vendors = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-chat",
        },
      },
    },
    build =
        function()
          if LazyVim.is_win() then
            return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
          else
            -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
            return "make"
          end
        end,
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp",            -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { "Avante" },
    },
    ft = { "Avante" },
  },

}
