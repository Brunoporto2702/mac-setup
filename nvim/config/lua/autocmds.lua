local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Highlight no yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Restaurar posição do cursor ao reabrir arquivo
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restaurar última posição do cursor",
	callback = function()
		if vim.o.diff then
			return
		end
		local last_pos = vim.api.nvim_buf_get_mark(0, '"')
		local last_line = vim.api.nvim_buf_line_count(0)
		if last_pos[1] >= 1 and last_pos[1] <= last_line then
			pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
		end
	end,
})

-- Wrap + spell em markdown/text
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- Terminal: sem números nem signcolumn
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- Fechar buffer do terminal ao sair com status 0
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})
