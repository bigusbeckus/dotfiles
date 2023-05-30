-- Auto-install packages

--[[ local mason_registry = require("mason-registry")

local mason_packages = {
	"astro-language-server",
	"bash-debug-adapter",
	"bash-language-server",
	"buf",
	"cbfmt",
	"chrome-debug-adapter",
	"codelldb",
	"css-lsp",
	"dart-debug-adapter",
	"delve",
	"deno",
	"dockerfile-language-server",
	"editorconfig-checker",
	"eslint_d",
	"firefox-debug-adapter",
	"gopls",
	"gradle-language-server",
	"graphql-language-service-cli",
	"html-lsp",
  "intelephense",
	"json-lsp",
	"jsonlint",
	"kotlin-debug-adapter",
	"kotlin-language-server",
	"lua-language-server",
	"markdownlint",
  "misspell",
	"node-debug2-adapter",
	"omnisharp",
	"prettierd",
	"prisma-language-server",
	"protolint",
	"rust-analyzer",
	"shfmt",
	"sql-formatter",
	"sqlfluff",
	"sqlls",
	"stylua",
	"svelte-language-server",
	"tailwindcss-language-server",
	"taplo",
  "terraformls",
  "tflint",
  "tfsec",
	"typescript-language-server",
	"vim-language-server",
	"vue-language-server",
	"yaml-language-server",
	"yamlfmt",
	"yamllint",
}

for _, mason_package in pairs(mason_packages) do
	if not mason_registry.is_installed(mason_package) then
		mason_registry.get_package(mason_package):install({ version = "latest" })
	end
end ]]
