-- general
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'         -- copy/paste to system clipboard
vim.opt.swapfile = false                  -- don't use swapfile
vim.opt.completeopt = 'longest,menuone,noinsert,noselect'  -- autocomplete options
vim.opt.undofile = true                -- save undo history
vim.opt.encoding = 'utf8'
vim.opt.ambiwidth = 'single'

-- tabs, intend
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

-- ui
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.showmatch = true        -- highlight matching parenthesis
vim.opt.foldmethod = 'marker'   -- enable folding (default 'foldmarker')
--vim.opt.colorcolumn = '120'      -- line lenght marker at 80 columns
vim.opt.splitright = true       -- vertical split to the right
vim.opt.splitbelow = true       -- horizontal split to the bottom
vim.opt.ignorecase = false       -- ignore case letters when search
vim.opt.smartcase = true        -- ignore lowercase for the whole pattern
vim.opt.linebreak = true        -- wrap on word boundary
vim.opt.termguicolors = true    -- enable 24-bit RGB colors
vim.opt.laststatus = 3            -- set global statusline
vim.opt.signcolumn = 'yes'

-- memory, cPU
vim.opt.hidden = true           -- enable background buffers
vim.opt.history = 100           -- remember N lines in history
vim.opt.lazyredraw = true       -- faster scrolling
vim.opt.synmaxcol = 240         -- max column for syntax highlight
vim.opt.updatetime = 700        -- ms to wait for trigger an event


-- wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full"

vim.cmd "set whichwrap+=<,>,[,],h,l"  -- goes to next line if you at the end and pressed 'l'
vim.cmd [[set iskeyword+=-]]  -- treat '-' as a part of word (in text-objects like '')

vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
-- requirement of metals
--vim.opt_global.shortmess:remove("F"):append("c")

require("main/plugins")

