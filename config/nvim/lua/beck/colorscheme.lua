-- Set colorscheme (module)
-- local selected_colorscheme = "catppuccin-frappe"
-- local selected_colorscheme = "catppuccin-macchiato"
-- local selected_colorscheme = "catppuccin-mocha"
-- local selected_colorscheme = "gruvbox"
-- local selected_colorscheme = "night-owl"
-- local selected_colorscheme = "onedark"
-- local selected_colorscheme = "onedark_dark"
-- local selected_colorscheme = "onedark_vivid"
-- local selected_colorscheme = "poimandres"
-- local selected_colorscheme = "rose-pine"
local selected_colorscheme = "tokyonight"
-- local selected_colorscheme = "vscode"

local MAX_PRIORITY = 1000
local MIN_PRIORITY = 999

---@type fun(colorscheme: string): number
local function get_colorscheme_priority(colorscheme)
	if colorscheme == selected_colorscheme then
		return MAX_PRIORITY
	else
		return MIN_PRIORITY
	end
end

---@type fun(colorscheme: string): boolean
local function get_colorscheme_lazy(colorscheme)
	return colorscheme == selected_colorscheme
end

---@class ColorschemeCommands
---@field get_priority fun(args: string | table<string>): number
---@field get_lazy fun(args: string | table<string>): boolean
---@field get_current fun(): string
local M = {}
M._start = 0

function M.get_priority(args)
	if type(args) == "string" then
		return get_colorscheme_priority(args)
	end

	for _, colorscheme in ipairs(args) do
		if selected_colorscheme == colorscheme then
			return MAX_PRIORITY
		end
	end

	return MIN_PRIORITY
end

function M.get_lazy(args)
	if type(args) == "string" then
		return get_colorscheme_lazy(args)
	end

	for _, colorscheme in ipairs(args) do
		local lazy = get_colorscheme_lazy(colorscheme)
		if not lazy then
			return false
		end
	end

	return true
end

function M.apply()
	vim.cmd("colorscheme " .. selected_colorscheme)
end

function M.get_current()
	return selected_colorscheme
end

return M
