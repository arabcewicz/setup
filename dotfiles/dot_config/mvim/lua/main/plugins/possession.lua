return {
  'jedrzejboczar/possession.nvim',
  enabled = true,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('possession').setup({
      autosave = {
        current = true,
        tmp = true,
        cwd = true,
        on_load = true,
        on_quit = true,
      },
      debug = false,
      logfile = true,
      autoload = 'last_cwd',
      plugins = {
        nvim_tree = false,
        neo_tree = false,
        symbols_outline = false,
        outline = false,
        tabby = false,
      }
    })
    require('telescope').load_extension('possession')

    vim.keymap.set("n", '<leader>fp', ':Telescope possession list<CR>',
      { desc = 'possession: List sessions', silent = true })
  end,
}
