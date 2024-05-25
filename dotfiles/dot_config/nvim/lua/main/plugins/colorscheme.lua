return {
  "gruvbox-community/gruvbox",
  priority = 1000,
  config = function()
    vim.g.gruvbox_contrast_dark = "hard"
    vim.g.gruvbox_italic = true
    vim.g.gruvbox_invert_selection = false
    vim.cmd.colorscheme("gruvbox")
    vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
  end,
}
