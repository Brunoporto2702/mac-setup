return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		ft = { "markdown" },
		opts = {
			completions = { lsp = { enabled = true } },
			heading = {
				sign = false,
			},
			code = {
				sign = false,
				width = "block",
				right_pad = 1,
			},
			checkbox = {
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰄵 " },
			},
		},
	},
}
