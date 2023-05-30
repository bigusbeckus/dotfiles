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

vim.opt.cursorline = false

-- Permanently enable gutters to avoid shifting with lsp-zero icons that I haven't figured out how to disable yet
vim.opt.signcolumn = "yes"

-- Get underline cursor in some mods (wohooo)
vim.opt.guicursor = "n-v:block,i-c-ci-cr-r:ver25-hor50"

-- Disable vim's default syntax highlighting (we'll be using treesitter)
-- vim.cmd([[ syntax off ]])

-- IndentBlankline backgrounds
vim.opt.termguicolors = true

-- Import custom plugins and configs
require("beck.plugins")
-- require("beck.lsp")
-- require("beck.lsp.lsp-zero")
-- require("beck.cmp")
require("beck.keys")

-- Set colorscheme
vim.o.background = "dark"
-- vim.cmd("colorscheme poimandres")
-- vim.cmd("colorscheme tokyonight")
vim.cmd("colorscheme gruvbox")

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

-- Autocommand to disable vim's default syntax highlighting for everything except shell scripts
-- vim.cmd([[
--   augroup syntax_highlight
--     autocmd!
--     autocmd BufEnter * if &buftype != 'sh' && &buftype != 'bash' || &buftype != 'zsh' | syntax off | endif
--   augroup END
-- ]])

-- Neovide configs
if vim.g.neovide then
	require("beck.neovide")
end

-- local current_buffer = vim.api.nvim_get_current_buf()
-- local filetype = vim.filetype.match({ buf = current_buffer })
-- if not (filetype == "bash" or filetype == "zsh") then
-- 	-- vim.opt.syntax = "off"
-- vim.cmd([[ syntax off ]])
-- end
