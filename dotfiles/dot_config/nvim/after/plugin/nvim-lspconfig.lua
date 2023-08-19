require('lspconfig').marksman.setup({})
require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        checkThirdParty = false, -- https://github.com/LuaLS/lua-language-server/discussions/1688
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = { enable = false },
    },
  },
}
