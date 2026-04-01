return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"pyright",
				"ts_ls",
				"bashls",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			-- Diagnósticos
			vim.diagnostic.config({
				virtual_text = { prefix = "●", spacing = 4 },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = "",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					border = "rounded",
					source = true,
					focusable = false,
					style = "minimal",
				},
			})

			-- Keymaps no attach
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local opts = { buffer = ev.buf, silent = true }
					local map = vim.keymap.set

					map("n", "K", vim.lsp.buf.hover, opts)
					map("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, opts)
					map("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)
					map("n", "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, opts)
					map("n", "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, opts)
					map("n", "<leader>gD", vim.lsp.buf.declaration, opts)
					map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					map("n", "<leader>rn", vim.lsp.buf.rename, opts)
					map("n", "<leader>fr", vim.lsp.buf.references, opts)
				end,
			})

			-- Servidores (nova API nvim 0.11)
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						telemetry = { enable = false },
					},
				},
			})
			vim.lsp.config("pyright", {})
			vim.lsp.config("ts_ls", {})
			vim.lsp.config("gopls", {})
			vim.lsp.config("bashls", {})

			vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "gopls", "bashls" })
		end,
	},
}
