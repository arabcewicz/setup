return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local function metals_status()
      return vim.g["metals_status"] or ""
    end

    -- local navic = require("nvim-navic")

    -- vim-visual-multi's status line doesn't work well with lualine, so disabling it
    vim.g.VM_set_statusline = 0 -- disable VM's statusline updates to prevent clobbering
    vim.g.VM_silent_exit = 1    -- because the status line already tells me the mode

    require('lualine').setup {
      options = {
        theme = "catppuccin",
        -- section_separators = '',
        -- component_separators = '',
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          'mode',
        },
        lualine_b = {
          'buffers',
        },
        lualine_c = {
          {
            function() return require('possession.session').get_session_name() or '' end
          },
          -- "navic",
          metals_status,
          -- vim-visual-multi status line poor integration with lualine
          --[[ {
        function()
          if vim.b['visual_multi'] then
            local ret = vim.api.nvim_exec2('call b:VM_Selection.Funcs.infoline()', { output = true })
            print(ret.output)
            return string.match(ret.output, 'M.*')
          else
            return ''
          end
        end
      }, ]]
        },
        lualine_x = {
          {
            'filename',
            newfile_status = true,
            path = 0,
          },
          'filesize',
          'encoding',
          'fileformat',
          'filetype'
        },
        lualine_y = { 'branch', 'diff', 'diagnostics' },
        lualine_z = { 'progress', 'location', 'selectioncount' }
      },
      --[[ tabline = {
    lualine_c = { "buffers" }
  }, ]]
      -- extensions = { 'quickfix', 'nvim-tree' }

    }
  end
}
