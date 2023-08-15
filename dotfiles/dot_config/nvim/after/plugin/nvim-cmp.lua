local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup({
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- 'text_symbol', -- 'symbol',
      maxwidth = 50,
      ellipsis_char = '...',
      before = function(entry, vim_item)
        local lsp = "[lsp]"
        if entry.source.name == 'nvim_lsp' then
          pcall(function()
            lsp = "[" .. entry.source.source.client.name .. "]"
          end)
        end
        vim_item.menu = ({
          buffer = "[buf]",
          nvim_lsp = lsp,
          nvim_lua = "[lua]",
          path = "[path]",
          vsnip = "[vsnip]",
          obsidian = "[obs]",
        })[entry.source.name]
        return vim_item
      end
    })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer', keyword_length = 5 },
    { name = 'path' },
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
