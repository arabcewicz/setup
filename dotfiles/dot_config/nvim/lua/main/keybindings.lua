local opts = { noremap = true, silent = true }

-- CTRL+S saves the buffer
vim.keymap.set("n", "<C-s>", ":wa<CR>", opts)
vim.keymap.set("i", "<C-s>", "<Esc>:wa<CR>", opts)


-- Move around splits using Alt + {h,j,k,l}
--[[ vim.keymap.set("n", "<M-h>", "<C-w>h", opts)
vim.keymap.set("n", "<M-l>", "<C-w>l", opts)
vim.keymap.set("n", "<M-j>", "<C-w>j", opts)
vim.keymap.set("n", "<M-k>", "<C-w>k", opts) ]]

-- vim.keymap.set("n", "<leader>fm", vim.cmd.Ex)


-- Stay in visual mode after indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Like 'J' but doesn't change the cursor position
vim.keymap.set("n", "<leader>J", "mzJ`z", opts)


-- do not loose yanked thing after pasting on any selected text
vim.keymap.set("x", "<leader>p", "\"_dP", opts)
--
-- LSP mappings
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run)
vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

-- diagnostic
vim.keymap.set("n", "<leader>aa", vim.diagnostic.setqflist)
-- all workspace errors
vim.keymap.set("n", "<leader>ae", function() vim.diagnostic.setqflist({ severity = "E" }) end)
-- all workspace warnings
vim.keymap.set("n", "<leader>aw", function() vim.diagnostic.setqflist({ severity = "W" }) end)
-- buffer diagnostics only
vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)
vim.keymap.set("n", "[c", function() vim.diagnostic.goto_prev({ wrap = false }) end)
vim.keymap.set("n", "]c", function() vim.diagnostic.goto_next({ wrap = false }) end)
