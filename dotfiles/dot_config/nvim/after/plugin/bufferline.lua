require("bufferline").setup({
  options = {
    -- numbers = "both",
    close_command = function(bufnum) require("bufdelete").bufdelete(bufnum, false) end,
    right_mouse_command = "vertical sbuffer %d",
    indicator = {
      icon = '▎',
      style = 'icon'
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    separator_style = "thick",

    max_name_length = 34,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    -- tab_size = 40,
    -- max_name_length = 18,
    -- max_prefix_length = 15,
    tab_size = 18,

    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left", padding = 1 } },
    sort_by = 'extension',
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = true,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = ""
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and ""
            or (e == "warning" and "" or "")
        if (sym ~= "") then
          s = s .. " " .. n .. sym
        end
      end
      return s
    end,
    numbers = function(opts)
      -- return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
      return string.format('%s·%s', opts.id, opts.ordinal)
    end,
  }
})

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
vim.keymap.set("n", "<leader>bc", ":BufferLinePick<CR>", opts)
vim.keymap.set("n", "<leader>bse", ":BufferLineSortByExtension<CR>", opts)
vim.keymap.set("n", "<leader>bsd", ":BufferLineSortByDirectory<CR>", opts)
vim.keymap.set("n", "<leader>bsi",
  ":lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>", opts)
vim.keymap.set("n", "<leader>bmn", ":BufferLineMoveNext<CR>", opts)
vim.keymap.set("n", "<leader>bmp", ":BufferLineMovePrev<CR>", opts)
vim.keymap.set("n", "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
vim.keymap.set("n", "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
vim.keymap.set("n", "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
vim.keymap.set("n", "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
vim.keymap.set("n", "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
vim.keymap.set("n", "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
vim.keymap.set("n", "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
vim.keymap.set("n", "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
vim.keymap.set("n", "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

-- bufdelete
vim.keymap.set("n", "<A-w>", ":Bdelete<CR>", opts)
