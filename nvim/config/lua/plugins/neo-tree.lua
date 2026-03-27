return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		{ "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Neo-tree" },
	},
	opts = {
		window = {
			width = 35,
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
			},
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = true,
			},
		},
		event_handlers = {
			{
				event = "file_open_requested",
				handler = function()
					vim.cmd("Neotree close")
				end,
			},
		},
	},
}
