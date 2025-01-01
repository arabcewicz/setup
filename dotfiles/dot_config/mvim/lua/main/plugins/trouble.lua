return {
  "folke/trouble.nvim",
  opts = {
    auto_close = true,
    auto_refresh = true,
    auto_jump = false,
    modes = {
      diagnostics = { auto_open = true },
    }
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
    {
      "<leader>dn",
      "<cmd>Trouble diagnostics next<cr>",
      desc = "trouble: Next diagnostic",
    },
    {
      "<leader>dp",
      "<cmd>Trouble diagnostics prev<cr>",
      desc = "trouble: Previous diagnostic",
    },
  },
}
