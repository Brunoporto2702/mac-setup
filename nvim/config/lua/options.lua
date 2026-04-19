vim.opt.termguicolors = true

-- Transparência
local transparent_groups = {
	"Normal",
	"NormalNC",
	"EndOfBuffer",
	"NormalFloat",
	"FloatBorder",
	"SignColumn",
	"StatusLine",
	"StatusLineNC",
	"TabLine",
	"TabLineFill",
	"TabLineSel",
	"ColorColumn",
}
for _, g in ipairs(transparent_groups) do
	vim.api.nvim_set_hl(0, g, { bg = "none" })
end
vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.cmdheight = 1
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.fillchars = { eob = " " }

-- Indentação
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Busca
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Completion
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Performance
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300
vim.opt.updatetime = 500
vim.opt.timeoutlen = 0
vim.opt.ttimeoutlen = 0
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

-- Undo / backup / swap
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = undodir

-- Comportamento geral
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.autoread = true
vim.opt.autowrite = false
vim.opt.mouse = "a"
vim.opt.encoding = "utf-8"
vim.opt.modifiable = true
vim.opt.selection = "inclusive"
vim.opt.clipboard:append("unnamedplus")
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")

-- Folding (treesitter; fallback seguro se não disponível)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- Diff
vim.opt.diffopt:append("linematch:60")

-- Cursor
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
