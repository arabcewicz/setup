return {
  'fedepujol/move.nvim',
  config = function()
    require('legendary').keymaps({
      {
        '<C-j>',
        ':MoveLine(1)<CR>',
        description = "move: Move line down"
      },
      {
        '<C-k>',
        ':MoveLine(-1)<CR>',
        description = "move: Move line up"
      },
      {
        '<C-h>',
        ':MoveHChar(-1)<CR>',
        description = "move: Move char left"
      },
      {
        '<C-l>',
        ':MoveHChar(1)<CR>',
        description = "move: Move char right"
      },
      {
        '<leader>wf',
        ':MoveWord(1)<CR>',
        description = "move: Move word forward"
      },
      {
        '<leader>wb',
        ':MoveWord(-1)<CR>',
        description = "move: Move work backward"
      },
      {
        '<C-j>',
        { v = ':MoveBlock(1)<CR>' },
        description = "move: Move selected block up"
      },
      {
        '<C-k>',
        { v = ':MoveBlock(-1)<CR>' },
        description = "move: Move selected block down"
      },
      {
        '<C-h>',
        { v = ':MoveHBlock(-1)<CR>' },
        description = "move: Move selected block left"
      },
      {
        '<C-l>',
        { v = ':MoveHBlock(1)<CR>' },
        description = "move: Move selected block right"
      },
    })
  end
}
