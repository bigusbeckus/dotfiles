return {
	"nvimdev/guard.nvim",
	dependencies = { "nvimdev/guard-collection" },
	dev = false,
	ft = {
		"lua",
		"c",
		"markdown",
		"json",
		"javascript,typescript,javascriptreact,typescriptreact",
	},
	config = function()
		vim.g.guard_config = {
			fmt_on_save = false,
			lsp_as_default_formatter = true,
			save_on_fmt = false,
			auto_lint = true,
			lint_interval = 500,
		}

		-- vim.keymap.set("n", "<leader>f", ":Guard fmt<CR>")

		local format = function()
			local bufnr = vim.api.nvim_get_current_buf()
			if bufnr == nil then
				return
			end

			require("guard.format").do_fmt(bufnr)
		end

		vim.keymap.set("n", "<leader>f", format, { desc = "[F]ormat document" })
		vim.keymap.set("v", "<leader>f", format, { desc = "[F]ormat selection" })
	end,
}
