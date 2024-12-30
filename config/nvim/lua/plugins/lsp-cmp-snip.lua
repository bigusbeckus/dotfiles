return {
	-- LSP Support
	"neovim/nvim-lspconfig", -- Required

	-- Autocompletion
	"hrsh7th/nvim-cmp", -- Required (LSP completion plugin)
	"hrsh7th/cmp-nvim-lsp", -- Required (LSP completion source)

	-- Completion sources
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-path",
	-- "saadparwaiz1/cmp_luasnip",

	-- Snippets
	"L3MON4D3/LuaSnip", -- Required
	-- "rafamadriz/friendly-snippets",

	-- JSON schema store
	"b0o/schemastore.nvim",

	-- Refactoring
	"ThePrimeagen/refactoring.nvim",
}
