require("options")
require("keymaps")
require("autocmds")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local profile = os.getenv("MAC_PROFILE") or "personal"
local specs = { { import = "plugins.base" } }
local profile_plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins/" .. profile
local has_lua = vim.fn.globpath(profile_plugins_dir, "*.lua") ~= ""
if has_lua then
	table.insert(specs, { import = "plugins." .. profile })
end

require("lazy").setup(specs, {
	change_detection = { notify = false },
})
