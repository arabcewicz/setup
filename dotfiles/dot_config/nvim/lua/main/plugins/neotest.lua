return {
  "nvim-neotest/neotest",
  enabled = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    "stevanmilic/neotest-scala",
    -- { dir = "~/dev/nvim/neotest-metals" },
  },
  config = function()
    require("neotest").setup({
      default_strategy = "dap",
      -- log_level = "trace",
      status = { virtual_text = true },
      output = { open_on_run = true },
      adapters = {
        -- require("neotest-metals")
        require("neotest-scala")({
          args = {},
          runner = "bloop",
          framework = "munit",
        })
      },
    })
  end,
  keys = {
    { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "neotest: Run File" },
    { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "neotest: Run All Test Files" },
    { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "neotest: Run Nearest" },
    { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "neotest: Run Last" },
    { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "neotest: Toggle Summary" },
    { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "neotest: Show Output" },
    { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "neotest: Toggle Output Panel" },
    { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "neotest: Stop" },
    { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                 desc = "neotest: Toggle Watch" },
  }
}
