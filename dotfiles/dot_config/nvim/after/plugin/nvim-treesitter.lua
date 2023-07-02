require("nvim-treesitter.configs").setup {
 ensure_installed = { "scala", "javascript", "typescript", "lua", "vim", "vimdoc", "query" },
 sync_install = false,
 auto_install = true,
 highlight = {
   enable = true,
   additional_vim_regex_highlighting = false,
 },
}
