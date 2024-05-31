return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
    })
    vim.cmd.colorscheme("catppuccin")
  end

  --
  -- gruvbox
  -- "gruvbox-community/gruvbox",
  -- priority = 1000,
  -- config = function()
  --   vim.g.gruvbox_contrast_dark = "hard"
  --   vim.g.gruvbox_italic = true
  --   vim.g.gruvbox_invert_selection = false
  --   vim.cmd.colorscheme("gruvbox")
  --   vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
  --   vim.api.nvim_set_hl(0, 'DiffviewDiffAddAsDelete', { bg = "#431313" })
  --   vim.api.nvim_set_hl(0, 'DiffDelete', { bg = "none", fg = "#9d0006" })
  --   vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = "none", fg = "#9d0006" })
  --   vim.api.nvim_set_hl(0, 'DiffAdd', { bg = "#142a03" })
  --   vim.api.nvim_set_hl(0, 'DiffChange', { bg = "#3B3307" })
  --   vim.api.nvim_set_hl(0, 'DiffText', { bg = "#4D520D" })
  -- end,
}
