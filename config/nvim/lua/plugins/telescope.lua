return {
	{
		"nvim-telescope/telescope.nvim", -- Telescope (Fuzzy finder)
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		opts = {
			defaults = {
				file_ignore_patterns = {
					"node%_modules/.*",
					"%.git/.*",
					"^dist/.*",
					"^.expo/.*",
					"^.next/.*",
					"^.nuxt/.*",
					"^.terraform/.*",
					"^.venv/.*",
					"^.venv...+/.*",
				},
				mappings = {
					i = {
						["<Esc>"] = require("telescope.actions").close,
					},
				},
			},
			pickers = {
				layout_strategy = "vertical",
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")

			-- Configure telescope (not in `after` because sometimes there's an annoying delay before the keybinds kick in)
			require("config.telescope")
		end,
	},
}
