vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require("auto-session").setup {
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/Downloads", "/", "/tmp/*" },
}

vim.keymap.set("n", "<leader>fpp", require("auto-session.session-lens").search_session, { noremap = true })

-- fix for nvim-tree
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#workaround-when-using-rmagattiauto-session

--[[ vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')

    if not view.is_visible() then
      api.tree.open()
    end
  end,
}) ]]
