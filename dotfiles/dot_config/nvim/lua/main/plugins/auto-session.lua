vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

require("auto-session").setup {
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/Downloads", "/", "/tmp/*" },
}


require('legendary').keymaps({
  {
    "<leader>fp",
    require("auto-session.session-lens").search_session,
    description = "auto-session: List saved sessions"
  },
})
