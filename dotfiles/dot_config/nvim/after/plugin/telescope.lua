local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<M-t>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', function() builtin.grep_string({search = vim.fn.input("Grep > ")}) end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require("telescope").setup {
  defaults = {
    prompt_prefix = "   ",
    -- selection_caret = "  ",
    entry_prefix = "  ",
    color_devicons = true,
    -- set_env = { ["COLORTERM"] = "truecolor" },
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
    },
    --[[ width = 0.87,
    height = 0.80,
    preview_cutoff = 120, ]]
  },
  extensions = {
    file_browser = {
      -- theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      -- display_stat = { date = false, size = false, mode = false },
      display_stat = false,
      grouped = true,
      hijack_netrw = true,
    }
  },
}
require("telescope").load_extension "file_browser"

vim.keymap.set( "n", "<space>fm", ":Telescope file_browser<CR>", { noremap = true })
-- open file_browser with the path of the current buffer
vim.keymap.set( "n", "<space>fn", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
