-- Settings
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.autoindent = false
vim.opt.smartindent = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.fixeol = true

-- Setup leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Cursor tracker row and column
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

-- Permanently enable gutters to avoid shifting with lsp icons
vim.opt.signcolumn = "yes"

-- Get underline cursor in some modes (woohooo)
-- vim.opt.guicursor = "n-v:block,i-c-ci-cr-r:ver25-hor50"

-- Enable full color support (I think)
vim.opt.termguicolors = true

-- Pick colorscheme to be set once required plugins are installed and lazy loaded
-- Look at filenames under "lua/plugins/colorscheme" for more options
vim.o.background = "dark"
vim.g.selected_theme = "tokyonight"

-- Replace vim's default syntax highlighting with treesitter
vim.cmd([[ syntax off ]])
vim.g.prefer_treesitter_highlight = true
vim.g.max_treesitter_highlight_filesize = 100 * 1024 -- 100 KB

-- Autocommand to explicitly enable vim's default syntax highlighting for shell scripts
vim.cmd([[
  augroup syntax_highlight
    autocmd!
    autocmd FileType bash syntax enable
    autocmd FileType netrw syntax enable
    autocmd FileType samba syntax enable
    autocmd FileType sh syntax enable
    autocmd FileType tmux syntax enable
    autocmd FileType zsh syntax enable
    autocmd FileType zsh-theme syntax enable
  augroup END
]])

-- Autocommand to move change default help windows to vertical right
-- Source: https://vi.stackexchange.com/a/4464
vim.cmd([[
  augroup vertical_help
    autocmd!
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  augroup END
]])

-- Support syntax highlighting for Valve's VDF formatted acf files
local file_extension = vim.fn.expand("%:e")
if file_extension == "acf" then
	vim.opt.filetype = "vdf"
end

-- Disable vim's object collapsing for vdf type files
vim.cmd([[
  augroup disable_vdf_object_collapse
    autocmd!
    autocmd FileType vdf setlocal nofoldenable
  augroup END
]])
