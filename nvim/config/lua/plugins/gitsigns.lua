return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
				},
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 500,
					virt_text_pos = "eol",
				},
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns
					local map = function(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end
					map("n", "]h", gs.next_hunk, "Next hunk")
					map("n", "[h", gs.prev_hunk, "Prev hunk")
					map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
					map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
					map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
					map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line (popup)")
					map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle inline blame")
				end,
			})
		end,
	},
}
