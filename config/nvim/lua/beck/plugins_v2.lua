---@class ColorschemeCommands
local colorscheme = require("beck.colorscheme")

require("lazy").setup({
	-- Colorschemes
	{
		"folke/tokyonight.nvim",
		lazy = colorscheme.get_lazy("tokyonight"),
		priority = colorscheme.get_priority("tokyonight"),
		config = {
			transparent = true,
			style = "night",
			styles = {
				-- sidebars = "transparent",
				-- floats = "transparent",
			},
			sidebars = { "qf", "help", "terminal", "packer" },
		},
	},
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	lazy = colorscheme.get_lazy("gruvbox"),
	-- 	priority = colorscheme.get_priority("gruvbox"),
	-- 	config = {
	-- 		transparent_mode = true,
	-- 	},
	-- },
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	lazy = colorscheme.get_lazy("rose-pine"),
	-- 	priority = colorscheme.get_priority("rose-pine"),
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			variant = "moon",
	--        -- dark_variant = "moon",
	-- 			styles = {
	-- 				transparency = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"olimorris/onedarkpro.nvim",
	-- 	lazy = colorscheme.get_lazy({
	-- 		"onedark",
	-- 		"onedark_dark",
	-- 		"onedark_vivid",
	-- 	}),
	-- 	priority = colorscheme.get_priority({
	-- 		"onedark",
	-- 		"onedark_dark",
	-- 		"onedark_vivid",
	-- 	}),
	-- 	config = {
	-- 		options = {
	-- 			transparency = true,
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"oxfist/night-owl.nvim",
	-- 	lazy = colorscheme.get_lazy("night-owl"),
	-- 	priority = colorscheme.get_priority("night-owl"),
	-- 	config = function()
	-- 		require("night-owl").setup({
	-- 			transparent_background = true,
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	lazy = colorscheme.get_lazy({
	-- 		"catppuccin",
	-- 		"catppuccin-frappe",
	-- 		"catppuccin-macchiato",
	-- 		"catppuccin-mocha",
	-- 	}),
	-- 	priority = colorscheme.get_priority({
	-- 		"catppuccin",
	-- 		"catppuccin-frappe",
	-- 		"catppuccin-macchiato",
	-- 		"catppuccin-mocha",
	-- 	}),
	-- 	config = {
	-- 		transparent_background = true,
	-- 	},
	-- },
	-- -- {
	-- 	"olivercederborg/poimandres.nvim",
	-- 	lazy = colorscheme.get_lazy("poimandres"),
	-- 	priority = colorscheme.get_priority("poimandres"),
	-- 	config = {
	-- 		-- disable_background = true,
	-- 		-- dim_nc_background = true, -- dim the 'non-current' window's background
	-- 		dark_variant = true,
	-- 		bold_vert_spilt = false,
	-- 		disable_italics = false,
	-- 	},
	-- },
	-- {
	-- 	"Mofiqul/vscode.nvim", -- VSCode theme (boooo, hissss...)
	-- 	lazy = colorscheme.get_lazy("vscode"),
	-- 	priority = colorscheme.get_priority("vscode"),
	-- 	config = {
	-- 		transparent = true,
	-- 		italic_comments = true,
	-- 	},
	-- },

	-- Plenary
	"nvim-lua/plenary.nvim",

	-- UI plugins:
	{
		"kyazdani42/nvim-web-devicons",
		-- config = {
		--   opt = true,
		-- },
	},

	{
		"nvim-lualine/lualine.nvim", -- Lualine
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = {
			options = {
				component_separators = "|",
				section_separators = "",
				icons_enabled = true,
				theme = "auto",
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim", -- Telescope (Fuzzy finder)
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node%_modules/.*",
						"%.git/.*",
						"^dist/.*",
						"^.expo/.*",
						"^.next/.*",
						"^.nuxt/.*",
						"^.terraform/.*",
						"^.venv/.*",
						"^.venv...+/.*",
					},
					mappings = {
						i = {
							["<Esc>"] = require("telescope.actions").close,
						},
					},
				},
				pickers = {
					layout_strategy = "vertical",
				},
			})
			require("telescope").load_extension("fzf")

			-- Configure telescope (not in `after` because sometimes there's an annoying delay before the keybinds kick in)
			require("beck.telescope")
		end,
	},

	"tpope/vim-fugitive", -- Awesome git UI

	{
		"lewis6991/gitsigns.nvim", -- Gitsigns: Inline git blame
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 150,
				},
			})
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	"github/copilot.vim", -- Github copilot

	"laytan/cloak.nvim", -- Cloak nvim

	"mbbill/undotree", -- Undotree

	"folke/zen-mode.nvim", -- Zen mode

	{
		"j-hui/fidget.nvim", -- Useful LSP status updates
		tag = "v1.2.0",
		config = {
			progress = {
				display = {
					done_ttl = 1,
				},
			},
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim", -- Markdown preview
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			vim.g.mkdp_echo_preview_url = 1
			vim.g.mkdp_theme = "dark"
		end,
	},

	-- Behavior
	"tpope/vim-vinegar", -- Rebinds that make sense
	"tpope/vim-surround", -- Bindings to modify characters surrounding text
	"tpope/vim-abolish", -- Case coersion and fixing words

	-- Neovim config helper
	"folke/neodev.nvim",

	-- Mason
	{
		"williamboman/mason.nvim",
		config = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("beck.treesitter")
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-context", dependencies = { "nvim-treesitter" } },
	-- Additional text objects via treesitter (this is actually kinda insane)
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter" } },
	{ "kiyoon/treesitter-indent-object.nvim", dependencies = { "nvim-treesitter" } },

	-- Autopairs and autotags
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	},

	-- Refactoring
	"ThePrimeagen/refactoring.nvim",

	-- Comment toggle plugins
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				padding = true,
				sticky = true,
				ignore = nil,
				toggler = { line = "<leader>cc", block = "<leader>cbc" },
				opleader = { line = "<leader>c", block = "<leader>cb" },
				extra = { above = "<leader>cO", below = "<leader>co", eol = "<leader>cA" },
				mappings = { basic = true, extra = true },
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				post_hook = nil,
			})
		end,
	},

	-- Treesitter (language specific)
	{
		"vrischmann/tree-sitter-templ",
		config = function()
			require("tree-sitter-templ").setup({})
		end,
	},

	-- LSP config
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		lazy = false,
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig", -- Required
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- JSON schema store
			"b0o/schemastore.nvim",

			-- Autocompletion
			"hrsh7th/nvim-cmp", -- Required
			"hrsh7th/cmp-nvim-lsp", -- Required
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- "saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",

			-- Snippets
			"L3MON4D3/LuaSnip", -- Required
			-- "rafamadriz/friendly-snippets",
		},
	},
	{
		"nvimtools/none-ls.nvim", -- none-ls, replacement to null-ls (Formatter/linter)
		commit = "2236d2b", -- Last commit where eslint_d and a bunch of other crap still works (TODO: Switch off none-ls)
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- Debugger (WIP)
	-- "mfussenegger/nvim-dap",
	-- "jayp0521/mason-nvim-dap.nvim",
	-- {
	--   "rcarriga/nvim-dap-ui",
	--   dependencies = { "mfussenegger/nvim-dap" },
	-- },
	-- Lua json5 parser (mainly for loading launch.json with trailing commas)
	-- {
	-- 	"Joakker/lua-json5",
	-- 	run = "./install.sh",
	-- },

	-- Unnecessary
	{ "eandrju/cellular-automaton.nvim", event = "VeryLazy" },
})
