return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    "stevanmilic/neotest-scala",
  },
  config = function()
    require("neotest").setup({
      default_strategy = "dap",
      status = { virtual_text = true },
      output = { open_on_run = true },
      adapters = {
        require("neotest-scala")({
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          -- args = { "--no-color" },
          args = {},
          -- Runner to use. Will use bloop by default.
          -- Can be a function to return dynamic value.
          -- For backwards compatibility, it also tries to read the vim-test scala config.
          -- Possibly values bloop|sbt.
          runner = "bloop",
          -- Test framework to use. Will use utest by default.
          -- Can be a function to return dynamic value.
          -- Possibly values utest|munit|scalatest.
          framework = "munit",
        })
      },
    })
    require("legendary").keymaps({
      -- { "<leader>t",  "",                                                                                 desc = "+test" },
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      description = "neotest: Run File" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            description = "neotest: Run All Test Files" },
      { "<leader>tr", function() require("neotest").run.run() end,                                        description = "neotest: Run Nearest" },
      { "<leader>tl", function() require("neotest").run.run_last() end,                                   description = "neotest: Run Last" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,                                 description = "neotest: Toggle Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, description = "neotest: Show Output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            description = "neotest: Toggle Output Panel" },
      { "<leader>tS", function() require("neotest").run.stop() end,                                       description = "neotest: Stop" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                 description = "neotest: Toggle Watch" },
    })
  end
}
