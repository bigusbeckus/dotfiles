return {
	"mistricky/codesnap.nvim",
	build = "make",
	keys = {
		{ "<leader>snc", "<cmd>CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
		{ "<leader>sns", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
	},
	opts = {
		save_path = "~/Pictures/nvim",
		has_breadcrumbs = true,
		bg_theme = "grape",
        bg_padding = 0,
        watermark = "",
	},
}
