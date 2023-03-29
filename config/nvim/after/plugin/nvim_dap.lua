local dap = require("dap")
local mason_nvim_dap = require("mason-nvim-dap")

mason_nvim_dap.setup({
	ensure_installed = {
		"bash",
		"chrome",
		"codelldb",
		"dart",
		"firefox",
		"kotlin",
		"node2",
	},
	automatic_setup = true,
})

-- Setup DAP handlers
-- dap.adapters["node-terminal"] = dap.adapters.node2
-- Source: https://github.com/mxsdev/nvim-dap-vscode-js
-- require("dap-vscode-js").setup({
-- 	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
-- })
require("dap-vscode-js").setup({})

-- Load debugee config from ".vscode/launch.json"
-- See ':help dap-configuration' for details
local dap_vscode_extension = require("dap.ext.vscode")
package.cpath = package.cpath .. ";./lua/?.so"
dap_vscode_extension.json_decode = require("json5").parse -- Supports trailing commas
dap_vscode_extension.load_launchjs(nil, {
	node = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	["node-terminal"] = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	["pwa-node"] = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	["pwa-chrome"] = { "javascript" },
	chrome = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
	-- node = { "node2" },
	-- ["node-terminal"] = { "node2" },
})

-- Setup DAP UI
local dap_ui = require("dapui")
dap_ui.setup()

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

-- Setup the fancy red breakpoint icon
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
