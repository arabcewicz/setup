-- general
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disable netrw
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

vim.opt.mouse = 'a'

if vim.fn.has('wsl2') then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -NoProfile -NoLogo -NonInteractive -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -NoProfile -NoLogo -NonInteractive -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

--vim.opt.clipboard = 'unnamedplus'                         -- copy/paste to system clipboard
vim.opt.completeopt = 'longest,menuone,noinsert,noselect' -- autocomplete options
vim.opt.encoding = 'utf8'
vim.opt.ambiwidth = 'single'

vim.opt.swapfile = false -- don't use swapfile
vim.opt.undofile = true  -- save undo history
vim.opt.backup = false

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
vim.opt.showmatch = true      -- highlight matching parenthesis
vim.opt.foldmethod = 'marker' -- enable folding (default 'foldmarker')
--vim.opt.colorcolumn = '120'      -- line lenght marker at 80 columns
vim.opt.splitright = true     -- vertical split to the right
vim.opt.splitbelow = true     -- horizontal split to the bottom
vim.opt.ignorecase = false    -- ignore case letters when search
vim.opt.smartcase = true      -- ignore lowercase for the whole pattern
vim.opt.termguicolors = true  -- enable 24-bit RGB colors
vim.opt.laststatus = 3        -- set global statusline
vim.opt.signcolumn = 'yes'
vim.opt.wrap = true
vim.opt.linebreak = true -- wrap on word boundary
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8

-- memory, cPU
vim.opt.hidden = true     -- enable background buffers
vim.opt.history = 100     -- remember N lines in history
vim.opt.lazyredraw = true -- faster scrolling
vim.opt.synmaxcol = 240   -- max column for syntax highlight
vim.opt.updatetime = 70   -- ms to wait for trigger an event


-- wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full"

-- vim.cmd "set whichwrap+=<,>,[,],h,l"  -- goes to next line if you at the end and pressed 'l'
-- vim.cmd [[set iskeyword+=-]]  -- treat '-' as a part of word (in text-objects like '')

-- from metals
vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }
-- requirement of metals
--vim.opt_global.shortmess:remove("F"):append("c")


vim.opt.formatoptions:remove('r')
vim.opt.formatoptions:remove('c')
vim.opt.formatoptions:remove('o')

-- Autogroups
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- managed by yanky.nvim now
-- Highlight on yank
-- augroup('YankHighlight', { clear = true })
-- autocmd('TextYankPost', {
--   group = 'YankHighlight',
--   callback = function()
--     vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '300' })
--   end
-- })

-- Remove whitespace on save
autocmd('BufWritePre', {
  pattern = '*',
  command = ":%s/\\s\\+$//e"
})


-- Format on save
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*',
--   command = "lua vim.lsp.buf.format()"
-- })

-- Settings for fyletypes:
-- Disable line lenght marker
--[[ augroup('setLineLenght', { clear = true })
autocmd('Filetype', {
  group = 'setLineLenght',
  pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
  command = 'setlocal cc=0'
}) ]]


--Transparent background
--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
