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
    "<A-s>",
    ":source %<CR>",
    description = "Source current file",
    opts = opts,
  },
  {
    "<A-q>",
    ":q<CR>",
    description = "Close current window",
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
    "<gv",
    description = "Unindent and stay in visual mode",
    opts = opts,
  },
  {
    ">",
    ">gv",
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
    "gd",
    vim.lsp.buf.definition,
    description = "lsp: Go to definition",
    opts = opts,
  },
  {
    "<leader>gt",
    vim.lsp.buf.type_definition,
    description = "lsp: Go to type definition",
    opts = opts,
  },
  {
    "K",
    vim.lsp.buf.hover,
    description = "lsp: Show hover",
    opts = opts,
  },
  {
    "gi",
    vim.lsp.buf.implementation,
    description = "lsp: Go to implementation",
    opts = opts,
  },
  {
    "gr",
    vim.lsp.buf.references,
    description = "lsp: Show references as quick list",
    opts = opts,
  },
  {
    "gds",
    vim.lsp.buf.document_symbol,
    description = "lsp: Show file symbols",
    opts = opts,
  },
  {
    "gws",
    vim.lsp.buf.workspace_symbol,
    description = "lsp: Show workspace symbols",
    opts = opts,
  },
  {
    "<leader>cl",
    vim.lsp.codelens.run,
    description = "lsp: Codelens",
    opts = opts,
  },
  {
    "<leader>sh",
    vim.lsp.buf.signature_help,
    description = "lsp: Show function parameters",
    opts = opts,
  },
  {
    "<leader>rn",
    vim.lsp.buf.rename,
    description = "lsp: Rename",
    opts = opts,
  },
  {
    "<leader>cf",
    vim.lsp.buf.format,
    description = "lsp: Format code",
    opts = opts,
  },
  {
    "<leader>ca",
    vim.lsp.buf.code_action,
    description = "lsp: Show code actions",
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
    "[c",
    function() vim.diagnostic.goto_prev({ wrap = false }) end,
    description = "diagnostic: Go to next",
    opts = opts,
  },
  {
    "]c",
    function() vim.diagnostic.goto_next({ wrap = false }) end,
    description = "diagnostic: Go to previous",
    opts = opts,
  },
})
