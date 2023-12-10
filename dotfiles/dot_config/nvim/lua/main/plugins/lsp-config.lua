return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require('lspconfig')
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    lspconfig.marksman.setup({})

    lspconfig.lua_ls.setup {
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


    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local bufnr = ev.buf
        -- local opts = { buffer = bufnr }
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        -- if client.server_capabilities.completionProvider then
        --   -- Enable completion triggered by <c-x><c-o>
        --   vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        -- end
        -- if client.server_capabilities.definitionProvider then
        --   vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        -- end

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        -- vim.keymap.set('n', '<space>wl', function()
        --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, opts)
        -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
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
  end
}
