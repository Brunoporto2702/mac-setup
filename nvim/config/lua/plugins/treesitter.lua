return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup({})

			local ensure_installed = {
				"bash",
				"c",
				"cpp",
				"css",
				"go",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"python",
				"typescript",
				"tsx",
				"vim",
				"vimdoc",
			}

			local config = require("nvim-treesitter.config")
			local installed = config.get_installed()
			local to_install = vim.tbl_filter(function(p)
				return not vim.tbl_contains(installed, p)
			end, ensure_installed)

			if #to_install > 0 then
				treesitter.install(to_install)
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local lang = vim.treesitter.language.get_lang(args.match)
					if lang and vim.tbl_contains(treesitter.get_installed(), lang) then
						vim.treesitter.start(args.buf)
					end
				end,
			})
		end,
	},
}
