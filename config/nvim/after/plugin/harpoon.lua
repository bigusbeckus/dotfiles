--[[
-------------
-- v1 Config
-------------
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<leader>A", mark.rm_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- Reasonable bindings
vim.keymap.set("n", "<leader>h1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>h2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>h3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>h4", function() ui.nav_file(4) end)
vim.keymap.set("n", "<leader>h5", function() ui.nav_file(5) end)

-- Excessive bindings
vim.keymap.set("n", "<leader>h6", function() ui.nav_file(6) end)
vim.keymap.set("n", "<leader>h7", function() ui.nav_file(7) end)
vim.keymap.set("n", "<leader>h8", function() ui.nav_file(8) end)
vim.keymap.set("n", "<leader>h9", function() ui.nav_file(9) end)
vim.keymap.set("n", "<leader>h0", function() ui.nav_file(0) end)

-- vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end)
-- vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end)
-- vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end)
-- vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end)
]]

-------------
-- v2 Config
-------------
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

-- Home row bindings (test)
vim.keymap.set("n", "<C-j>", function()
  harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-k>", function()
  harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-l>", function()
  harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-;>", function()
  harpoon:list():select(4)
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
-- vim.keymap.set("n", "<leader>h0", function() harpoon:list():select(0) end)
