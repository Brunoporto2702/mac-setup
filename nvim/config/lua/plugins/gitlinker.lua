return {
	"ruifm/gitlinker.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>gy", mode = { "n", "v" }, desc = "Open line in GitHub" },
	},
	config = function()
		require("gitlinker").setup({
			action_callback = require("gitlinker.actions").open_in_browser,
		})
	end,
}
