return
{
  'famiu/bufdelete.nvim',
  config = function()
    require('legendary').keymaps({
      {
        "<A-w>",
        ":Bdelete<CR>",
        description = "bufdelete: Delete current buffer"
      },
    })
  end
}
