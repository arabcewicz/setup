return {
  'vim-scripts/BufOnly.vim',
  config = function()
    require('legendary').keymaps({
      {
        '<C-A-S-w>',
        ":BufOnly<CR>",
        description = "BufOnly: Delete all buffers but current"
      },
    })
  end

}
