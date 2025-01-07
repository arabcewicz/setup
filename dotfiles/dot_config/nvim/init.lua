vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

P = function(v)
  print(vim.inspect(v))
  return v
end

_G.LazyVim = {
  is_win = function()
    return vim.uv.os_uname().sysname:find("Windows") ~= nil
  end,

  lsp = {
    execute = function(opts)
      local params = {
        command = opts.command,
        arguments = opts.arguments,
      }
      if opts.open then
        require("trouble").open({
          mode = "lsp_command",
          params = params,
        })
      else
        return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
      end
    end,

    action = setmetatable({}, {
      __index = function(_, action)
        return function()
          vim.lsp.buf.code_action({
            apply = true,
            context = {
              only = { action },
              diagnostics = {},
            },
          })
        end
      end,
    }),

    on_attach = function(on_attach, name)
      return vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf ---@type number
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and (not name or client.name == name) then
            return on_attach(client, buffer)
          end
        end,
      })
    end,

    get_raw_config = function(server)
      local ok, ret = pcall(require, "lspconfig.configs." .. server)
      if ok then
        return ret
      end
      return require("lspconfig.server_configurations." .. server)
    end,



  },
}


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "main.plugins" },
  },
  ui = {
    border = "single"
  },
  change_detection = {
    notify = false,
  },

})
