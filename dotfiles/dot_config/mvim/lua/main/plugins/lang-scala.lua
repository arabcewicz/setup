return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "scala",
      }
    },
  },
  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt" },
    config = function() end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        metals = {
        },
      },
      setup = {
        -- TODO: organize more
        metals = function(_, opts)
          local metals = require("metals")
          local metals_config = vim.tbl_deep_extend("force", metals.bare_config(), opts)
          --
          metals_config.settings = {
            verboseCompilation = true,
            -- superMethodLensesEnabled = true,
            testUserInterface = "Test Explorer",
          }

          metals_config.init_options.disableColorOutput = false
          metals_config.settings = {
            verboseCompilation = true,
            -- superMethodLensesEnabled = true,
            testUserInterface = "Test Explorer",
          }

          -- *READ THIS*
          -- I *highly* recommend setting statusBarProvider to true, however if you do,
          -- you *have* to have a setting to display this in your statusline or else
          -- you'll not see any messages from metals. There is more info in the help
          -- docs about this
          metals_config.init_options.statusBarProvider = "off"

          -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
          metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

          --
          metals_config.on_attach = function(client, bufnr)
            -- LazyVim.has("nvim-dap") and metals.setup_dap or nil

            require("metals").setup_dap()

            vim.keymap.set("n", '<leader>c:', ":Telescope metals commands<CR>",
              { desc = "metals: Show commands in telescope picker", silent = true, noremap = true })

            return metals_config
          end

          local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt" },
            callback = function()
              metals.initialize_or_attach(metals_config)
            end,
            group = nvim_metals_group,
          })

          return true
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      -- Debug settings
      local dap = require("dap")
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "RunOrTest",
          metals = {
            runType = "runOrTestFile",
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }
    end,
  },

}
