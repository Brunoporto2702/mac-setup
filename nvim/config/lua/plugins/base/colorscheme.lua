-- Trocar aqui para mudar o tema padrão
-- built-in: "retrobox", "habamax", "desert", etc.
-- plugins:  "gruvbox", "jellybeans"
local active = "retrobox"

local plugin_themes = {
	gruvbox = {
		plugin = "ellisonleao/gruvbox.nvim",
		setup = function() require("gruvbox").setup({ contrast = "hard" }) end,
	},
	jellybeans = {
		plugin = "wtfox/jellybeans.nvim",
		setup = function() require("jellybeans").setup() end,
	},
}

-- temas built-in ativam direto (sem plugin)
if not plugin_themes[active] then
	vim.cmd.colorscheme(active)
end

local specs = {}
for name, def in pairs(plugin_themes) do
	local is_active = name == active
	table.insert(specs, {
		def.plugin,
		lazy = not is_active,
		priority = is_active and 1000 or nil,
		config = is_active and function()
			def.setup()
			vim.cmd.colorscheme(name)
		end or nil,
	})
end

return specs
