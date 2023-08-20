-- do not loose yanked thing after pasting on any selected text
-- vim.keymap.set("x", "<leader>p", "\"_dP", opts)

require('legendary').keymaps({
  {
    "<C-s>",
    { n = ":wa<CR>", i = "<Esc>:wa<CR>" },
    description = "Save current buffer",
  },
  {
    "<A-s>",
    ":source %<CR>",
    description = "Source current file"
  },
  {
    "<A-q>",
    ":q<CR>",
    description = "Close current window"
  },
  {
    "<A-S-q>",
    ":qa!<CR>",
    description = "Quit"
  },
  {
    "<",
    "<gv",
    description = "Unindent and stay in visual mode"
  },
  {
    ">",
    ">gv",
    description = "Indent and stay in visual mode"
  },
  {
    "<leader>J",
    "mzJ`z",
    description = "Merge lines, cursor positions stays unchanged"
  },
  {
    "gd",
    vim.lsp.buf.definition,
    description = "lsp: Go to definition"
  },
  {
    "<leader>gt",
    vim.lsp.buf.type_definition,
    description = "lsp: Go to type definition"
  },
  {
    "K",
    vim.lsp.buf.hover,
    description = "lsp: Show hover"
  },
  {
    "gi",
    vim.lsp.buf.implementation,
    description = "lsp: Go to implementation"
  },
  {
    "gr",
    vim.lsp.buf.references,
    description = "lsp: Show references as quick list"
  },
  {
    "gds",
    vim.lsp.buf.document_symbol,
    description = "lsp: Show file symbols"
  },
  {
    "gws",
    vim.lsp.buf.workspace_symbol,
    description = "lsp: Show workspace symbols"
  },
  {
    "<leader>cl",
    vim.lsp.codelens.run,
    description = "lsp: Codelens"
  },
  {
    "<leader>sh",
    vim.lsp.buf.signature_help,
    description = "lsp: Show function parameters"
  },
  {
    "<leader>rn",
    vim.lsp.buf.rename,
    description = "lsp: Rename"
  },
  {
    "<leader>cf",
    vim.lsp.buf.format,
    description = "lsp: Format code"
  },
  {
    "<leader>ca",
    vim.lsp.buf.code_action,
    description = "lsp: Show code actions"
  },
  {
    "<leader>aa",
    vim.diagnostic.setqflist,
    description = "diagnostic: Open all as quick list"
  },
  {
    "<leader>ae",
    function() vim.diagnostic.setqflist({ severity = "E" }) end,
    description = "diagnostic: Open errors as quicklist"
  },
  {
    "<leader>aw",
    function() vim.diagnostic.setqflist({ severity = "W" }) end,
    description = "diagnostic: Open warnings as quicklist"
  },
  {
    "<leader>d",
    vim.diagnostic.setloclist,
    description = "diagnostic: Show buffers diagnostics"
  },
  {
    "[c",
    function() vim.diagnostic.goto_prev({ wrap = false }) end,
    description = "diagnostic: Go to next"
  },
  {
    "]c",
    function() vim.diagnostic.goto_next({ wrap = false }) end,
    description = "diagnostic: Go to previous"
  },
})
