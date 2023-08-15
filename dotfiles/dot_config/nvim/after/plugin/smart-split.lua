require('smart-splits').setup({
  cursor_follows_swapped_bufs = true,
  --[[ resize_mode = {
    hooks = {
      on_leave = require('bufresize').register,
    },
  }, ]]
})

-- these keymaps will also accept a range,
-- for example `10<M-h>` will `resize_left` by `(10 * config.default_amount)`
-- moving between splits
vim.keymap.set('n', '<M-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<M-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<M-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<M-l>', require('smart-splits').move_cursor_right)
-- resizing splits
vim.keymap.set('n', '<C-M-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-M-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-M-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-M-l>', require('smart-splits').resize_right)
-- swapping buffers between windows
vim.keymap.set('n', '<C-S-A-h>', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<C-S-A-j>', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<C-S-A-k>', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<C-S-A-l>', require('smart-splits').swap_buf_right)
