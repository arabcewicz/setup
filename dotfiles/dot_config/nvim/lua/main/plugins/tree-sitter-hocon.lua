return {
  'antosha417/tree-sitter-hocon',
  lazy = false,
  config = function()
    local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
    vim.api.nvim_create_autocmd(
      { 'BufNewFile', 'BufRead' },
      { group = hocon_group, pattern = '*/resources/*.conf', command = 'set ft=hocon' }
    )
  end

}
