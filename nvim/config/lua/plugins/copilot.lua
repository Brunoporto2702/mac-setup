return {
	"github/copilot.vim",
	init = function()
		-- liberar <Tab> pro menu do blink; copilot aceita no <S-Tab>
		vim.g.copilot_no_tab_map = true
	end,
	config = function()
		vim.keymap.set("i", "<S-Tab>", function()
			return vim.fn["copilot#Accept"]("")
		end, { expr = true, silent = true, replace_keycodes = false, desc = "Aceitar sugestão do Copilot" })
	end,
}
