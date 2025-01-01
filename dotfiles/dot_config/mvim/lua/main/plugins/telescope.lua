return {
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    config = function()
      local telescope = require("telescope")
      local actions = require "telescope.actions"
      -- local fb_actions = telescope.extensions.file_browser.actions
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
          dynamic_preview_title = true,
          --[[ width = 0.87,
          height = 0.80,
          preview_cutoff = 120, ]]
          file_ignore_patterns = { "node_modules", "target", "%.semanticdb" },
        },
        extensions = {
          ["ui-select"] = {
            layout_strategy = "center",
          }
        },
      }
      telescope.load_extension("ui-select")
      -- telescope.load_extension('chezmoi')

      local builtin = require('telescope.builtin')

      require("legendary").keymaps({
        {
          '<leader>ff',
          builtin.find_files,
          description = 'telescope: List files in current working directory'
        },
        {
          '<leader>ft',
          builtin.git_files,
          description = 'telescope: List git respository files'
        },
        {
          '<leader>fg',
          builtin.live_grep,
          description = "telescope: Live grep"
        },
        {
          '<leader>F',
          function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end,
          description = "telescope: Find word"
        },
        {
          '<leader>fb',
          builtin.buffers,
          description = "telescope: List open buffers"
        },
        {
          '<leader>fh',
          function()
            vim.o.shellslash = false -- workaround o windows
            builtin.help_tags()
            vim.o.shellslash = true
          end,
          description = "telescope: List help tags"
        },
        {
          '<leader>fo',
          builtin.oldfiles,
          description = "telescope: List previously open files"
        },
        {
          '<leader><leader>fc',
          builtin.commands,
          description = "telescope: List available commands"
        },
        {
          '<leader>fc',
          builtin.command_history,
          description = "telescope: List recently executed commands"
        },
        {
          '<leader>fR',
          builtin.registers,
          description = 'telescope: List registers'
        },
        {
          '<leader>fl',
          builtin.resume,
          description = 'telescope: Open last picker'
        },
        {
          '<leader><leader>fk',
          builtin.keymaps,
          description = 'telescope: List normal mode keybindings'
        },
        -- lsp pickers
        {
          '<leader>gd',
          builtin.lsp_type_definitions,
          description = 'telescope-lsp: Go to type definition or list'
        },
        {
          '<leader>fw',
          builtin.lsp_dynamic_workspace_symbols,
          description = 'telescope-lsp: Find workspace symbols'
        },
        {
          '<leader>fs',
          builtin.lsp_document_symbols,
          description = 'telescope-lsp: Show symbols in current file'
        },
        {
          '<leader>fr',
          builtin.lsp_references,
          description = 'telescope-lsp: List symbol references'
        },
        {
          '<leader>fd',
          builtin.diagnostics,
          description = 'telescope: Show diagnostics'
        },

      })
    end
  }
}
