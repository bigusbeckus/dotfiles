local mason_nvim_dap = require("mason-nvim-dap")

-- Ensure debug adapters are installed and auto setup nvim-dap
mason_nvim_dap.setup({
	ensure_installed = {
		"bash",
    "codelldb",
		"chrome",
		"dart",
		"firefox",
		"kotlin",
		"node2",
	},
	automatic_setup = true,
})
mason_nvim_dap.setup_handlers()

-- Setup DAP UI
local dap_ui = require("dapui")
dap_ui.setup()

local dap = require("dap")

-- Configure DAP keymaps
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

vim.keymap.set("n", "<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

vim.keymap.set("n", "<leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)

vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>dx", dap.repl.close)
vim.keymap.set("n", "<leader>dl", dap.run_last)

vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>dsx", dap.step_out)

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)

vim.keymap.set("n", "<leader>dui", dap_ui.toggle)
