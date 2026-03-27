return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					markdown = { "prettier" },
					go = { "gofumpt" },
					sh = { "shfmt" },
					bash = { "shfmt" },
				},
				format_on_save = {
					timeout_ms = 2000,
					lsp_fallback = true,
				},
			})
		end,
	},
}
