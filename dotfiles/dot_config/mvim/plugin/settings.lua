-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true

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


local opt = vim.opt

vim.opt.autoindent = true
opt.autowrite = true -- Enable auto write
vim.opt.backup = false
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
-- if vim.fn.has('wsl') == 1 then
--   vim.g.clipboard = {
--     name = 'WslClipboard',
--     copy = {
--       ['+'] = 'clip.exe',
--       ['*'] = 'clip.exe',
--     },
--     paste = {
--       ['+'] =
--       'powershell.exe -NoProfile -NoLogo -NonInteractive -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--       ['*'] =
--       'powershell.exe -NoProfile -NoLogo -NonInteractive -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     },
--     cache_enabled = 0,
--   }
-- end
opt.completeopt = "menu,menuone,noselect"
-- vim.opt.completeopt = 'longest,menuone,noinsert,noselect' -- autocomplete options
opt.conceallevel = 2  -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true    -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true  -- Use spaces instead of tabs
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
opt.foldlevel = 99
opt.foldmethod = "expr"
-- vim.opt.foldmethod = 'marker'  -- enable folding (default 'foldmarker')
opt.foldtext = ""
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj
--vim.opt.formatoptions:remove "o"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
vim.opt.hidden = true      -- enable background buffers
vim.opt.history = 100      -- remember N lines in history
vim.opt.hlsearch = true
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.incsearch = true
opt.jumpoptions = "view"
opt.laststatus = 3         -- global statusline
vim.opt.lazyredraw = true  -- faster scrolling
opt.linebreak = true       -- Wrap lines at convenient points
opt.list = true            -- Show some invisible characters (tabs...
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.mouse = "a"            -- Enable mouse mode
opt.number = true          -- Print line number
vim.opt.numberwidth = 4
opt.pumblend = 10          -- Popup blend
opt.pumheight = 10         -- Maximum number of entries in a popup
opt.relativenumber = false -- Relative line numbers
opt.ruler = false          -- Disable the default ruler
opt.scrolloff = 8          -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true      -- Round indent
opt.shiftwidth = 2         -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false       -- Dont show mode since we have a statusline
opt.sidescrolloff = 8      -- Columns of context
opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true       -- Don't ignore case with capitals
opt.smartindent = true     -- Insert indents automatically
opt.smoothscroll = true
vim.opt.softtabstop = 2
opt.spelllang = { "en" }
vim.opt.splitright = true                     -- vertical split to the right
opt.splitbelow = true                         -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true                         -- Put new windows right of current
-- opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
vim.opt.showmatch = true                      -- highlight matching parenthesis
vim.opt.swapfile = false                      -- don't use swapfile
opt.tabstop = 2                               -- Number of spaces tabs count for
opt.termguicolors = true                      -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.virtualedit = "block"          -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmenu = true
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- vim.cmd "set whichwrap+=<,>,[,],h,l"  -- goes to next line if you at the end and pressed 'l'
-- vim.cmd [[set iskeyword+=-]]  -- treat '-' as a part of word (in text-objects like '')

-- from metals
-- vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
-- requirement of metals
--vim.opt_global.shortmess:remove("F"):append("c")

-- vim.opt.formatoptions:remove('r')
-- vim.opt.formatoptions:remove('c')
-- vim.opt.formatoptions:remove('o')
