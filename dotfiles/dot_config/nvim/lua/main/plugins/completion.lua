return {
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    config = function()
      local lspkind = require('lspkind')
      local cmp = require('cmp')
      local luasnip = require 'luasnip'

      luasnip.config.setup {}
      cmp.setup({
        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-a>'] = cmp.mapping.abort(),
        }),
        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
        formatting = {
          expandable_indicator = true,
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
                path = "[path]",
                vsnip = "[vsnip]",
                obsidian = "[obs]",
              })[entry.source.name]
              return vim_item
            end
          })
        },
        sources = cmp.config.sources({
          {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          },
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
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })
      -- If you want insert `(` after select function or method item
      -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      -- cmp.event:on(
      --   'confirm_done',
      --   cmp_autopairs.on_confirm_done()
      -- )


      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-nvim-lua" },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  { "saadparwaiz1/cmp_luasnip" },
  { 'onsails/lspkind-nvim' },
}
