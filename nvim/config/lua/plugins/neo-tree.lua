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
				["Y"] = function(state)
					local node = state.tree:get_node()
					local path = node:get_id()
					vim.fn.setreg("+", path)
					vim.notify("Copied: " .. path)
				end,
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
	config = function(_, opts)
		require("neo-tree").setup(opts)

		-- Colore o NOME do arquivo/pasta por severidade de diagnóstico quando há
		-- erro/warn, senão mantém a cor de git status. O símbolo de git_status
		-- continua na coluna à direita, então o estado de git segue visível.
		-- Obs: o rust-analyzer só publica os erros do workspace após um save.
		local common = require("neo-tree.sources.common.components")
		local utils = require("neo-tree.utils")
		local orig_name = common.name
		local sev_hl = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }

		local function name_with_diag(config, node, state)
			local result = orig_name(config, node, state)
			-- Não colore a raiz: a severidade borbulha até ela e ficaria sempre marcada.
			if node:get_depth() == 1 then
				return result
			end
			local d = utils.index_by_path(state.diagnostics_lookup or {}, node:get_id())
			if d and d.severity_number and sev_hl[d.severity_number] then
				result.highlight = sev_hl[d.severity_number]
			end
			return result
		end

		for _, mod in ipairs({
			"neo-tree.sources.common.components",
			"neo-tree.sources.filesystem.components",
			"neo-tree.sources.buffers.components",
			"neo-tree.sources.git_status.components",
		}) do
			local ok, comp = pcall(require, mod)
			if ok then
				comp.name = name_with_diag
			end
		end
	end,
}
