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
      -- "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>dc", function() require("dap").continue() end,                                             desc = "dap: Run/Continue" },
      { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "dap: Run with Args" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "dap: Run to Cursor" },
      { "<leader>dl", function() require("dap").run_last() end,                                             desc = "dap: Run last debug session" },
      { "<leader>dg", function() require("dap").goto_() end,                                                desc = "dap: Go to Line (No Execute)" },
      { "<leader>dK", function() require("dap.ui.widgets").hover() end,                                     desc = "dap.ui: Widgets (hover)" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "dap: Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "dap: Breakpoint condition" },
      { "<leader>di", function() require("dap").step_into() end,                                            desc = "dap: Step into" },
      { "<leader>do", function() require("dap").step_over() end,                                            desc = "dap: Step Over" },
      { "<leader>dO", function() require("dap").step_out() end,                                             desc = "dap: Step Out" },
      { "<leader>dP", function() require("dap").pause() end,                                                desc = "dap: Pause" },
      { "<leader>dj", function() require("dap").down() end,                                                 desc = "dap: Down" },
      { "<leader>dk", function() require("dap").up() end,                                                   desc = "dap: Up" },
      { "<leader>ds", function() require("dap").session() end,                                              desc = "dap: Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                            desc = "dap: Terminate" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "dap: Toggle repl" },
    },
    config = function()
      require("nvim-dap-virtual-text").setup()

      -- TODO: setup "mason-nvim-dap" here (??)

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local sign = vim.fn.sign_define
      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "dapui: Toggle dapui" },
      { "<leader>de", function() require("dapui").eval() end,   desc = "dapui: Eval",        mode = { "n", "v" } },
      {
        "<leader>dA",
        function()
          local dap = require("dap")
          local dapui = require("dapui")
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
        end,
        desc = "dapui: Toggle ui autostart"
      },
    },
    opts = {},
    -- config = function(_, opts)
    --   local dap = require("dap")
    --   local dapui = require("dapui")
    --   dapui.setup(opts)
    --   dap.listeners.after.event_initialized["dapui_config"] = function()
    --     dapui.open({})
    --   end
    --   dap.listeners.before.event_terminated["dapui_config"] = function()
    --     dapui.close({})
    --   end
    --   dap.listeners.before.event_exited["dapui_config"] = function()
    --     dapui.close({})
    --   end
    -- end,
  },

}
