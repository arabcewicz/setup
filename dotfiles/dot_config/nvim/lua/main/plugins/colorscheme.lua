return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    term_colors = true,
    integrations = {
      aerial = true,
      alpha = true,
      cmp = true,
      dashboard = true,
      flash = true,
      fzf = true,
      grug_far = true,
      gitsigns = true,
      headlines = true,
      illuminate = true,
      indent_blankline = { enabled = true },
      leap = true,
      lsp_trouble = true,
      mason = true,
      markdown = true,
      mini = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      navic = { enabled = true, custom_bg = "lualine" },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      semantic_tokens = true,
      snacks = true,
      telescope = true,
      treesitter = true,
      treesitter_context = true,
      which_key = true,
    }
  },
  init = function()
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
