local builtin = require("telescope.builtin")
local themes = require("telescope.themes")

-- Old keymaps
-- vim.keymap.set("n", "<C-p>", function()
-- 	builtin.find_files({
-- 		hidden = true,
-- 	})
-- end, { noremap = true })
--
-- vim.keymap.set("n", "<leader>pf", builtin.live_grep, { noremap = true })
-- vim.keymap.set("n", "<leader>pg", builtin.git_files, { noremap = true })

-- vim.keymap.set("n", "<leader>pf", builtin.grep_string, { noremap = true })
-- vim.keymap.set("n", "<leader>ps", function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)

-- New keymaps
vim.keymap.set("n", "<leader>sf", function()
	builtin.find_files({
		hidden = true,
	})
end, { noremap = true, desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { noremap = true, desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { noremap = true, desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { noremap = true, desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { noremap = true, desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.oldfiles, { noremap = true, desc = "[S]earch [R]ecent files" })
vim.keymap.set("n", "<leader>st", builtin.treesitter, { noremap = true, desc = "[S]earch [T]reesitter" })

vim.keymap.set("n", "<leader><space>", builtin.buffers, { noremap = true })
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	builtin.current_buffer_fuzzy_find(themes.get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { noremap = true, desc = "[/] Fuzzily search in current buffer]" })
