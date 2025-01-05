return {
  {
    'm00qek/baleia.nvim',
    config = function()
      vim.g.baleia = require("baleia").setup({})
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = "dap-repl",
        callback = function()
          vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
        end,
      })
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>dc", function() require("dap").continue() end,          desc = "dap: Continue" },
      { "<leader>dt", function() require("dap").terminate() end,         desc = "dap: Terminate" },
      { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "dap: Toggle repl" },
      { "<leader>dK", function() require("dap.ui.widgets").hover() end,  desc = "dap.ui: Show hover" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "dap: Toggle breakpoint" },
      { "<leader>do", function() require("dap").step_over() end,         desc = "dap: Step over" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "dap: Step into" },
      { "<leader>dl", function() require("dap").run_last() end,          desc = "dap: Run last debug session" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "dapui: Toggle dapui" },
      { "<leader>da", function() dapui_autostart() end,                  desc = "dapui: Toggle ui autostart" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      function dapui_autostart()
        dap.listeners.before.attach.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
          dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
          dapui.close()
        end
      end

      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    end
  }
}
