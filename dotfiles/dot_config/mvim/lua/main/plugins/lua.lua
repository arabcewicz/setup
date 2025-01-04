return {
  {
    "folke/lazydev.nvim",
    enabled = true,
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "lazy.nvim",          words = { "LazyVim" } },
      },
    },
  },
  -- { -- optional blink completion source for require statements and module annotations
  --   "saghen/blink.cmp",
  --   opts = {
  --     sources = {
  --       -- add lazydev to your completion providers
  --       completion = {
  --         enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
  --       },
  --       providers = {
  --         -- dont show LuaLS require statements when lazydev has items
  --         lsp = { fallback_for = { "lazydev" } },
  --         lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
  --       },
  --     },
  --   },
  -- }
}
