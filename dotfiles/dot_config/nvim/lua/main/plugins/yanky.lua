-- has to be before setup; otherwise 'preserve_cursor_position' doesn't work
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)")

local utils = require("yanky.utils")
local mapping = require("yanky.telescope.mapping")
require("yanky").setup({
  highlight = {
    on_put = false,
    on_yank = true,
    timer = 300,
  },
  picker = {
    telescope = {
      use_default_mappings = false,
      mappings = {
        default = mapping.put("p"),
        i = {
          ["<A-p>"] = mapping.put("p"),
          ["<A-S-p>"] = mapping.put("P"),
          ["<A-d>"] = mapping.delete(),
          ["<A-r>"] = mapping.set_register(utils.get_default_register()),
        },
        n = {
          p = mapping.put("p"),
          P = mapping.put("P"),
          d = mapping.delete(),
          r = mapping.set_register(utils.get_default_register())
        },
      }
    }
  },
  preserve_cursor_position = {
    enabled = true,
  },
})

require('legendary').keymaps({
  {
    'p',
    "<Plug>(YankyPutAfter)",
    mode = { 'n', 'x' },
    description = "yanky: Put after cursor"
  },
  {
    'P',
    "<Plug>(YankyPutBefore)",
    mode = { 'n', 'x' },
    description = "yanky: Put before cursor"
  },
  {
    'gp',
    "<Plug>(YankyGPutAfter)",
    mode = { 'n', 'x' },
    description = "yanky: Put after cursor and leave the cursor after",
  },
  {
    'gP',
    "<Plug>(YankyGPutBefor)",
    mode = { 'n', 'x' },
    description = "yanky: Put before cursor and leave the cursor after"
  },
  {
    "<C-n>",
    "<Plug>(YankyCycleForward)",
    description = "yanky: Cycle yank buffer forward"
  },
  {
    "<C-p>",
    "<Plug>(YankyCycleBackward)",
    description = "yanky: Cycle yank buffer backward"
  },
  {
    "<space>fv",
    ":Telescope yank_history<CR>",
    description = "yanky: List yank ring"
  },
  {
    "<C-S-p>",
    {
      n = function() require("telescope").extensions.yank_history.yank_history() end,
      i = function() require("telescope").extensions.yank_history.yank_history() end,
    },
    description = "yanky: List yank ring"
  },
  {
    -- defined on top of file
    "y",
    description = "yanky: Yank"
  },
  {
    "<leader>p",
    "<Plug>(YankyPutIndentAfterLinewise)",
    description = "yanky: Put linewise after cursor",
  },
  {
    "<leader>P",
    "<Plug>(YankyPutIndentBeforeLinewise)",
    description = "yanky: Put linewise before cursor",
  },
})

require("telescope").load_extension("yank_history")

-- vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
-- vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")
-- vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
-- vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
-- vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
-- vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")
-- vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
-- vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
