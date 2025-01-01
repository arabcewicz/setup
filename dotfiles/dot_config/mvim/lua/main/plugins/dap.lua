return {
  {
    'm00qek/baleia.nvim',
    enabled = true,
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
    enabled = true,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
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

      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "Run",
          metalsRunType = "run",
        },
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

      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

      require('legendary').keymaps({
        {
          "<leader>dc",
          function() require("dap").continue() end,
          description = "dap: Continue"
        },
        {
          "<leader>dt",
          function() require("dap").terminate() end,
          description = "dap: Terminate"
        },
        {
          "<leader>dr",
          function() require("dap").repl.toggle() end,
          description = "dap: Toggle repl"
        },
        {
          "<leader>dK",
          function() require("dap.ui.widgets").hover() end,
          description = "dap.ui: Show hover"
        },
        {
          "<leader>db",
          function() require("dap").toggle_breakpoint() end,
          description = "dap: Toggle breakpoint"
        },
        {
          "<leader>do",
          function() require("dap").step_over() end,
          description = "dap: Step over"
        },
        {
          "<leader>di",
          function() require("dap").step_into() end,
          description = "dap: Step into"
        },
        {
          "<leader>dl",
          function() require("dap").run_last() end,
          description = "dap: Run last debug session"
        },
        {
          "<leader>du",
          function() require("dapui").toggle() end,
          description = "dapui: Toggle dapui"
        },
        {
          "<leader>da",
          function() dapui_autostart() end,
          description = "dapui: Toggle ui autostart"
        },
      })
    end
  }
}
