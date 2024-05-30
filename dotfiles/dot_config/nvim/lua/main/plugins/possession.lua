return {
  'jedrzejboczar/possession.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('possession').setup({
      autosave = {
        current = true,
        tmp = true,
      },
      plugins = {
        nvim_tree = false,
        neo_tree = false,
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
