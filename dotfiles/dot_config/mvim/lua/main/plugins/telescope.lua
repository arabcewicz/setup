return {
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    priority = 9900,
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        entry_prefix = "  ",
        color_devicons = true,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
        },
        dynamic_preview_title = true,
        file_ignore_patterns = { "node_modules", "target", "%.semanticdb" },
      },
      extensions = {
        ["ui-select"] = {
          layout_strategy = "center",
        }
      },
    },
    init = function()
      require("telescope").load_extension("ui-select")
    end,
    keys = {
      { '<leader>ff', require('telescope.builtin').find_files, desc = 'telescope: List files in current working directory' },
      { '<leader>ft', require('telescope.builtin').git_files,  desc = 'telescope: List git respository files' },
      { '<leader>fg', require('telescope.builtin').live_grep,  desc = "telescope: Live grep" },
      {
        '<leader>F',
        function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }) end,
        desc = "telescope: Find word"
      },
      { '<leader>fb', require('telescope.builtin').buffers,                       desc = "telescope: List open buffers" },
      {
        '<leader>fh',
        function()
          vim.o.shellslash = false -- workaround o windows
          require('telescope.builtin').help_tags()
          vim.o.shellslash = true
        end,
        desc = "telescope: List help tags"
      },
      { '<leader>fo', require('telescope.builtin').oldfiles,                      desc = "telescope: List previously open files" },
      { '<leader>fc', require('telescope.builtin').commands,                      desc = "telescope: List available commands" },
      { '<leader>fC', require('telescope.builtin').command_history,               desc = "telescope: List recently executed commands" },
      { '<leader>fR', require('telescope.builtin').registers,                     desc = 'telescope: List registers' },
      { '<leader>fl', require('telescope.builtin').resume,                        desc = 'telescope: Open last picker' },
      { '<leader>fk', require('telescope.builtin').keymaps,                       desc = 'telescope: List normal mode keybindings' },
      { '<leader>gd', require('telescope.builtin').lsp_type_definitions,          desc = 'telescope-lsp: Go to type definition or list' },
      { '<leader>fw', require('telescope.builtin').lsp_dynamic_workspace_symbols, desc = 'telescope-lsp: Find workspace symbols' },
      { '<leader>fs', require('telescope.builtin').lsp_document_symbols,          desc = 'telescope-lsp: Show symbols in current file' },
      { '<leader>fr', require('telescope.builtin').lsp_references,                desc = 'telescope-lsp: List symbol references' },
      { '<leader>fd', require('telescope.builtin').diagnostics,                   desc = 'telescope: Show diagnostics' },
    },
  }
}
