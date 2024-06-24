local disable_treesitter_highlight = false
-- local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- treesitter_parser_config["templ"] = {
-- 	install_info = {
-- 		url = "https://github.com/vrischmann/tree-sitter-templ.git",
-- 		files = { "src/parser.c", "src/scanner.c" },
-- 		branch = "master",
-- 	},
-- }

require("ts_context_commentstring").setup({})
vim.g.skip_ts_context_commentstring_module = true

require("nvim-treesitter.configs").setup({
	auto_install = true,
	ensure_installed = {
		"astro",
		"bash",
		"c",
		"c_sharp",
		"cpp",
		"dart",
		"diff",
		"dockerfile",
    "elixir",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"glsl",
		"go",
		"gomod",
		"gowork",
		"graphql",
    "haskell",
		"hcl",
		"html",
		"java",
		"javascript",
		"json",
		"jsonc",
		"kotlin",
		"lua",
		"make",
		"markdown_inline",
		"ocaml",
		"php",
		"prisma",
		"proto",
		"python",
		"regex",
		"ruby",
		"rust",
		"scss",
		"sql",
		"svelte",
		"swift",
		"templ",
		"toml",
		"tsx",
		"terraform",
		"typescript",
		"vim",
		"vimdoc",
		"vue",
		"yaml",
	},
	highlight = {
		enable = true,
		disable = function(_, bufnr)
			if disable_treesitter_highlight then
				return true
			end
			local buf_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))
			return buf_size > 100 * 1024
		end,
		max_file_lines = 10000,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	sync_install = false,
	textobjects = {
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = { query = "@function.outer", desc = "Next function start" },
				["]l"] = { query = "@loop.outer", desc = "Next loop start" },
			},
			goto_next_end = {
				["]F"] = { query = "@function.outer", desc = "Next function end" },
				["]L"] = { query = "@loop.outer", desc = "Next loop end" },
			},
			goto_previous_start = {
				["[f"] = { query = "@function.outer", desc = "Previous function start" },
				["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
			},
			goto_previous_end = {
				["[F"] = { query = "@function.outer", desc = "Previous function end" },
				["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
			},
			goto_next = {
				-- ["]c"] = { query = "@conditional.outer", desc = "Next conditional" },
				["]r"] = { query = "@return.outer", desc = "Next return" },
			},
			goto_previous = {
				-- ["[c"] = { query = "@conditional.outer", desc = "Previous conditional" },
				["[r"] = { query = "@return.outer", desc = "Previous return" },
			},
		},
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to text object, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm or builtins from the link below
				-- Source: https://github.com/nvim-treesitter/nvim-treesitter-textobjects#built-in-textobjects
				["af"] = { query = "@function.outer", desc = "Select function" },
				["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
				["aC"] = { query = "@class.outer", desc = "Select class" },
				["iC"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				-- Additional
				["aa"] = { query = "@frame.outer", desc = "Select assignment" },
				["ia"] = { query = "@frame.inner", desc = "Select inner part of an assignment" },
				["ab"] = { query = "@block.outer", desc = "Select block" },
				["ib"] = { query = "@block.inner", desc = "Select inner part of a block" },
				-- ["ac"] = { query = "@comment.outer", desc = "Select comment" },
				-- ["ic"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
				["al"] = { query = "@loop.outer", desc = "Select loop" },
				["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
				["ac"] = { query = "@conditional.outer", desc = "Select conditional" },
				["ic"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
				["ar"] = { query = "@return.outer", desc = "Select return statement" },
				["ir"] = { query = "@return.inner", desc = "Select inner part of a return statement" },
				["as"] = { query = "@statement.outer", desc = "Select statement" },
				["is"] = { query = "@statement.inner", desc = "Select inner part of a statement" },
			},
		},
	},
})

-- Indent textobject
-- Select context-aware indent
vim.keymap.set({ "x", "o" }, "ai", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>")
-- Ensure selecting entire line (or just use Vai)
vim.keymap.set({ "x", "o" }, "aI", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>")
-- Select inner block (only if block, only else block, etc.)
vim.keymap.set({ "x", "o" }, "ii", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>")
-- Select entire inner range (including if, else, etc.)
vim.keymap.set({ "x", "o" }, "iI", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>")

-- Folding
-- Source: https://github.com/nvim-treesitter/nvim-treesitter#Folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldenable = false
