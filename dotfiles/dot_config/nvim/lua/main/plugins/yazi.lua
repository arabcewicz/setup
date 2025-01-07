return
{
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ea",
      function()
        if LazyVim.is_win() then vim.o.shellslash = true end
        require("yazi").yazi()
        if LazyVim.is_win() then vim.o.shellslash = false end
      end,
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>er",
      function()
        if LazyVim.is_win() then vim.o.shellslash = true end
        require("yazi").yazi(nil, vim.fn.getcwd())
        if LazyVim.is_win() then vim.o.shellslash = false end
      end,
      desc = "Open the file manager in nvim's working directory",
    },
    {
      -- NOTE: this requires a version of yazi that includes
      -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
      '<leader>ee',
      function()
        if LazyVim.is_win() then vim.o.shellslash = true end
        require("yazi").toggle()
        if LazyVim.is_win() then vim.o.shellslash = false end
      end,
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = false,
    -- open_multiple_tabs = true,
    keymaps = {
      show_help = '<f1>',
      open_file_in_horizontal_split = '<c-s>',
      grep_in_directory = '<c-g>',
      replace_in_directory = '<c-r>',
    },
    -- open_file_function = function(chosen_file)
    --   P("asfas")
    --   P(vim.fn.fnameescape(chosen_file))
    -- end,
    future_features = {
      -- Whether to use `ya emit reveal` to reveal files in the file manager.
      -- Requires yazi 0.4.0 or later (from 2024-12-08).
      ya_emit_reveal = true,

      -- Use `ya emit open` as a more robust implementation for opening files
      -- in yazi. This can prevent conflicts with custom keymappings for the enter
      -- key. Requires yazi 0.4.0 or later (from 2024-12-08).
      ya_emit_open = true,
    },
  },
}
