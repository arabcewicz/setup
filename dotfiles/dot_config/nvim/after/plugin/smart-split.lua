require('smart-splits').setup({
  at_edge = 'split',
  cursor_follows_swapped_bufs = true,
  --[[ resize_mode = {
    hooks = {
      on_leave = require('bufresize').register,
    },
  }, ]]
})

local opts = { noremap = true, silent = true }
-- these keymaps will also accept a range,
-- for example `10<M-h>` will `resize_left` by `(10 * config.default_amount)`
-- moving between splits
vim.keymap.set('n', '<M-h>', require('smart-splits').move_cursor_left, opts)
vim.keymap.set('n', '<M-j>', require('smart-splits').move_cursor_down, opts)
vim.keymap.set('n', '<M-k>', require('smart-splits').move_cursor_up, opts)
vim.keymap.set('n', '<M-l>', require('smart-splits').move_cursor_right, opts)
-- resizing splits
vim.keymap.set('n', '<C-M-h>', require('smart-splits').resize_left, opts)
vim.keymap.set('n', '<C-M-j>', require('smart-splits').resize_down, opts)
vim.keymap.set('n', '<C-M-k>', require('smart-splits').resize_up, opts)
vim.keymap.set('n', '<C-M-l>', require('smart-splits').resize_right, opts)
-- swapping buffers between windows
-- vim.keymap.set('n', '<S-A-h>', require('smart-splits').swap_buf_left)
-- vim.keymap.set('n', '<S-A-j>', require('smart-splits').swap_buf_down)
-- vim.keymap.set('n', '<S-A-k>', require('smart-splits').swap_buf_up)
-- vim.keymap.set('n', '<S-A-l>', require('smart-splits').swap_buf_right)


local function swap_or_create_up()
  if vim.fn.winnr() == vim.fn.winnr('k') then
    local ok, _ = pcall(vim.cmd, 'wincmd ^')
    if not ok then
      vim.cmd('split')
    end
    require('smart-splits').move_cursor_up()
  else
    require('smart-splits').swap_buf_up({ move_cursor = true })
  end
end

local function swap_or_create_down()
  if vim.fn.winnr() == vim.fn.winnr('j') then
    local ok, _ = pcall(vim.cmd, 'wincmd ^')
    if not ok then
      vim.cmd('split')
    end
    require('smart-splits').swap_buf_up({ move_cursor = false })
  else
    require('smart-splits').swap_buf_down({ move_cursor = true })
  end
end

local function swap_or_create_left()
  if vim.fn.winnr() == vim.fn.winnr('h') then
    vim.cmd('vsplit')
    local ok, _ = pcall(vim.cmd, 'edit #')
    if not ok then
      vim.cmd('edit %')
    end
    require('smart-splits').move_cursor_left()
  else
    require('smart-splits').swap_buf_left({ move_cursor = true })
  end
end

local function swap_or_create_right()
  if vim.fn.winnr() == vim.fn.winnr('l') then
    vim.cmd('vsplit')
    require('smart-splits').move_cursor_left()
    local ok, _ = pcall(vim.cmd, 'edit #')
    if not ok then
      vim.cmd('edit %')
    end
    require('smart-splits').move_cursor_right()
  else
    require('smart-splits').swap_buf_right({ move_cursor = true })
  end
end

-- swapping buffers between windows
vim.keymap.set('n', '<S-A-h>', swap_or_create_left, opts)
vim.keymap.set('n', '<S-A-j>', swap_or_create_down, opts)
vim.keymap.set('n', '<S-A-k>', swap_or_create_up, opts)
vim.keymap.set('n', '<S-A-l>', swap_or_create_right, opts)
