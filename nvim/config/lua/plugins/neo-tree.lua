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
		{
			"<leader>e",
			function()
				local manager = require("neo-tree.sources.manager")
				local state = manager.get_state("filesystem")
				if state and state.winid and vim.api.nvim_win_is_valid(state.winid) then
					vim.cmd("Neotree close")
				else
					vim.cmd("Neotree reveal")
				end
			end,
			desc = "Toggle Neo-tree",
		},
	},
	opts = {
		window = {
			width = 35,
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["<space>"] = false,
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
