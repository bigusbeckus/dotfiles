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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Permanently enable gutters to avoid shifting with lsp-zero icons that I haven't figured out how to disable yet
vim.opt.signcolumn = "yes"

-- Get underline cursor in some mods (wohooo)
vim.opt.guicursor = "n-v:block,i-c-ci-cr-r:ver25-hor50"

-- IndentBlankline backgrounds
vim.opt.termguicolors = true
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndentGray guifg=#5A5A5A gui=nocombine]])

-- Import custom plugins and configs
require("beck.plugins")
-- require("beck.lsp")
-- require("beck.lsp.lsp-zero")
-- require("beck.cmp")
require("beck.keys")

-- Set colorscheme
vim.o.background = "dark"
-- vim.cmd("colorscheme poimandres")
vim.cmd("colorscheme tokyonight")
-- vim.cmd("colorscheme gruvbox")

-- Autocommand to recompile packer managed plugins on write to plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Autocommand to move change default help windows to vertical left
-- Source: https://vi.stackexchange.com/a/4464
vim.cmd([[
  augroup vertical_help
    autocmd!
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
  augroup END
]])

-- Neovide configs
if vim.g.neovide then
	require("beck.neovide")
end
