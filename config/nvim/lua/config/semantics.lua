-- Disable vim's syntax highlighter (opting for treesitter)
vim.cmd("syntax off")

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
