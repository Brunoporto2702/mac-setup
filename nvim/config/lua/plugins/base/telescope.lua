return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep string under cursor" },
			{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
		},
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "TelescopeResults", "TelescopePreviewNormal" },
				callback = function(ctx)
					vim.opt_local.scrolloff = 0
				end,
			})

			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					path_display = { "truncate" },
					file_ignore_patterns = { "node_modules", ".git/" },
				},
			})
			telescope.load_extension("fzf")
		end,
	},
}
