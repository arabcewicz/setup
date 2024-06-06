return {
  { 'nvim-telescope/telescope-file-browser.nvim' },
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
          dynamic_preview_title = true,
          --[[ width = 0.87,
          height = 0.80,
          preview_cutoff = 120, ]]
          file_ignore_patterns = { "node_modules", "target", "%.semanticdb" },
        },
        extensions = {
          ["file_browser"] = {
            hijack_netrw = false,
            select_buffer = true,
            grouped = true,
            -- collapse_dirs = true,
            hidden = true,
            depth = false,
            --initial_mode = 'normal',
            mappings = {
              ["n"] = {
                ["G"] = function(bufnr) fb_actions.toggle_respect_gitignore(bufnr) end,
                ["H"] = fb_actions.toggle_hidden,
                ["h"] = fb_actions.goto_parent_dir,
                ["l"] = actions.select_default,
              },
            },
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
          },
          ["ui-select"] = {
            layout_strategy = "center",
            -- require("telescope.themes").get_dropdown {
            --   {
            --     winblend = 25,
            --     layout_config = {
            --       prompt_position = "top",
            --       -- width = 80,
            --       -- height = 12,
            --     },
            --     -- borderchars = lvim.builtin.telescope.defaults.borderchars,
            --     border = {},
            --     previewer = false,
            --     shorten_path = false,
            --   }
            -- },
          }
        },
      }
      telescope.load_extension("file_browser")
      telescope.load_extension("ui-select")


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
          builtin.help_tags,
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

        -- telescope-file-browser.nvim
        {
          "<leader>fe",
          ":Telescope file_browser<CR>",
          description = "telescope-file-browser: File explorer"
        },
        {
          "<leader>fa",
          ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
          description = "telescope-file-browser: Show current file in file explorer"
        },
      })
    end
  }
}
