if vim.g.selected_theme then
	local theme = require("plugins.colorscheme" .. "." .. vim.g.selected_theme)

    vim.cmd("syntax off")

    return theme
else
	return {}
end
