return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    require('smart-splits').setup({
      at_edge = 'split',
      multiplexer_integration = nil,
      cursor_follows_swapped_bufs = true,
      ignored_filetypes = { 'neo-tree' },
      --[[ resize_mode = {
        hooks = {
          on_leave = require('bufresize').register,
        },
      }, ]]
    })

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


    require('legendary').keymaps({
      {
        '<A-h>',
        require('smart-splits').move_cursor_left,
        description = "smart-split: Move focus to the left adjacent window",
      },
      {
        '<A-j>',
        require('smart-splits').move_cursor_down,
        description = "smart-split: Move focus to the down adjacent window",
      },
      {
        '<A-k>',
        require('smart-splits').move_cursor_up,
        description = "smart-split: Move focus to the up adjacent window",
      },
      {
        '<A-l>',
        require('smart-splits').move_cursor_right,
        description = "smart-split: Move focus to the right adjacent window",
      },
      {
        '<C-A-h>',
        require('smart-splits').resize_left,
        description = "smart-split: Resize window left",
      },
      {
        '<C-A-j>',
        require('smart-splits').resize_down,
        description = "smart-split: Resize window up",
      },
      {
        '<C-A-k>',
        require('smart-splits').resize_up,
        description = "smart-split: Resize window down",
      },
      {
        '<C-A-l>',
        require('smart-splits').resize_right,
        description = "smart-split: Resize window right",
      },
      {
        '<S-A-h>',
        swap_or_create_left,
        description = "smart-split: Swap window with its left adjacent one or create a new one",
      },
      {
        '<S-A-j>',
        swap_or_create_down,
        description = "smart-split: Swap window with its down adjacent one or create a new one",
      },
      {
        '<S-A-k>',
        swap_or_create_up,
        description = "smart-split: Swap window with its up adjacent one or create a new one",
      },
      {
        '<S-A-l>',
        swap_or_create_right,
        description = "smart-split: Swap window with its right adjacent one or create a new one",
      },
    })
  end
}
