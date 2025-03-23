return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"json",
				"jsonc",
				"json5",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"jsonls",
				-- "prettier",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- make sure mason installs the server
			servers = {
				jsonls = {
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
						new_config.settings.json.schemas = new_config.settings.json.schemas or {}
						vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
					end,
					settings = {
						json = {
							format = {
								enable = true,
							},
							validate = { enable = true },
						},
					},
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { "jq" },
			},
		},
		formatters = {
			jq = {
				command = "jq",
				args = { "-M", "." },
				stdin = false,
			},
		},
	},
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false, -- last release is way too old
	},
	{
		"phelipetls/jsonpath.nvim",
		config = function(_, opts)
			-- show json path in the winbar
			-- if vim.fn.exists("+winbar") == 1 then
			--   vim.opt_local.winbar = "%{%v:lua.require'jsonpath'.get()%}"
			-- end

			-- send json path to clipboard
			-- vim.keymap.set("n", "y<C-p>", function()
			--   vim.fn.setreg("+", require("jsonpath").get())
			-- end, { desc = "copy json path", buffer = true })
		end,
	},
}
