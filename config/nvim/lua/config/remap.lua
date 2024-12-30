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
-- vim.keymap.set("n", "<leader>f", function()
-- 	vim.lsp.buf.format({
-- 		formatting_options = {
-- 			-- trimTrailingWhitespace = true,
-- 			-- trimFinalNewLines = true,
-- 			-- insertFinalNewline = true,
-- 			insert_final_newline = false,
-- 		},
-- 		timeout_ms = 2500,
-- 		-- async = true,
-- 	})
-- end)

-- Normal Ctrl+Backspace behavior in insert mode
vim.keymap.set("i", "<C-h>", '<Esc>vb"_da')
