return {
  "scalameta/nvim-metals",
  config = function()
    local metals_config = require("metals").bare_config()
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      superMethodLensesEnabled = true,
      showImplicitConversionsAndClasses = true
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to true, however if you do,
    -- you *have* to have a setting to display this in your statusline or else
    -- you'll not see any messages from metals. There is more info in the help
    -- docs about this
    metals_config.init_options.statusBarProvider = "on"

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    metals_config.tvp = {
      panel_width = 50,
      panel_alignment = "right",
      toggle_node_mapping = "l",
      node_command_mapping = "o",
      collapsed_sign = "▸",
      expanded_sign = "▾",
      icons = {
        enabled = true,
        symbols = {
          object = "",
          trait = "",
          class = "ﭰ",
          interface = "",
          val = "",
          var = "",
          method = "ﬦ",
          enum = "",
          field = "",
          package = "",
        },
      },
    }

    -- local navic = require("nvim-navic")
    metals_config.on_attach = function(client, bufnr)
      require("metals").setup_dap()
      --[[ if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end ]]
    end

    -- Autocmd that will actually be in charging of starting the whole thing
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      -- NOTE: You may or may not want java included here. You will need it if you
      -- want basic Java support but it may also conflict if you are using
      -- something like nvim-jdtls which also works on a java filetype autocmd.
      pattern = { "scala", "sbt" },
      -- pattern = { "scala", "sbt", "java" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = 'menuone,noinsert'

    require('legendary').keymaps({
      {
        '<leader>ss',
        ":Telescope metals commands<CR>",
        description = "metals: Show commands in telescope picker"
      },
      {
        '<leader>sl',
        ":MetalsToggleLogs<CR>",
        description = "metals: Toggle logs"
      },
      {
        '<leader>gu',
        ":MetalsGotoSuperMethod<CR>",
        description = "metals: Go to super method"
      },
      {
        '<leader>sf',
        ":MetalsCompileClean<CR>",
        description = "metals: Clean & compile"
      },
      {
        '<leader>sc',
        ":MetalsCompileCascade<CR>",
        description = "metals: Compile cascade"
      },
      {
        '<leader>sa',
        function() require("metals.tvp").reveal_in_tree() end,
        description = "metals: Show in tree view"
      },
      {
        '<leader>se',
        function() require("metals.tvp").toggle_tree_view() end,
        description = "metals: Toggle tree view"
      },
      {
        '<leader>si',
        function() require("metals").toggle_settings("showImplicitArguments") end,
        description = "metals: Toggle 'show implicit arguments'"
      },
      {
        'K',
        function() require("metals").type_of_range() end,
        mode = { 'v' },
        description = "metals: Type of selected code"
      },
    })
  end
}
