-- Termcode escape function
-- local function t(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- "greatest remap ever" - ThePrimeagen
vim.keymap.set("x", "<leader>p", '"_dP') -- Replace without replacing buffer contents

-- "next greatest remap ever : asbjornHaland" - ThePrimeagen
-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y"')
vim.keymap.set("v", "<leader>y", '"+y"<Esc>')
vim.keymap.set("n", "<leader>Y", '"+Y"')

-- Delete without replacing buffer contents
vim.keymap.set("n", "<leader>d", '"_d"')
vim.keymap.set("v", "<leader>d", '"_d"<Esc>')

-- Formatter
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({
		formatting_options = {
			-- trimTrailingWhitespace = true,
			-- trimFinalNewLines = true,
			-- insertFinalNewline = true,
			insert_final_newline = true,
		},
		timeout_ms = 2500,
		-- async = true,
	})
end)

-- Unbound netrw rebind because vim-vinegar is better
-- Netrw rebind
-- vim.keymap.set("n", "<leader>pe", vim.cmd.Ex)

-- Unbound because autocmd version is better
-- vim.cmd("cabb help vert help")
-- vim.cmd("cabb h vert h")
