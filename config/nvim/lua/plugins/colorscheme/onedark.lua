return {
	"olimorris/onedarkpro.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		options = {
			transparency = true,
		},
	},
	init = function()
		vim.cmd([[ colorscheme onedark ]])
		-- vim.cmd([[ colorscheme onedark_dark ]])
		-- vim.cmd([[ colorscheme onedark_vivid ]])
	end,
}
