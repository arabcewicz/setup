-- do not loose yanked thing after pasting on any selected text
-- vim.keymap.set("x", "<leader>p", "\"_dP", opts)

local opts = { noremap = true, silent = true }

require('legendary').keymaps({
  {
    "<C-s>",
    { n = ":wa<CR>", i = "<Esc>:wa<CR>" },
    description = "Save current buffer",
    opts = opts,
  },
  {
    "<A-p>",
    ":tabnext<CR>",
    description = "Switch to next tab",
    opts = opts,
  },
  {
    "<A-u>",
    ":tabprevious<CR>",
    description = "Switch to previous tab",
    opts = opts,
  },
  {
    "<A-S-w>",
    ":tabclose<CR>",
    description = "Close current tab",
    opts = opts,
  },
  {
    "<A-q>",
    ":q<CR>",
    description = "Close current window",
    opts = opts,
  },
  {
    "<A-s>",
    ":source %<CR>",
    description = "Source current file",
    opts = opts,
  },
  {
    "<A-S-q>",
    ":qa!<CR>",
    description = "Quit",
    opts = opts,
  },
  {
    "<",
    { v = "<gv" },
    description = "Unindent and stay in visual mode",
    opts = opts,
  },
  {
    ">",
    { v = ">gv" },
    description = "Indent and stay in visual mode",
    opts = opts,
  },
  {
    "<leader>J",
    "mzJ`z",
    description = "Merge lines, cursor positions stays unchanged",
    opts = opts,
  },
  {
    "<leader>aa",
    vim.diagnostic.setqflist,
    description = "diagnostic: Open all as quick list",
    opts = opts,
  },
  {
    "<leader>ae",
    function() vim.diagnostic.setqflist({ severity = "E" }) end,
    description = "diagnostic: Open errors as quicklist",
    opts = opts,
  },
  {
    "<leader>aw",
    function() vim.diagnostic.setqflist({ severity = "W" }) end,
    description = "diagnostic: Open warnings as quicklist",
    opts = opts,
  },
  {
    "<leader>d",
    vim.diagnostic.setloclist,
    description = "diagnostic: Show buffers diagnostics",
    opts = opts,
  },
  {
    "[d",
    function() vim.diagnostic.goto_prev({ wrap = false }) end,
    description = "diagnostic: Go to next",
    opts = opts,
  },
  {
    "]d",
    function() vim.diagnostic.goto_next({ wrap = false }) end,
    description = "diagnostic: Go to previous",
    opts = opts,
  },
})
