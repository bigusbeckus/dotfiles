local harpoon = require("harpoon")

harpoon:setup({
	settings = {
		save_on_toggle = true,
		sync_on_ui_close = true,
	},
})

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<leader>A", function()
	harpoon:list():remove()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

-- Home row bindings
vim.keymap.set("n", "<C-j>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-l>", function()
	harpoon:list():select(3)
end)

-- Num row bindings
vim.keymap.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end)
vim.keymap.set("n", "<leader>h5", function()
	harpoon:list():select(5)
end)

-- Excessive num row bindings
vim.keymap.set("n", "<leader>h6", function()
	harpoon:list():select(6)
end)
vim.keymap.set("n", "<leader>h7", function()
	harpoon:list():select(7)
end)
vim.keymap.set("n", "<leader>h8", function()
	harpoon:list():select(8)
end)
vim.keymap.set("n", "<leader>h9", function()
	harpoon:list():select(9)
end)
