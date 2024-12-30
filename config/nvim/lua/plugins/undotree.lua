return {
	"mbbill/undotree",
	lazy = true,
	config = function()
		vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
		vim.opt.undofile = true

		vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle)
	end,
}
