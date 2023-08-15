local function metals_status()
  return vim.g["metals_status"] or ""
end

local navic = require("nvim-navic")

require('lualine').setup {
  options = {
    theme = "gruvbox",
    -- section_separators = '',
    -- component_separators = '',
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'filename',
        newfile_status = true,
        path = 0,
        --[[ symbols = {
          modified = "  ",
          readonly = "  ",
          unnamed = "[No name]"
        }, ]]
      },
      'filesize'
    },
    lualine_c = {
      "navic",
      metals_status,
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'branch', 'diff', 'diagnostics' },
    lualine_z = { 'progress', 'location', 'selectioncount' }
  },
  tabline = {
    lualine_c = { "buffers" }
  },
  extensions = { 'quickfix', 'nvim-tree' }

}
