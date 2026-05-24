return {
	"saghen/blink.cmp",
	version = "*",
	event = "InsertEnter",
	opts = {
		keymap = {
			preset = "none",
			["<Tab>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<C-space>"] = { "show", "hide" },
			["<C-e>"] = { "hide", "fallback" },
		},
		sources = {
			default = { "lsp", "buffer", "path" },
		},
		completion = {
			documentation = { auto_show = true },
		},
	},
}
