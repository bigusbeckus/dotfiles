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
-- vim.opt.cursorcolumn = true

-- Permanently enable gutters to avoid shifting with lsp-zero icons
vim.opt.signcolumn = "yes"

-- Get underline cursor in some modes (woohooo)
vim.opt.guicursor = "n-v:block,i-c-ci-cr-r:ver25-hor50"

-- Enable full color support (I think)
vim.opt.termguicolors = true


-- Disable vim's default syntax highlighting (we'll be using treesitter)
vim.cmd([[ syntax off ]])

-- Autocommand to disable vim's default syntax highlighting for everything except shell scripts
vim.cmd([[
  augroup syntax_highlight
    autocmd!
    autocmd FileType bash syntax enable
    autocmd FileType netrw syntax enable
    autocmd FileType sh syntax enable
    autocmd FileType tmux syntax enable
    autocmd FileType zsh syntax enable
    autocmd FileType zsh-theme syntax enable
  augroup END
]])

-- Autocommand to move change default help windows to vertical left
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
