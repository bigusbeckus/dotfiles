-- This file can be loaded by calling `lua require('plugins')` from your init.vim
return require("packer").startup(function(use)
	-- Load packer
	use("wbthomason/packer.nvim")

	-- Plenary
	use("nvim-lua/plenary.nvim")

	-- Neovim config helper
	use("folke/neodev.nvim")

	-- Useful LSP status updates
	-- Note: Pinned to the `legacy` tag for now. Update after it is rewritten.
	use({
		"j-hui/fidget.nvim",
		tag = "v1.2.0",
	})
	require("fidget").setup({
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
	})

	-- LSP config
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			"neovim/nvim-lspconfig", -- Required
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

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
	})

	-- Configure mason
	require("mason").setup({
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	-- Gruvbox neovim theme
	use({ "ellisonleao/gruvbox.nvim" })
	require("gruvbox").setup({
		transparent_mode = true,
	})

	--- Tokyo Night theme
	use("folke/tokyonight.nvim")
	require("tokyonight").setup({
		style = "night",
		-- style = "storm",
		transparent = true,
		styles = {
			-- sidebars = "transparent",
			-- floats = "transparent",
		},
		sidebars = { "qf", "help", "terminal", "packer" },
	})

	-- Rose Pine theme
	use({ "rose-pine/neovim", as = "rose-pine" })
	require("rose-pine").setup({
		-- variant = "moon",
		disable_background = true,
		-- dim_nc_background = true,
	})

	-- use("olimorris/onedarkpro.nvim")
	-- require("onedarkpro").setup({
	-- 	options = {
	-- 		transparent = true,
	-- 	},
	-- })

	-- Night owl theme
	use("oxfist/night-owl.vim")

	-- VScode theme (boooo, hissss...)
	use("Mofiqul/vscode.nvim")
	require("vscode").setup({
		transparent = true,
		-- italic_comments = true,
	})

	-- Poimandres theme
	use({
		"olivercederborg/poimandres.nvim",
	})
	require("poimandres").setup({
		bold_vert_spilt = false,
		disable_background = true,
		dim_nc_background = true, -- dim the 'non-current' window's background
		disable_italics = false,
	})
	-- use({
	-- 	--   'olivercederborg/poimandres.nvim',
	-- 	"~/Documents/Personal/nvim/poimandres.nvim",
	-- 	-- "BigusBeckus/poimandres.nvim",
	-- 	config = function()
	-- 		require("poimandres").setup({
	-- 			-- leave this setup function empty for default config
	-- 			-- or refer to the configuration section
	-- 			-- for configuration options
	-- 			dark_variant = true,
	-- 			disable_italics = false,
	-- 		})
	-- 	end,
	-- })

	-- Lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		-- requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	require("lualine").setup({
		options = {
			component_separators = "|",
			section_separators = "",
			icons_enabled = true,
			theme = "auto",
			-- theme = "poimandres",
			-- theme = "tokyonight",
			-- theme = "gruvbox",
		},
	})

	-- Heirline
	--  local statusline = {...}
	--  local winbar = {...}
	--  local tabline = {...}
	--  use {
	--    "rebelot/heirline.nvim",
	--    config = function()
	--      require('heirline').setup(statusline, winbar, tabline)
	--    end
	--  }

	-- nvim-dap (Debug Adapter Protocol) and mason-nvim-dap
	use({ "mfussenegger/nvim-dap", "jayp0521/mason-nvim-dap.nvim" })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	-- VSCode js/ts debugger
	-- Source: https://github.com/mxsdev/nvim-dap-vscode-js
	-- use({
	-- 	"microsoft/vscode-js-debug",
	-- 	opt = true,
	-- 	run = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	-- })
	-- use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	-- use("Pocco81/DAPInstall.nvim")

	-- nvim-dap UI
	-- use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	-- null-ls (Formatter/linter)
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Harpoon
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- nvim-treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("nvim-treesitter/nvim-treesitter-context")
	-- Additional text objects via treesitter (this is actually kinda insane)
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
	-- Indents text object
	use({ "kiyoon/treesitter-indent-object.nvim", after = "nvim-treesitter" })

	-- Telescope (Fuzzy finder)
	use({
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node%_modules/.*",
						"%.git/.*",
						"^dist/.*",
						"^.next/.*",
						"^.nuxt/.*",
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
		end,
	})
	-- Configure telescope (not in `after` because the delay sometimes before the keybinds kicked in got annoying)
	require("beck.telescope")

	-- Fugitive
	use({ "tpope/vim-fugitive" })

	-- Gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 150,
				},
			})
		end,
	})

	-- Comment toggle plugins
	use("JoosepAlviste/nvim-ts-context-commentstring") -- Changes commentstring to use based on cursor position
	use({
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
	})

	-- Refactoring
	use("ThePrimeagen/refactoring.nvim")

	-- Markdown preview
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	vim.g.mkdp_echo_preview_url = 1
	vim.g.mkdp_theme = "dark"

	-- Indent blankline
	-- use("lukas-reineke/indent-blankline.nvim")

	-- Vim vinegar
	use("tpope/vim-vinegar")

	-- Case coersion and fixing words
	use("tpope/vim-abolish")

	-- Cellular automaton (this just looks fun as hell)
	use("eandrju/cellular-automaton.nvim")

	-- Vim surround
	use("tpope/vim-surround")

	-- Autopairs and autotags
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				autotag = {
					enable = true,
				},
			})
		end,
	})

	-- Lua json5 parser (mainly for loading launch.json with trailing commas)
	use({
		"Joakker/lua-json5",
		run = "./install.sh",
	})

	-- Github copilot
	use("github/copilot.vim")

	-- Go Templ
	use({
		"vrischmann/tree-sitter-templ",
		config = function()
			require("tree-sitter-templ").setup({})
		end,
	})

	-- Cloak nvim
	use("laytan/cloak.nvim")

	-- Undotree
	use("mbbill/undotree")

	-- Zen mode
	use("folke/zen-mode.nvim")
end)
