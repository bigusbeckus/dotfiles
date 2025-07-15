return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	opts = {
		variant = "moon",
		-- dark_variant = "moon",
		styles = {
            italic = false,
			transparency = true,
		},
	},
	init = function()
		vim.cmd([[ colorscheme rose-pine ]])
	end,
}
