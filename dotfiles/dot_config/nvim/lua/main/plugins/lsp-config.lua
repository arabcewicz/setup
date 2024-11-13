local common_on_attach_run = false

local common_on_attach = function(client)
  if not common_on_attach_run then
    local opts = { noremap = true, silent = true }
    require('legendary').keymaps({
      {
        "gd",
        vim.lsp.buf.definition,
        description = "lsp: Go to definition",
        opts = opts,
      },
      {
        "gD",
        vim.lsp.buf.declaration,
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
        "<leader>gs",
        vim.lsp.buf.document_symbol,
        description = "lsp: Show file symbols",
        opts = opts,
      },
      {
        "<leader>gw",
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
        vim.lsp.buf.format({ timeout_ms = 5000 }),
        description = "lsp: Format code",
        opts = opts,
      },
      {
        "<leader>ca",
        vim.lsp.buf.code_action,
        description = "lsp: Show code actions",
        opts = opts,
      },
    })
  end
  common_on_attach_run = true
end


return {
  {
    "williamboman/mason.nvim",
    opts = {
      PATH = "append",
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- opts = {
    -- ensure_installed = { "lua_ls", "rust_analyzer", "tsserver", "tailwindcss" },
    -- ensure_installed = { "lua_ls", "tailwindcss" },
    -- }
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- border for :LspInfo window
      require('lspconfig.ui.windows').default_options.border = 'single'
      vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

      local _border = "single"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = _border
        }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = _border
        }
      )
      vim.diagnostic.config {
        float = { border = _border }
      }

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(event)
          local bufnr = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })
            -- Format on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
            })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        -- pyright = {},
        rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              diagnostics = {
                globals = { 'vim' }
              }
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            server.on_attach = common_on_attach
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end
  },

  {
    "scalameta/nvim-metals",
    ft = { "scala", "sbt" }, -- "java"
    opts = function()
      local metals = require("metals").bare_config()
      metals.settings = {
        showImplicitArguments = true,
        showInferredType = true,
        superMethodLensesEnabled = true,
        showImplicitConversionsAndClasses = true
      }

      -- *READ THIS*
      -- I *highly* recommend setting statusBarProvider to true, however if you do,
      -- you *have* to have a setting to display this in your statusline or else
      -- you'll not see any messages from metals. There is more info in the help
      -- docs about this
      metals.init_options.statusBarProvider = "off"

      -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
      metals.capabilities = require("cmp_nvim_lsp").default_capabilities()

      metals.tvp = {
        panel_width = 50,
        panel_alignment = "right",
        toggle_node_mapping = "l",
        node_command_mapping = "o",
        collapsed_sign = "▸",
        expanded_sign = "▾",
        icons = {
          enabled = true,
          symbols = {
            object = "",
            trait = "",
            class = "ﭰ",
            interface = "",
            val = "",
            var = "",
            method = "ﬦ",
            enum = "",
            field = "",
            package = "",
          },
        },
      }

      metals.on_attach = function(client, bufnr)
        require("metals").setup_dap()
        common_on_attach(client)

        local opts = { noremap = true, silent = true }
        require('legendary').keymaps({
          {
            '<leader>ss',
            ":Telescope metals commands<CR>",
            description = "metals: Show commands in telescope picker",
            opts,
          },
          {
            '<leader>sl',
            ":MetalsToggleLogs<CR>",
            description = "metals: Toggle logs",
            opts,
          },
          {
            '<leader>gu',
            ":MetalsGotoSuperMethod<CR>",
            description = "metals: Go to super method",
            opts,
          },
          {
            '<leader>sc',
            ":MetalsCompileClean<CR>",
            description = "metals: Clean & compile",
            opts,
          },
          {
            '<leader>sa',
            function() require("metals.tvp").reveal_in_tree() end,
            description = "metals: Show in tree view",
            opts,
          },
          {
            '<leader>se',
            function() require("metals.tvp").toggle_tree_view() end,
            description = "metals: Toggle tree view",
            opts,
          },
          {
            '<leader>si',
            "MetalsImportBuild<CR>",
            description = "metals: Import build",
            opts,
          },
          {
            '<leader>sr',
            "MetalsRestartMetals<CR>",
            description = "metals: Restart metals",
            opts,
          },
          {
            '<leader>sj',
            function() require("metals").toggle_settings("showImplicitArguments") end,
            description = "metals: Toggle 'show implicit arguments'",
            opts,
          },
          {
            '<leader>K',
            function() require("metals").type_of_range() end,
            mode = { 'v' },
            description = "metals: Type of selected code",
            opts,
          },
        })
      end

      return metals
    end,

    config = function(self, metals_config)
      -- Autocmd that will actually be in charging of starting the whole thing
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        -- NOTE: You may or may not want java included here. You will need it if you
        -- want basic Java support but it may also conflict if you are using
        -- something like nvim-jdtls which also works on a java filetype autocmd.
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }

}
