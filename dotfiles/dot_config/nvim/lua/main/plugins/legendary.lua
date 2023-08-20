require('legendary').setup {
  lazy_nvim = { auto_register = true },
  keymaps =
  -- other are spread among configs
  {
    {
      '<leader>fk',
      ':Legendary keymaps<CR>',
      description = 'legendary: List custom keybindings'
    }
  },

  --   -- in-place filters, see :h legendary-tables or ./doc/table_structures/README.md
  --   -- { '<leader>m', description = 'Preview markdown', filters = { ft = 'markdown' } },
  -- },
  -- autocmds = {
  --   -- Create autocmds and augroups
  --   { 'BufWritePre', vim.lsp.buf.format, description = 'Format on save' },
  --   {
  --     name = 'MyAugroup',
  --     clear = true,
  --     -- autocmds here
  --   },
  -- },
  -- load extensions
  default_opts = {
    keymap = { noremap = true, silent = true },
  },
  include_builtin = false,

  extensions = {
    diffview = false,
  },
}
