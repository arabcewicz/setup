return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			default_format_opts = {
				timeout_ms = 13000,
				async = false,
				quiet = false,
				lsp_format = "fallback",
			},
			format_on_save = { timeout_ms = 3000 },
		},
		-- init = function()
		--   -- If you want the formatexpr, here is the place to set it
		--   vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		-- end,
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format()
				end,
				desc = "conform: Format buffer",
			},
		},
	},
}
