return {
  "mg979/vim-visual-multi",
  -- bindings has to be set before plugin is loaded
  init = function()
    vim.g.VM_default_mappings = 0
    vim.g.VM_maps = {
      ['Find Under']         = '<M-n>',
      ['Find Subword Under'] = '<M-n>',
      ['Remove Region']      = '<M-p>',
      ['Select All']         = '<M-S-n>',
      ['Start Regex Search'] = '<M-/>',
      ['Add Cursor Down']    = '<C-S-j>',
      ['Add Cursor Up']      = '<C-S-k>',
      ['Skip Region']        = '<M-b>',
    }
  end,
}
