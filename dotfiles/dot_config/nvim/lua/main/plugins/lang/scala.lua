return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "scala",
      })
    end,
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
          keys = {
            { '<leader>mm', ":Telescope metals commands<CR>",                                          desc = "metals: Show commands in telescope picker" },
            { '<leader>ml', ":MetalsToggleLogs<CR>",                                                   desc = "metals: Toggle logs" },
            { '<leader>mu', ":MetalsGotoSuperMethod<CR>",                                              desc = "metals: Go to super method" },
            { '<leader>mc', ":MetalsCompileClean<CR>",                                                 desc = "metals: Clean & compile" },
            { '<leader>ma', function() require("metals.tvp").reveal_in_tree() end,                     desc = "metals: Show in tree view" },
            { '<leader>me', function() require("metals.tvp").toggle_tree_view() end,                   desc = "metals: Toggle tree view" },
            { '<leader>mi', "MetalsImportBuild<CR>",                                                   desc = "metals: Import build" },
            { '<leader>mr', "MetalsRestartMetals<CR>",                                                 desc = "metals: Restart metals" },
            { '<leader>mj', function() require("metals").toggle_settings("showImplicitArguments") end, desc = "metals: Toggle 'show implicit arguments'" },
            { '<leader>my', function() require("metals").type_of_range() end,                          desc = "metals: Type of selected code",            mode = { 'v' } },
            { '<leader>mh', function() require("metals").hover_worksheet() end,                        desc = "metals: Hover worksheet" },
            { '<leader>mt', function() require("metals").select_test_case() end,                       desc = "metals: Select test case" },
            { '<leader>mT', function() require("metals").select_test_suite() end,                      desc = "metals: Select test suite" },
          },
          init_options = {
            disableColorOutput = false,
            statusBarProvider = "off",
          },
          settings = {
            verboseCompilation = true,
            -- superMethodLensesEnabled = true,
            testUserInterface = "Test Explorer",
          }

        },
      },
      setup = {
        metals = function(_, opts)
          local metals = require("metals")
          local metals_config = vim.tbl_deep_extend("force", metals.bare_config(), opts)
          metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
          metals_config.on_attach = require("metals").setup_dap

          local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "scala", "sbt" },
            callback = function()
              if vim.loop.fs_stat(vim.fn.getcwd() .. "/src/main/g8") then return end -- do not attach to giter8 projects
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
