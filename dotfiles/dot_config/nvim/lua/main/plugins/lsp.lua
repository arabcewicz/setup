return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" }
    },
    opts = {
      ui = {
        border = "rounded",
      }
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {},
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    -- config at the end of nvim-lspconfig
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      -- codelens = {
      --   enabled = false,
      -- },
      servers = {},
      setup = {},
    },
    config = function(_, opts)
      require('lspconfig.ui.windows').default_options.border = 'rounded'
      vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

      local _border = "rounded"
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
        severity_sort = true,
        float = {
          border = 'rounded',
          -- source = 'if_many'
        },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        },
        virtual_text = {
          -- source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }
      -- vim.diagnostic.config {
      --   virtual_text = true,
      --   float = { border = _border }
      -- }


      -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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


          -- if client.supports_method("textDocument/formatting") then
          --   vim.api.nvim_clear_autocmds({
          --     group = augroup,
          --     buffer = bufnr,
          --   })
          --   -- Format on save
          --   vim.api.nvim_create_autocmd('BufWritePre', {
          --     group = augroup,
          --     buffer = bufnr,
          --     callback = function()
          --       vim.lsp.buf.format({ bufnr = bufnr })
          --       vim.diagnostic.show() -- TODO: workaround as diagnostics disappear after save ??
          --     end,
          --   })
          -- end

          -- TODO: set only if server has such capablity (see LazyVim)
          -- TODO: put this outside and cache
          local keymaps = {
            { "<leader>cl", "<cmd>LspInfo<cr>",                                 desc = "lsp: Lsp Info" },
            { "gd",         vim.lsp.buf.definition,                             desc = "lsp: Goto Definition",            has = "definition" },
            { "<leader>gr", vim.lsp.buf.references,                             desc = "lsp: References",                 nowait = true },
            { "gI",         vim.lsp.buf.implementation,                         desc = "lsp: Goto Implementation" },
            { "gy",         vim.lsp.buf.type_definition,                        desc = "lsp: Goto Type Definition" },
            { "gD",         vim.lsp.buf.declaration,                            desc = "lsp: Goto Declaration" },
            { "K",          function() return vim.lsp.buf.hover() end,          desc = "lsp: Hover" },
            { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "lsp: Signature Help",             has = "signatureHelp" },
            { "<C-p>",      function() return vim.lsp.buf.signature_help() end, mode = "i",                               desc = "Signature Help", has = "signatureHelp" },
            { "<leader>ca", vim.lsp.buf.code_action,                            desc = "lsp: Code Action",                mode = { "n", "v" },     has = "codeAction" },
            { "<leader>cc", vim.lsp.codelens.run,                               desc = "lsp: Run Codelens",               mode = { "n", "v" },     has = "codeLens" },
            { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "lsp: Refresh & Display Codelens", mode = { "n" },          has = "codeLens" },
            -- { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "lsp: Rename File",                mode = { "n" },          has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
            { "<leader>cr", vim.lsp.buf.rename,                                 desc = "lsp: Rename",                     has = "rename" },
            { "<leader>cF", vim.lsp.buf.format,                                 desc = "lsp: Format",                     has = "format??" },
            -- { "<leader>cA", LazyVim.lsp.action.source,                          desc = "lsp: Source Action",              has = "codeAction" },
            -- {
            --   "]]",
            --   function() Snacks.words.jump(vim.v.count1) end,
            --   has = "documentHighlight",
            --   desc = "Next Reference",
            --   cond = function() return Snacks.words.is_enabled() end
            -- },
            -- {
            --   "[[",
            --   function() Snacks.words.jump(-vim.v.count1) end,
            --   has = "documentHighlight",
            --   desc = "Prev Reference",
            --   cond = function() return Snacks.words.is_enabled() end
            -- },
            -- {
            --   "<a-n>",
            --   function() Snacks.words.jump(vim.v.count1, true) end,
            --   has = "documentHighlight",
            --   desc = "Next Reference",
            --   cond = function() return Snacks.words.is_enabled() end
            -- },
            -- {
            --   "<a-p>",
            --   function() Snacks.words.jump(-vim.v.count1, true) end,
            --   has = "documentHighlight",
            --   desc = "Prev Reference",
            --   cond = function() return Snacks.words.is_enabled() end
            -- },
          }

          local server_maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
          vim.list_extend(keymaps, server_maps)
          for _, keys in pairs(keymaps) do
            -- local has = not keys.has or M.has(buffnr, keys.has)
            -- local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))
            --
            -- if has and cond then
            -- local opts = Keys.opts(keys)
            opts.cond = nil
            opts.has = nil
            opts.silent = opts.silent ~= false
            opts.buffer = bufnr
            vim.keymap.set(keys.mode or "n", keys[1] or "", keys[2],
              { silent = true, noremap = true, desc = keys.desc })
            -- end
          end
          -- LspAttach
        end
      })

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities() or {},
        opts.capabilities or {}
      )

      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server)
            local server_opts = vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities), },
              opts.servers[server] or {})

            if opts.setup[server] then
              if opts.setup[server](server, server_opts) then
                return
              end
            else
              require("lspconfig")[server].setup(server_opts)
            end
          end
        }
      })
    end
  },
}
