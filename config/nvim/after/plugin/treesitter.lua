require("nvim-treesitter.configs").setup({
	auto_install = true,
	context_commentstring = {
		enable = true,
	},
	-- ensure_installed = { "astro", "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "dart", "lua", "rust" },
	ensure_installed = {
		"astro",
		"bash",
		"c",
		"c_sharp",
		"cpp",
		"dart",
		"diff",
		"dockerfile",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"glsl",
		"go",
		"gomod",
		"gowork",
		"graphql",
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
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},
	highlight = {
		enable = true,
		disable = function(_, buf)
			local max_filesize = 100000 * 1024
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
		additional_vim_regex_highlighting = false,
	},
	sync_install = false,
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to text object, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = { query = "@function.outer", desc = "Select function" },
				["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
				["ac"] = { query = "@class.outer", desc = "Select class" },
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
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
