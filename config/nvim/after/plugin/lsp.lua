function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

function dumpJson(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. k .. ": " .. dumpJson(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

local disable_lsp_syntax_highlight = true
require("neodev").setup({})
local mason_registry = require("mason-registry")

local preferred_prettier = "prettierd"
-- local preferred_prettier = "prettier"
local preferred_eslint = "eslint_d"
-- local preferred_eslint = "eslint"

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
	"clangd",
	"cssls",
	"denols",
	"dockerls",
	"gopls",
	"gradle_ls",
	"graphql",
	"html",
	"intelephense",
	"jsonls",
	"kotlin_language_server",
	"lua_ls",
	"prismals",
	"rust_analyzer",
	"lua_ls",
	"sqlls",
	"svelte",
	"tailwindcss",
	"taplo",
	"templ",
	"terraformls",
	"tsserver",
	"tflint",
	"vimls",
	"volar",
	"yamlls",
})

-- Ensure eslint and prettier are installed
-- if not mason_registry.is_installed(preferred_eslint) then
-- 	mason_registry.get_package(preferred_eslint):install({ version = "latest" })
-- end
if not mason_registry.is_installed(preferred_prettier) then
	mason_registry.get_package(preferred_prettier):install({ version = "latest" })
end

-- Custom LSP configs
local root_pattern = require("lspconfig").util.root_pattern

-- Setup eslint root pattern
-- lsp.use({ preferred_eslint }, {
-- 	root_dir = root_pattern(
-- 		".eslintrc",
-- 		".eslintrc.js",
-- 		".eslintrc.json",
-- 		".eslintrc.cjs",
-- 		".eslintrc.yml",
-- 		".eslintrc.yaml"
-- 	),
-- })

lsp.configure("terraformls", {
	filetypes = { "tf", "terraform", "terraform-vars", "hcl" },
})

lsp.configure("graphql", {
	filetypes = { "graphql", "gql" },
})

-- lsp.configure("terraform_lsp", {
-- 	cmd = { "terraform-lsp" },
-- 	filetypes = { "tf", "terraform", "hcl", "tfstate" },
-- 	root_dir = root_pattern(".terraform", ".git"),
-- })

-- Setup json and yaml schema stores
local schemastore = require("schemastore")
lsp.configure("jsonls", {
	filetypes = { "sqq", "json", "jsonc", "tfstate" },
	settings = {
		json = {
			schemas = schemastore.json.schemas(),
			validate = { enable = true },
		},
	},
})

lsp.configure("yamlls", {
	filetypes = { "yaml", "yml" },
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = schemastore.yaml.schemas({
				extra = {
					{
						description = "Kubernetes Deployment",
						name = "kubernetes-deployment",
						url = "https://kubernetesjsonschema.dev/v1.14.0/deployment-apps-v1.json",
						fileMatch = {
							"*deployment.yml",
							"*deployment.yaml",
						},
					},
					{
						description = "Kubernetes Service",
						name = "kubernetes-service",
						url = "https://kubernetesjsonschema.dev/v1.10.3-standalone/service-v1.json",
						fileMatch = {
							"*service.yml",
							"*service.yaml",
						},
					},
					{
						description = "Code Rabbit Configuration",
						name = "coderabbit-config",
						url = "https://coderabbit.ai/integrations/coderabbit-overrides.v2.json",
						fileMatch = {
							".coderabbit.yml",
							".coderabbit.yaml",
						},
					},
				},
			}),
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

-- Recognize known json files with non json extensions
vim.cmd([[
augroup jsondetect
    autocmd BufNewFile,BufRead *.tfstate setlocal filetype=json
augroup end
]])

-- Set deno-ls root pattern to fix conflicts with tsserver
lsp.configure("denols", {
	root_dir = root_pattern("deno.json", "deno.jsonc"),
})

lsp.configure("clangd", {
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
})

-- Setup lua language server
-- lsp.configure("lua_ls", {
-- 	settings = {
-- 		Lua = {
-- 			completion = {
-- 				callSnippet = "Replace",
-- 			},
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

-- Conditioanlly setup dart for flutter development
if vim.fn.executable("dart") == 1 then
	lsp.configure("dartls")
end

-- Setup volar for the umpteenth time :|
lsp.configure("volar")

-- Language server for qmljs files (kde config)
lsp.configure("qml_lsp")

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
	-- Disable LSP syntax highlighting (we're using treesitter instead)
	if disable_lsp_syntax_highlight then
		client.server_capabilities.semanticTokensProvider = nil
	end

	-- Setup LSP specific keybinds
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
	-- vim.keymap.set(
	--   "i",
	--   "<C-h>",
	--   vim.lsp.buf.signature_help,
	--   { buffer = bufnr, remap = false, desc = "Signature [H]elp (Insert mode)" }
	-- )
	-- vim.keymap.set(
	-- 	"n",
	-- 	"<C-k>",
	-- 	vim.lsp.buf.signature_help,
	-- 	{ buffer = bufnr, remap = false, desc = "[<C-k>] Signature help (Normal mode)" }
	-- )

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
		vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
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

-- Process typescript errors with pretty-ts-errors
-- vim.api.nvim_create_autocmd("LspRequest", {
-- 	callback = function(args)
-- 		-- local client_id = args.data.client_id
-- 		-- local client = vim.lsp.get_client_by_id(client_id)
-- 		-- if not (client.name == "tsserver" or client.name == "denols") then
-- 		--     print(client.name)
-- 		-- 	return
-- 		-- end
--
-- 		-- print("typescript woooo")
-- 		local bufnr = args.buf
-- 		local request = args.data.request
-- 		if request.type == "complete" then
-- 			local data = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
--       print("\n\n")
-- 			print("requestcomplete")
--       print("\n")
-- 			print(dumpJson(args))
--       print("\n\n")
-- 		end
-- 	end,
-- })

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
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

function initPrettyTSErrors()
	local namespace = vim.api.nvim_create_namespace("pretty-ts-errors")
	vim.api.nvim_create_autocmd("DiagnosticChanged", {
		callback = function(args)
			local diagnostics = args.data.diagnostics
			for key, diagnostic in pairs(diagnostics) do
				if diagnostic.source == "typescript" then
					local message = "Did you mean `foo`?"

					if diagnostic.namespace == namespace then
						if diagnostic.message == "" then
							vim.diagnostic.reset(namespace, diagnostic.bufnr)
						end
						if diagnostic.message == message then
							return
						end
					end

					diagnostic.message = message
					-- vim.diagnostic.reset(diagnostic.namespace, diagnostic.bufnr)
					vim.diagnostic.set(namespace, diagnostic.bufnr, { diagnostic }, {})
				end
			end
			-- local client = vim.lsp.get_client_by_id(args.data.source)
			-- if not (client.name == "tsserver" or client.name == "denols") then
			-- 	print("not ts")
			-- 	return
			-- end
			-- print("ts :)")
			-- local diagnostic = args.data.diagnostic
		end,
	})
end

-- initPrettyTSErrors()

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
