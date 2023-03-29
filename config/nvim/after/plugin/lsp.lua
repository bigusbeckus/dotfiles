require("neodev").setup({})
local mason_registry = require("mason-registry")

local prefered_prettier = "prettierd"
-- local prefered_prettier = "prettier"
local prefered_eslint = "eslint_d"
-- local prefered_eslint = "eslint"

local lsp = require("lsp-zero").preset({
	name = "minimal",
	suggest_lsp_servers = true,
	setup_servers_on_start = true,
	set_lsp_keymaps = true,
	configure_diagnostics = true,
	cmp_capabilities = true,
	manage_nvim_cmp = true,
	call_servers = "local",
	-- Alternative sign icons A
	-- 	sign_icons = {
	-- 		error = "x",
	-- 		warn = "!",
	-- 		hint = "?",
	-- 		info = "i",
	-- 	},
	-- })

	-- Alternative sign icons B
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.nvim_workspace({
	library = vim.api.nvim_get_runtime_file("", true),
})

lsp.ensure_installed({
	"astro",
	"bashls",
	"cssls",
	"denols",
	"dockerls",
	"gopls",
	"gradle_ls",
	"graphql",
	"html",
	"jsonls",
	"kotlin_language_server",
	"prismals",
	"rust_analyzer",
	"lua_ls",
	-- "sqls",
	"sqlls",
	"svelte",
	"tailwindcss",
	"taplo",
	"tsserver",
	"vimls",
	"volar",
	"yamlls",
})

-- Ensure eslint and prettier are installed
if not mason_registry.is_installed(prefered_eslint) then
	mason_registry.get_package(prefered_eslint):install({ version = "latest" })
end
if not mason_registry.is_installed(prefered_prettier) then
	mason_registry.get_package(prefered_prettier):install({ version = "latest" })
end

-- Custom LSP configs
local root_pattern = require("lspconfig").util.root_pattern

-- Setup eslint root pattern
lsp.use({ prefered_eslint }, {
	root_dir = root_pattern(
		".eslintrc",
		".eslintrc.js",
		".eslintrc.json",
		".eslintrc.cjs",
		".eslintrc.yml",
		".eslintrc.yaml"
	),
})

-- Setup jsonls with common schemas
lsp.configure("jsonls", {
	filetypes = { "sqq", "json", "jsonc" },
	settings = {
		json = {
			-- Manually configure JSON schemas https://www.schemastore.org
			schemas = {
				{
					description = "Node package.json",
					fileMatch = { "package.json" },
					url = "https://json.schemastore.org/package.json",
				},
				{
					description = "Typescript compiler config",
					fileMatch = { "tsconfig.json", "tsconfig.*.json" },
					url = "https://json.schemastore.org/tsconfig.json",
				},
				{
					description = "Javascript config",
					fileMatch = { "jsconfig.json", "jsconfig.*.json" },
					url = "https://json.schemastore.org/jsconfig.json",
				},
				{
					description = "Prettier config",
					fileMatch = {
						".prettierrc",
						".prettierrc.json",
						"prettier.config.json",
					},
					url = "https://json.schemastore.org/prettierrc.json",
				},
				{
					description = "ESLint config",
					fileMatch = { ".eslintrc", ".eslintrc.json" },
					url = "https://json.schemastore.org/eslintrc.json",
				},
				{
					description = "Babel config",
					fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
					url = "https://json.schemastore.org/babelrc.json",
				},
				{
					description = "Lerna config",
					fileMatch = { "lerna.json" },
					url = "https://json.schemastore.org/lerna.json",
				},
				{
					description = "Vercel Now config",
					fileMatch = { "now.json", "vercel.json" },
					url = "https://json.schemastore.org/now.json",
				},
				{
					description = "Stylelint config",
					fileMatch = {
						".stylelintrc",
						".stylelintrc.json",
						"stylelint.config.json",
					},
					url = "https://json.schemastore.org/stylelintrc.json",
				},
				{
					description = "Turborepo config",
					fileMatch = { "turbo.json" },
					url = "https://turbo.build/schema.json",
				},
				{
					description = "Deno config",
					fileMatch = { "deno.json", "deno.jsonc" },
					url = "https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json",
				},
				{
					description = "Nodemon config",
					fileMatch = { "nodemon.json", "nodemon.jsonc" },
					url = "https://json.schemastore.org/nodemon.json",
				},
			},
		},
	},
})

-- Recognize json files known to actually be JSONC
vim.cmd([[
  augroup jsoncdetect
    autocmd!
    autocmd BufNewFile,BufRead .eslintrc.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead jsconfig.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead launch.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
  augroup end
]])

-- Set deno-ls root pattern to fix conflicts with tsserver
lsp.configure("denols", {
	root_dir = root_pattern("deno.json", "deno.jsonc"),
})

-- Setup lua language server
-- lsp.configure("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
-- 				version = "LuaJIT",
-- 			},
-- 			diagnostics = {
-- 				-- Get the language server to recognize the `vim` global
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				-- Make the server aware of Neovim runtime files
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 			},
-- 			-- Do not send telemetry data containing a randomized but unique identifier
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })

-- Setup tailwind language server root pattern
lsp.configure("tailwindcss", {
	root_dir = root_pattern("tailwind.config.*"),
})

if vim.fn.executable("dart") == 1 then
	lsp.configure("dartls")
end

-- nvim-cmp configuration
local cmp = require("cmp")
lsp.setup_nvim_cmp({
	-- preselect = "none",
	completion = {
		completeopt = "menu,menuone,noinsert,noselect",
	},
	mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		-- more sources
		{ name = "nvim-lua" },
	}),
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
lsp.on_attach(function(client, bufnr)
	-- local opts = { buffer = bufnr, remap = false }

	vim.keymap.set(
		"n",
		"<leader>e",
		vim.diagnostic.open_float,
		{ buffer = bufnr, remap = false, desc = "[E] Show diagnostic" }
	)
	vim.keymap.set(
		"n",
		"[d",
		vim.diagnostic.goto_prev,
		{ buffer = bufnr, remap = false, desc = "Go to previous [D]iagnostic" }
	)
	vim.keymap.set(
		"n",
		"]d",
		vim.diagnostic.goto_next,
		{ buffer = bufnr, remap = false, desc = "Go to next [D]iagnostic" }
	)
	-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = bufnr, remap = false, desc = "" })
	-- vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { buffer = bufnr, remap = false, desc = "" })

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, remap = false, desc = "[G]o to [D]efinition" })
	vim.keymap.set(
		"n",
		"gD",
		vim.lsp.buf.declaration,
		{ buffer = bufnr, remap = false, desc = "[G]o to [D]eclaration" }
	)
	vim.keymap.set(
		"n",
		"gi",
		vim.lsp.buf.implementation,
		{ buffer = bufnr, remap = false, desc = "[G]o to [I]mplementation" }
	)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = "[K] Hover" })
	vim.keymap.set(
		"n",
		"<leader>D",
		vim.lsp.buf.type_definition,
		{ buffer = bufnr, remap = false, desc = "Go to type [D]efinition" }
	)
	vim.keymap.set(
		"i",
		"<C-h>",
		vim.lsp.buf.signature_help,
		{ buffer = bufnr, remap = false, desc = "Signature [H]elp (Insert mode)" }
	)

	vim.keymap.set(
		"n",
		"<C-k>",
		vim.lsp.buf.signature_help,
		{ buffer = bufnr, remap = false, desc = "[<C-k>] Signature help (Normal mode)" }
	)
	vim.keymap.set(
		"n",
		"<leader>wa",
		vim.lsp.buf.add_workspace_folder,
		{ buffer = bufnr, remap = false, desc = "[W]orkspace folders: [A]dd" }
	)
	vim.keymap.set(
		"n",
		"<leader>wr",
		vim.lsp.buf.remove_workspace_folder,
		{ buffer = bufnr, remap = false, desc = "[W]orkspace folders: [R]emove" }
	)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, { buffer = bufnr, remap = false, desc = "[W]orkspace folders: [L]ist" })

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = "[R]e [N]ame" })
	vim.keymap.set(
		"n",
		"<leader>ga",
		vim.lsp.buf.code_action,
		{ buffer = bufnr, remap = false, desc = "[G]o to Code [A]ctions" }
	)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, remap = false, desc = "[G]o to [R]eferences" })

	-- tsserver - denols conflict resolution
	local active_clients = vim.lsp.get_active_clients()
	if client.name == "denols" then
		for _, client_ in pairs(active_clients) do
			-- Stop tsserver if denols is already active
			if client_.name == "tsserver" then
				client_.stop()
			end
		end
	elseif client.name == "tsserver" then
		for _, client_ in pairs(active_clients) do
			-- Prevent tsserver from running if denols is already active
			if client_.name == "denols" then
				client.stop()
			end
		end
	end
end)

-- Setup fidget.nvim - An LSP progress UI
require("fidget").setup({
	timer = {
		fidget_decay = 700,
		task_decay = 300,
	},
	window = {
		blend = 0,
	},
})

-- Setup lsp-zero
lsp.setup()

-- Diagnostics
vim.diagnostic.config({
	virtual_text = true,
	-- virtual_text = {
	-- 	source = "always",
	-- },
	signs = true,
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- lsp-zero default
-- {
--   virtual_text = false,
--   signs = true,
--   update_in_insert = false,
--   underline = true,
--   severity_sort = true,
--   float = {
--     focusable = false,
--     style = 'minimal',
--     border = 'rounded',
--     source = 'always',
--     header = '',
--     prefix = '',
--   },
-- }

-- vim default
-- {
-- 	virtual_text = true,
-- 	signs = true,
-- 	update_in_insert = false,
-- 	underline = true,
-- 	severity_sort = false,
-- 	float = true,
-- }
-- }
