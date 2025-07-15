local function has_git_folder()
	return vim.fn.isdirectory(".git") == 1
end

-- Helper function to check if current directory is repo
local function is_git_repo()
	if has_git_folder() then
		return true
	end

	-- Get the current working directory
	local cwd = vim.fn.getcwd()
	local maxDirs = 20
	local directories = {}
	local compiled_path = ""

	-- Iterate over the directories in the path and place them in a table
	for dir in string.gmatch(cwd, "[^/]+") do
		compiled_path = compiled_path .. "/" .. dir
		if maxDirs > 0 then
			table.insert(directories, compiled_path)
			maxDirs = maxDirs - 1
		else
			break
		end
	end

	table.remove(directories)

	-- Iterate over the directories table in reverse and check for a .git folder
	for i = #directories, 1, -1 do
		-- Check if there is a .git folder in this directory
		if vim.fn.isdirectory(directories[i] .. "/.git") == 1 then
			return true
		end
	end
	return false
end

return {
	"tpope/vim-fugitive", -- Awesome git UI
	event = "VeryLazy",
	config = function()
		-- Robbed in broad daylight from ThePrimeagen
		-- https://github.com/ThePrimeagen/init.lua/blob/e148c2cdfd54d6194ce57c856d1000d8c8111d4f/lua/theprimeagen/lazy/fugitive.lua
		local CustomFugitive = vim.api.nvim_create_augroup("CustomFugitive", {})

		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWinEnter", {
			group = CustomFugitive,
			pattern = "*",
			callback = function()
				if vim.bo.ft ~= "fugitive" then
					return
				end

				local bufnr = vim.api.nvim_get_current_buf()
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "<leader>p", function()
					vim.cmd.Git("push")
				end, opts)

				vim.keymap.set("n", "<leader>P", function()
					vim.cmd.Git("pull") -- No rebase for me though :P
				end, opts)

				-- NOTE: It allows me to easily set the branch i am pushing and any tracking
				-- needed if i did not set the branch up correctly
				vim.keymap.set("n", "<leader>o", ":Git push -u origin ", opts)
			end,
		})

		-- Keymaps for when inside a git repo
		if is_git_repo() then
			vim.keymap.set("n", "<leader>gg", function()
				vim.api.nvim_command([[ vertical Git ]])
			end)

			-- Stolen from ThePrimeagen again
			vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
		end
	end,
}
