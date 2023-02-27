local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.set_preferences({
	-- suggest_lsp_servers = true,
	-- setup_servers_on_start = true,
	-- set_lsp_keymaps = true,
	-- configure_diagnostics = true,
	-- cmp_capabilities = true,
	-- manage_nvim_cmp = true,
	-- call_servers = "local",
	sign_icons = {
		-- error = "x",
		warn = "!",
		-- hint = "?",
		-- info = "i",
	},
})

lsp.nvim_workspace({
	library = vim.api.nvim_get_runtime_file("", true),
})

lsp.ensure_installed({
	"astro",
	"cssls",
	-- "denols",
	"dockerls",
	-- "eslint",
  "eslintd",
	"gopls",
	"graphql",
	"html",
  "prettierd",
	"rust_analyzer",
	"lua_ls",
	"svelte",
	"vimls",
	"volar",
	"tsserver",
})

