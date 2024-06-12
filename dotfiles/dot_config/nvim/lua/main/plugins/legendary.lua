return {
  'mrjones2014/legendary.nvim',
  version = 'v2.1.0',
  priority = 10000,
  lazy = false,
  -- sqlite is only needed if you want to use frecency sorting
  -- dependencies = { 'kkharji/sqlite.lua' }
  config = function()
    require('legendary').setup({
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
      include_builtin = true,

      lazy_nvim = { auto_register = true },
      extensions = {
        lazy_nvim = true,
        diffview = false,
      },
    })
  end
}
