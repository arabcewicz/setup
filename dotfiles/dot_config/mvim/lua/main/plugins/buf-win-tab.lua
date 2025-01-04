return {
  {
    'famiu/bufdelete.nvim',
    keys = {
      { "<A-w>", ":Bdelete<CR>", desc = "bufdelete: Delete current buffer" },
    },
  },
  {
    'vim-scripts/BufOnly.vim',
    keys = {
      { "<C-A-S-w>", ":BufOnly<CR>", desc = "BufOnly: Delete all buffers but current" },
    },
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    event = { "WinNew" },
    config = function()
      require("colorful-winsep").setup({
        hi = {
          -- bg = "#1d2021",
          fg = "#928374",
        },
        no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree", "neo-tree" },
        symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
      })
    end
  },
  {
    'mrjones2014/smart-splits.nvim',
    opts = {
      at_edge = 'stop',
      multiplexer_integration = nil,
      cursor_follows_swapped_bufs = true,
      ignored_filetypes = { 'neo-tree' },
    },
    keys = {
      { '<M-h>',   function() require('smart-splits').move_cursor_left() end,  desc = "smart-split: Move focus to the left adjacent window" },
      { '<M-j>',   function() require('smart-splits').move_cursor_down() end,  desc = "smart-split: Move focus to the down adjacent window" },
      { '<M-k>',   function() require('smart-splits').move_cursor_up() end,    desc = "smart-split: Move focus to the up adjacent window" },
      { '<M-l>',   function() require('smart-splits').move_cursor_right() end, desc = "smart-split: Move focus to the right adjacent window" },
      { '<C-M-h>', function() require('smart-splits').resize_left() end,       desc = "smart-split: Resize window left" },
      { '<C-M-l>', function() require('smart-splits').resize_right() end,      desc = "smart-split: Resize window right" },
      { '<C-M-j>', function() require('smart-splits').resize_down() end,       desc = "smart-split: Resize window up" },
      { '<C-M-k>', function() require('smart-splits').resize_up() end,         desc = "smart-split: Resize window down" },
      {
        '<S-M-h>',
        function()
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
        end,
        desc = "smart-split: Swap window with its left adjacent one or create a new one"
      },
      {
        '<S-M-j>',
        function()
          if vim.fn.winnr() == vim.fn.winnr('j') then
            local ok, _ = pcall(vim.cmd, 'wincmd ^')
            if not ok then
              vim.cmd('split')
            end
            require('smart-splits').swap_buf_up({ move_cursor = false })
          else
            require('smart-splits').swap_buf_down({ move_cursor = true })
          end
        end,
        desc = "smart-split: Swap window with its down adjacent one or create a new one",
      },
      {
        '<S-M-k>',
        function()
          if vim.fn.winnr() == vim.fn.winnr('k') then
            local ok, _ = pcall(vim.cmd, 'wincmd ^')
            if not ok then
              vim.cmd('split')
            end
            require('smart-splits').move_cursor_up()
          else
            require('smart-splits').swap_buf_up({ move_cursor = true })
          end
        end,
        desc = "smart-split: Swap window with its up adjacent one or create a new one",
      },
      {
        '<S-M-l>',
        function()
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
        end,
        desc = "smart-split: Swap window with its right adjacent one or create a new one",
      }
    },
  }
}
