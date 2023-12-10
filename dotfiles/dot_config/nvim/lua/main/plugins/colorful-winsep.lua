return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinNew" },
  config = function()
    require("colorful-winsep").setup({
      highlight = {
        -- bg = "#1d2021",
        fg = "#928374",
      },
      interval = 30,
      symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
    })
  end
}
