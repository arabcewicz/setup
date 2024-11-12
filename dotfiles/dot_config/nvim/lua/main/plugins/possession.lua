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
      hooks = {
        before_save = function(name) return {} end,
        after_save = function(name, user_data, aborted) end,
        before_load = function(name, user_data) return user_data end,
        after_load = function(name, user_data) end,
      },
      plugins = {
        close_windows = {
          hooks = { 'before_save', 'before_load' },
          preserve_layout = true, -- or fun(win): boolean
          match = {
            floating = true,
            buftype = {},
            filetype = {},
            custom = false, -- or fun(win): boolean
          },
        },
        delete_hidden_buffers = {
          hooks = {
            'before_load',
            vim.o.sessionoptions:match('buffer') and 'before_save',
          },
          force = false, -- or fun(buf): boolean
        },
        nvim_tree = false,
        neo_tree = false,
        symbols_outline = false,
        outline = false,
        tabby = false,
      }
    })

    require('telescope').load_extension('possession')

    require("legendary").keymaps({
      {
        '<leader>fp',
        ':Telescope possession list<CR>',
        description = 'possession: List sessions'
      },
    })
  end
}
