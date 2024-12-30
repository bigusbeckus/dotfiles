return {
	"tpope/vim-fugitive", -- Awesome git UI
	event = "VeryLazy",
	config = function()
		-- Robbed in broad daylight from ThePrimeagen
		-- https://github.com/ThePrimeagen/init.lua/blob/e148c2cdfd54d6194ce57c856d1000d8c8111d4f/lua/theprimeagen/lazy/fugitive.lua
		local CustomFugitive = vim.api.nvim_create_augroup("CustomFugitive", {})

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			group = CustomFugitive,
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "<leader>p", function()
					vim.cmd.Git("push")
				end, opts)

				vim.keymap.set("n", "<leader>P", function()
					vim.cmd.Git("pull") -- No rebase for me though :P
				end, opts)

				-- NOTE: It allows me to easily set the branch i am pushing and any tracking
				-- needed if i did not set the branch up correctly
				vim.keymap.set("n", "<leader>o", ":Git push -u origin ", opts)
			end,
		})
	end,
}
