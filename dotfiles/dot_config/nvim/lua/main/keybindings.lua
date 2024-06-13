-- do not loose yanked thing after pasting on any selected text
-- vim.keymap.set("x", "<leader>p", "\"_dP", opts)

local opts = { noremap = true, silent = true }

require('legendary').keymaps({
  {
    "<A-,>",
    { n = ":bprev<CR>", i = "<Esc>:bprev<CR>" },
    description = "Go to the previous buffer",
    opts = opts,
  },
  {
    "<A-.>",
    { n = ":bnext<CR>", i = "<Esc>:bnext<CR>" },
    description = "Go to the next buffer",
    opts = opts,
  },
  {
    "<S-A-,>",
    { n = ":bfirst<CR>", i = "<Esc>:bfirst<CR>" },
    description = "Go to the first buffer",
    opts = opts,
  },
  {
    "<S-A-.>",
    { n = ":blast<CR>", i = "<Esc>:blast<CR>" },
    description = "Go to the last buffer",
    opts = opts,
  },
  {
    "<C-s>",
    { n = ":wa<CR>", i = "<Esc>:wa<CR>" },
    description = "Save current buffer",
    opts = opts,
  },
  {
    "<A-o>",
    ":tabnext<CR>",
    description = "Switch to the next tab",
    opts = opts,
  },
  {
    "<A-i>",
    ":tabprevious<CR>",
    description = "Switch to the previous tab",
    opts = opts,
  },
  {
    "<A-u>",
    ":tabfirst<CR>",
    description = "Switch to the first tab",
    opts = opts,
  },
  {
    "<A-i>",
    ":tablasst<CR>",
    description = "Switch to the last tab",
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
