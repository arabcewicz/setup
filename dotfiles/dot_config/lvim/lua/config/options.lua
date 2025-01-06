-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- https://github.com/nushell/integrations/blob/main/nvim/init.lua
vim.o.shell = "nu"
vim.o.shellcmdflag = "--login --stdin --no-newline -c"
vim.o.shellredir = "out+err> %s"
vim.o.shellpipe = "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record"
vim.o.shellslash = true
vim.o.shelltemp = false
vim.o.shellxescape = ""
vim.o.shellxquote = ""
vim.o.shellquote = ""
