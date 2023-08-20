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

require('legendary').keymaps({
  {
    "<leader>dc",
    function() require("dap").continue() end,
    description = "dap: Continue"
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
    "<leader>dt",
    function() require("dap").toggle_breakpoint() end,
    description = "dap: Toggle breakpoint"
  },
  {
    "<leader>dso",
    function() require("dap").step_over() end,
    description = "dap: Step over"
  },
  {
    "<leader>dsi",
    function() require("dap").step_into() end,
    description = "dap: Step into"
  },
  {
    "<leader>dl",
    function() require("dap").run_last() end,
    description = "dap: Run last debug session"
  },
})
