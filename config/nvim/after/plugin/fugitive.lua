-- Old Git show mapping
-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local function has_git_folder()
	return vim.fn.isdirectory(".git") == 1
end

-- Helper function to check if current directory is repo
local function is_git_repo()
	if has_git_folder() then
		return true
	end

	-- Get the current working directory of the vimrc file
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

-- Keymaps for when inside a git repo
if is_git_repo() then
	vim.keymap.set("n", "<leader>gg", function()
		vim.api.nvim_command([[ vertical Git ]])
		-- vim.api.nvim_command([[ Git ]])
	end)
end
