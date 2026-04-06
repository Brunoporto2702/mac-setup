vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Movimento em texto quebrado
map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true })
map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true })

-- Salvar
map({ "n", "i", "v" }, "<C-s>", "<Esc>:w<CR>", { desc = "Salvar arquivo" })

-- Busca
map("n", "<leader>c", ":nohlsearch<CR>", { desc = "Limpar highlight de busca" })
map("n", "n", "nzzzv", { desc = "Próximo resultado (centralizado)" })
map("n", "N", "Nzzzv", { desc = "Resultado anterior (centralizado)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Meia página abaixo (centralizado)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Meia página acima (centralizado)" })

-- Paste / delete sem yank
map("x", "<leader>p", '"_dP', { desc = "Colar sem sobrescrever registro" })
map({ "n", "v" }, "<leader>x", '"_d', { desc = "Deletar sem yank" })

-- Buffers
map("n", "<leader>bn", ":bnext<CR>", { desc = "Próximo buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Buffer anterior" })

-- Navegação entre janelas
map("n", "<C-h>", "<C-w>h", { desc = "Janela esquerda" })
map("n", "<C-j>", "<C-w>j", { desc = "Janela abaixo" })
map("n", "<C-k>", "<C-w>k", { desc = "Janela acima" })
map("n", "<C-l>", "<C-w>l", { desc = "Janela direita" })

-- Splits
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", ":split<CR>", { desc = "Split horizontal" })
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Aumentar altura" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Diminuir altura" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Diminuir largura" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Aumentar largura" })

-- Mover linhas
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Mover linha abaixo" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Mover linha acima" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Mover seleção abaixo" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Mover seleção acima" })

-- Indentação mantendo seleção
map("v", "<", "<gv", { desc = "Indentar esquerda" })
map("v", ">", ">gv", { desc = "Indentar direita" })

-- Join sem mover cursor
map("n", "J", "mzJ`z", { desc = "Join linha" })

-- Copiar caminho do arquivo
map("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copiar caminho completo" })

-- Toggle diagnósticos
map("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnósticos" })

-- Diagnósticos
map("n", "<leader>D", function()
	vim.diagnostic.open_float({ scope = "line" })
end, { desc = "Diagnóstico da linha" })
map("n", "<leader>d", function()
	vim.diagnostic.open_float({ scope = "cursor" })
end, { desc = "Diagnóstico do cursor" })
map("n", "<leader>nd", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Próximo diagnóstico" })
map("n", "<leader>pd", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Diagnóstico anterior" })
map("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Mostrar diagnóstico da linha" })
map("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Lista de diagnósticos" })
