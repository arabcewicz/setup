return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        autotag = {
          enable = true,
          enable_rename = true,
        },
        ensure_installed = {
          "scala", "rust", "html", "css", "javascript", "typescript", "tsx", "json", "lua", "vim", "vimdoc", "query", "markdown", "yaml", "toml", "latex"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }

      -- require('nvim-ts-autotag').setup()
    end
  },
  { 'nvim-treesitter/playground' },
}
