local open_md_preview = function()
	local current_buffer = vim.api.nvim_get_current_buf()
	if vim.filetype.match({ buf = current_buffer }) == "markdown" then
		vim.cmd([[MarkdownPreviewToggle]])
		-- else
		-- 	print("Not a markdown file")
	end
end
vim.keymap.set("n", "<leader>md", open_md_preview, { noremap = true })
