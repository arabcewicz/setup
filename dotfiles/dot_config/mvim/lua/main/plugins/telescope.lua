return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    priority = 9900,
    dependencies = {
      'nvim-lua/plenary.nvim',
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      return vim.tbl_deep_extend("force", opts, {
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
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-s>"] = actions.file_split,
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
            }
          },
        },
        pickers = {
          live_grep = {
            theme = "ivy",
          }
        },
        extensions = {
          ["ui-select"] = {
            layout_strategy = "center",
          }
        },
      })
    end,
    init = function()
      require("telescope").load_extension("ui-select")
    end,
    keys = {
      -- files
      -- { "<leader><space>", LazyVim.pick("files"),                desc = "Find Files (Root Dir)" },
      -- { "<leader>ff", LazyVim.pick("files"),                                            desc = "Find Files (Root Dir)" },
      { '<leader>ff', require('telescope.builtin').find_files, desc = 'telescope: Find files (root dir)' },
      -- { "<leader>fc", LazyVim.pick.config_files(),                                      desc = "Find Config File" },
      {
        '<leader>fc',
        function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath("config") } end,
        desc = 'telescope: Find config files'
      },
      -- { "<leader>fF", LazyVim.pick("files", { root = false }),                          desc = "Find Files (cwd)" },
      {
        '<leader>fF',
        function() require('telescope.builtin').find_files({ root = false }) end,
        desc = 'telescope: List files (cwd)'
      },
      -- { '<leader>ft', require('telescope.builtin').git_files,  desc = 'telescope: List git respository files' },
      { "<leader>fg", "<cmd>Telescope git_files<cr>",          desc = "telescope: Find git repository files" },
      -- { '<leader>fo', require('telescope.builtin').oldfiles,           desc = "telescope: List previously open files" },
      { "<leader>fl", "<cmd>Telescope oldfiles<cr>",           desc = "telescope: Recent files (root dir)" },
      -- { "<leader>fR", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }),                 desc = "Recent (cwd)" },
      {
        '<leader>fL',
        function() require('telescope.builtin').old_files({ root = false }) end,
        desc = 'telescope: Recent files (cwd)'
      },


      -- grep
      {
        '<leader>F',
        function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }) end,
        desc = "telescope: Find word"
      },
      -- { "<leader>sg", LazyVim.pick("live_grep"),                                        desc = "Grep (Root Dir)" },
      -- { "<leader>/",       LazyVim.pick("live_grep"),            desc = "Grep (Root Dir)" },
      { '<leader>sg', "<cmd>Telescope live_grep<cr>",                                          desc = "telescope: Live grep (rood dir)" },
      { '<leader>/',  "<cmd>Telescope live_grep<cr>",                                          desc = "telescope: Live grep (rood dir)" },
      -- { "<leader>sG", LazyVim.pick("live_grep", { root = false }),                      desc = "Grep (cwd)" },
      { '<leader>sG', function() require('telescope.builtin').live_grep({ root = false }) end, desc = 'telescope: Live grep (cwd)' },
      -- { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }),               desc = "Word (Root Dir)" },
      {
        '<leader>sw',
        function() require('telescope.builtin').grep_string({ word_match = "-w" }) end,
        desc = 'telescope: Find word under cursor (root dir)'
      },
      -- { "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
      {
        '<leader>sW',
        function() require('telescope.builtin').grep_string({ root = false, word_match = "-w" }) end,
        desc = 'telescope: Find word under cursor (cwd)'
      },
      -- { "<leader>sw", LazyVim.pick("grep_string"),                                      mode = "v",                       desc = "Selection (Root Dir)" },
      {
        '<leader>sw',
        function() require('telescope.builtin').grep_string() end,
        mode = "v",
        desc = 'telescope: Find selected text (root dir)'
      },
      -- { "<leader>sW", LazyVim.pick("grep_string", { root = false }),                    mode = "v",                       desc = "Selection (cwd)" },
      {
        '<leader>sW',
        function() require('telescope.builtin').grep_string({ root = false }) end,
        mode = "v",
        desc = 'telescope: Find selected text (root dir)'
      },

      -- search
      -- { "<leader>:",  "<cmd>Telescope command_history<cr>",    desc = "Command History" },
      {
        '<leader>sh',
        function()
          vim.o.shellslash = false -- workaround on windows
          require('telescope.builtin').help_tags()
          vim.o.shellslash = true
        end,
        desc = "telescope: List help tags"
      },
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "telescope: Switch buffer",
      },
      {
        "<leader>fb",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
        desc = "telescope: Switch buffer (ignore current)",
      },

      -- git
      { "<leader>rc", "<cmd>Telescope git_commits<CR>",                           desc = "telescope: Git commits" },
      { "<leader>rs", "<cmd>Telescope git_status<CR>",                            desc = "telescope: Git status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>",                             desc = "telescope: Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>",                          desc = "telescope: Auto commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>",             desc = "telescope: Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>",                       desc = "telescope: Command history" },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                              desc = "telescope: Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>",                   desc = "telescope: Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>",                           desc = "telescope: Workspace diagnostics" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>",                            desc = "telescope: Search highlight groups" },
      { "<leader>sj", "<cmd>Telescope jumplist<cr>",                              desc = "telescope: Jumplist" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                               desc = "telescope: Key maps" },
      { "<leader>sl", "<cmd>Telescope loclist<cr>",                               desc = "Location list" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                             desc = "Man pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                                 desc = "Jump to mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",                           desc = "Options" },
      -- { "<leader>sR", "<cmd>Telescope resume<cr>",                     desc = "Resume" },
      { '<leader>ss', require('telescope.builtin').resume,                        desc = 'telescope: last picker' },
      { "<leader>sq", "<cmd>Telescope quickfix<cr>",                              desc = "telescope: Quickfix list" },

      -- { "<leader>uC", LazyVim.pick("colorscheme", { enable_preview = true }),           desc = "Colorscheme with Preview" },
      { "<leader>uC", require('telescope.builtin').colorscheme,                   desc = "Colorscheme with Preview" },

      { '<leader>cy', require('telescope.builtin').lsp_type_definitions,          desc = 'telescope (lsp): Go to type definition or list' },
      { '<leader>cs', require('telescope.builtin').lsp_document_symbols,          desc = 'telescope (lsp): Show symbols in current file' },
      { '<leader>cS', require('telescope.builtin').lsp_dynamic_workspace_symbols, desc = 'telescope (lsp): Find workspace symbols' },
      { '<leader>cr', require('telescope.builtin').lsp_references,                desc = 'telescope (lsp): List symbol references' },
      { '<leader>cd', require('telescope.builtin').diagnostics,                   desc = 'telescope: Show diagnostics' },
      -- {
      --   "<leader>ss",
      --   function()
      --     require("telescope.builtin").lsp_document_symbols({
      --       symbols = LazyVim.config.get_kind_filter(),
      --     })
      --   end,
      --   desc = "Goto Symbol",
      -- },
      -- {
      --   "<leader>sS",
      --   function()
      --     require("telescope.builtin").lsp_dynamic_workspace_symbols({
      --       symbols = LazyVim.config.get_kind_filter(),
      --     })
      --   end,
      --   desc = "Goto Symbol (Workspace)",
      -- },

    },
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
}
