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
				"marksman",
				"rust_analyzer",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim", "saghen/blink.cmp" },
		config = function()
			-- Capabilities do blink.cmp pra completação via LSP
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})

			-- Diagnósticos
			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = { current_line = true },
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

			-- Keymaps no attach (vim.schedule garante que sobrescreve os defaults do nvim 0.11)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					vim.schedule(function()
						local opts = { buffer = ev.buf, silent = true }
						local map = vim.keymap.set

						map("n", "K", vim.lsp.buf.hover, opts)
						map("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end, opts)
						map("n", "gr", "<cmd>Telescope lsp_references<cr>", vim.tbl_extend("force", opts, { nowait = true }))
						map("n", "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end, opts)
						map("n", "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end, opts)
						map("n", "<leader>gD", vim.lsp.buf.declaration, opts)
						map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
						map("n", "<leader>rn", vim.lsp.buf.rename, opts)
						map("n", "<leader>fr", vim.lsp.buf.references, opts)

						-- Document highlight: ilumina ocorrências da variável sob o cursor
						local client = vim.lsp.get_client_by_id(ev.data.client_id)
						if client and client.supports_method("textDocument/documentHighlight") then
							local hl_group = vim.api.nvim_create_augroup("lsp_doc_highlight_" .. ev.buf, { clear = true })
							vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
								buffer = ev.buf,
								group = hl_group,
								callback = vim.lsp.buf.document_highlight,
							})
							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = ev.buf,
								group = hl_group,
								callback = vim.lsp.buf.clear_references,
							})
						end
					end)
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
			vim.lsp.config("marksman", {})
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						check = { command = "clippy" },
						cargo = { allFeatures = true },
					},
				},
			})

			vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "gopls", "bashls", "marksman", "rust_analyzer" })
		end,
	},
}
