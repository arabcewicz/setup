return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    keys = {
      { "<M-Space>", desc = "Increment Selection" },
      { "<BS>",      desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      highlight = {
        enable = true,
        indent = { enable = true },
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "dockerfile",
        "gitignore",
        "hocon",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-SPACE>",
          node_incremental = "<M-SPACE>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
      autotag = {
        enable = true,
        enable_rename = true,
      },
      sync_install = false,
    },
    config = function(_, opts)
      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      require("nvim-treesitter.configs").setup(opts)

      local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
      vim.api.nvim_create_autocmd(
        { 'BufNewFile', 'BufRead' },
        { group = hocon_group, pattern = '*/resources/*.conf', command = 'set ft=hocon' }
      )
    end,

  },
}
