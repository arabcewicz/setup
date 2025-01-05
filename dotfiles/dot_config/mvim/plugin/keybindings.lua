-- local map = vim.keymap.set
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('keep', { noremap = true, silent = true }, { desc = desc }))
end

-- do not loose yanked thing after pasting on any selected text
-- map("x", "<leader>p", "\"_dP", "Paste without yanking")

map('n', '<Esc>', '<cmd>nohlsearch<CR>', "Clear search highlights")
map("n", "<leader><leader>", "<cmd>source%<CR>", "Source the current file")
map("n", "<leader>c<space>", ":.lua<CR>", "Run lua code")

-- buffers
map("n", "<S-h>", ":bprev<CR>", "Go to the previous buffer")
map("n", "<S-l>", ":bnext<CR>", "Go to the next buffer")
map("n", "<S-M-,>", ":bfirst<CR>", "Go to the first buffer")
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR>", "Save file")


map("n", "<M-q>", ":q<CR>", "Close current window")
map("n", "<M-S-q>", ":qa!<CR>", "Close all windows")

map("n", "<M-o>", ":tabnext<CR>", "Switch to the next tab")
map("n", "<M-i>", ":tabprevious<CR>", "Switch to the previous tab")
map("n", "<M-u>", ":tabfirst<CR>", "Switch to the first tab")
map("n", "<M-p>", ":tablast<CR>", "Switch to the last tab")
-- map("n", "<M-S-w>", ":tabclose<CR>", "Close current tab")

map("v", "<", "<gv", "Unindent and stay in visual mode")
map("v", ">", ">gv", "Indent and stay in visual mode")
map("n", "<leader>J", "mzJ`z", "Merge lines, cursor positions stays unchanged")
map("n", "<leader>aa", vim.diagnostic.setqflist, "diagnostic: Open all as quick list")
map("n", "<leader>ae", function() vim.diagnostic.setqflist({ severity = "E" }) end,
  "diagnostic: Open errors as quick list")
map("n", "<leader>aw", function() vim.diagnostic.setqflist({ severity = "W" }) end,
  "diagnostic: Open warnings as quick list")
map("n", "<leader>dd", vim.diagnostic.setloclist, "diagnostic: Show buffers diagnostics")
map("n", "[d", function() vim.diagnostic.goto_prev({ wrap = false }) end, "diagnostic: Go to next")
map("n", "]d", function() vim.diagnostic.goto_next({ wrap = false }) end, "diagnostic: Go to previous")

-- better up/down
map = vim.keymap.set
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move Lines
map("n", "<C-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<C-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<C-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers again
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
map("n", "<M-S-w>", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })


-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>c", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
--
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
