local telescope = require("telescope")
local actions = require "telescope.actions"
local fb_actions = telescope.extensions.file_browser.actions
telescope.setup {
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
      hijack_netrw = true,
      select_buffer = true,
      grouped = true,
      -- collapse_dirs = true,
      hidden = true,
      initial_mode = 'normal',
      mappings = {
        ["n"] = {
          ["G"] = function(bufnr) fb_actions.toggle_respect_gitignore(bufnr) end,
          ["H"] = fb_actions.toggle_hidden,
          ["h"] = fb_actions.goto_parent_dir,
          ["l"] = actions.select_default,
        },
      },
      -- mappings = {
      --   ["i"] = {
      --     ["<A-c>"] = fb_actions.create,
      --     ["<S-CR>"] = fb_actions.create_from_prompt,
      --     ["<A-r>"] = fb_actions.rename,
      --     ["<A-m>"] = fb_actions.move,
      --     ["<A-y>"] = fb_actions.copy,
      --     ["<A-d>"] = fb_actions.remove,
      --     ["<C-o>"] = fb_actions.open,
      --     ["<C-g>"] = fb_actions.goto_parent_dir,
      --     ["<C-e>"] = fb_actions.goto_home_dir,
      --     ["<C-w>"] = fb_actions.goto_cwd,
      --     ["<C-t>"] = fb_actions.change_cwd,
      --     ["<C-f>"] = fb_actions.toggle_browser,
      --     ["<C-h>"] = fb_actions.toggle_hidden,
      --     ["<C-s>"] = fb_actions.toggle_all,
      --     ["<bs>"] = fb_actions.backspace,
      --   },
      --   ["n"] = {
      --     ["c"] = fb_actions.create,
      --     ["r"] = fb_actions.rename,
      --     ["m"] = fb_actions.move,
      --     ["y"] = fb_actions.copy,
      --     ["d"] = fb_actions.remove,
      --     ["o"] = fb_actions.open,
      --     ["g"] = fb_actions.goto_parent_dir,
      --     ["e"] = fb_actions.goto_home_dir,
      --     ["w"] = fb_actions.goto_cwd,
      --     ["t"] = fb_actions.change_cwd,
      --     ["f"] = fb_actions.toggle_browser,
      --     ["h"] = fb_actions.toggle_hidden,
      --     ["s"] = fb_actions.toggle_all,
      --   },
      -- theme = "ivy",
      -- display_stat = { date = false, size = false, mode = false },
      -- display_stat = false,
    }
  },
}
telescope.load_extension "file_browser"

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fr', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fe', builtin.oldfiles, {})

vim.keymap.set("n", "<space>fm", ":Telescope file_browser<CR>", { noremap = true })
vim.keymap.set("n", "<space>fc", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
