return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "marksman",
        "markdownlint-cli2",
        "markdown-toc",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts_extend = { "file_types" },
    opts = {
      file_types = { "markdown" },
      render_modes = { 'n', 'c', 't' },
      code = {
        render_modes = { 'n', 'c', 't' },
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        render_modes = { 'n', 'c', 't' },
        -- sign = false,
        -- icons = {},
        -- position = 'inline',
        backgrounds = {},
      },
      checkbox = {
        render_modes = { 'n', 'c', 't' },
      },
    },
    ft = { "markdown" },
  },
  {
    "iamcco/markdown-preview.nvim",
    -- enabled = false,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    -- build = function()
    --   require("lazy").load({ plugins = { "markdown-preview.nvim" } })
    --   vim.fn["mkdp#util#install"]()
    -- end,
    build = "cd app; yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    keys = {
      {
        "<leader>cp",
        ft = "markdown",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview",
      },
    },
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

}
