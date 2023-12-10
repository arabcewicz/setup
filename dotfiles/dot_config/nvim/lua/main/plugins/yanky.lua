return {
  'gbprod/yanky.nvim',
  lazy = false,
  event = "VeryLazy",
  config = function()
    -- has to be before setup; otherwise 'preserve_cursor_position' doesn't work
    vim.keymap.set({ "n", "x" }, "y", '<Plug>(YankyYank)')

    local utils = require("yanky.utils")
    local mapping = require("yanky.telescope.mapping")
    require("yanky").setup({
      ring = {
        ignore_registers = { "_" },
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
              ["<A-a>"] = mapping.set_register("a"),
              ["<A-b>"] = mapping.set_register("b"),
              ["<A-c>"] = mapping.set_register("c"),
            },
            n = {
              p = mapping.put("p"),
              P = mapping.put("P"),
              d = mapping.delete(),
              ra = mapping.set_register("a"),
              rb = mapping.set_register("b"),
              rc = mapping.set_register("c"),
            },
          }
        }
      },
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = false,
        on_yank = true,
        timer = 300,
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
        "<Plug>(YankyGPutBefore)",
        mode = { 'n', 'x' },
        description = "yanky: Put before cursor and leave the cursor after"
      },
      {
        '<leader>p',
        '"+<Plug>(YankyPutAfter)',
        mode = { 'n', 'x' },
        description = "yanky: Put from system clipboard after cursor"
      },
      {
        '<leader>P',
        '"+<Plug>(YankyPutBefore)',
        mode = { 'n', 'x' },
        description = "yanky: Put from system clipboard before cursor"
      },
      {
        '<leader>gp',
        '"+<Plug>(YankyGPutAfter)',
        mode = { 'n', 'x' },
        description = "yanky: Put from system clipboard after cursor and leave the cursor after",
      },
      {
        '<leader>gP',
        '"+<Plug>(YankyGPutBefore)',
        mode = { 'n', 'x' },
        description = "yanky: Put from system clipboard before cursor and leave the cursor after"
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
      -- {
      --   "<C-S-p>",
      --   {
      --     n = function() require("telescope").extensions.yank_history.yank_history() end,
      --     i = function() require("telescope").extensions.yank_history.yank_history() end,
      --   },
      --   description = "yanky: List yank ring"
      -- },
      {
        -- defined on top of file
        "y",
        description = "yanky: Yank"
      },
      {
        "<leader>y",
        { n = '"+<Plug>(YankyYank)', x = '"+<Plug>(YankyYank)' },
        description = "yanky: Yank to system clipboard"
      },
    })

    -- vim.keymap.set({ "n", "x" }, "<leader>y", function() return require("yanky").yank({ register = "+" }) end, { expr = true })
    require("telescope").load_extension("yank_history")

    -- vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
    -- vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")
    -- vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
    -- vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
    -- vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
    -- vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")
    -- vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
    -- vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
  end
}
