return {
	{
		"nvim-telescope/telescope.nvim", -- Telescope (Fuzzy finder)
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			-- Has to be in the config function vs a static table in opts
			-- because we need telescope loaded in before the
			-- `require("telescope.actions").close` line is resolved
			require("telescope").setup({
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
			})
			require("telescope").load_extension("fzf")

			-- Configure telescope (not in `after` because sometimes there's an annoying delay before the keybinds kick in)
			require("config.telescope")
		end,
	},
}