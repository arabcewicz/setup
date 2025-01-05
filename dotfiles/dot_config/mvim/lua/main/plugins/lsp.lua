return {
  {
    "williamboman/mason.nvim",
    enabled = true,
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
      }
    },
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" }
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    enabled = true,
    opts = {
      ensure_installed = {}, -- servers will be added automatically
      automatic_installation = true,
    }
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
      setup = {
      },
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
        virtual_text = true,
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
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
                vim.diagnostic.show() -- TODO: workaround as diagnostics disappear after save ??
              end,
            })
          end

          -- TODO: set only if server has such capablity (see LazyVim)
          -- TODO: put this outside and cache
          local keymaps = {
            { "<leader>cl", "<cmd>LspInfo<cr>",                                 desc = "lsp: Lsp Info" },
            { "gd",         vim.lsp.buf.definition,                             desc = "lsp: Goto Definition",            has = "definition" },
            -- { "gr",         vim.lsp.buf.references,                          desc = "lsp: References",                 nowait = true },
            { "gI",         vim.lsp.buf.implementation,                         desc = "lsp: Goto Implementation" },
            { "gy",         vim.lsp.buf.type_definition,                        desc = "lsp: Goto T[y]pe Definition" },
            { "gD",         vim.lsp.buf.declaration,                            desc = "lsp: Goto Declaration" },
            { "K",          function() return vim.lsp.buf.hover() end,          desc = "lsp: Hover" },
            { "gK",         function() return vim.lsp.buf.signature_help() end, desc = "lsp: Signature Help",             has = "signatureHelp" },
            { "<C-p>",      function() return vim.lsp.buf.signature_help() end, mode = "i",                               desc = "Signature Help", has = "signatureHelp" },
            { "<leader>ca", vim.lsp.buf.code_action,                            desc = "lsp: Code Action",                mode = { "n", "v" },     has = "codeAction" },
            { "<leader>cc", vim.lsp.codelens.run,                               desc = "lsp: Run Codelens",               mode = { "n", "v" },     has = "codeLens" },
            { "<leader>cC", vim.lsp.codelens.refresh,                           desc = "lsp: Refresh & Display Codelens", mode = { "n" },          has = "codeLens" },
            -- { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "lsp: Rename File",                mode = { "n" },          has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
            { "<leader>cr", vim.lsp.buf.rename,                                 desc = "lsp: Rename",                     has = "rename" },
            { "<leader>cf", vim.lsp.buf.format,                                 desc = "lsp: Format",                     has = "format??" },
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

      local servers = opts.servers
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities), },
          servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        else
          require("lspconfig")[server].setup(server_opts)
        end
      end


      local all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        setup(server)
        -- local fts = require("lspconfig")["lua_ls"].filetypes
        if vim.tbl_contains(all_mlsp_servers, server, {}) then
          ensure_installed[#ensure_installed + 1] = server
        end
      end
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_deep_extend(
          "force",
          ensure_installed,
          require("lazy.core.plugin").values("mason-lspconfig.nvim", "opts", false).ensure_installed or {}
        ),
        handlers = { setup }
      })
    end
  },
}
