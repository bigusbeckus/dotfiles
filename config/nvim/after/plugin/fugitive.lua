-- Old Git show mapping
-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- Helper function to check if current directory is repo
local function has_git_folder()
  -- Get the current working directory of the vimrc file
  local cwd = vim.fn.getcwd()
  local maxDirs = 20
  local directories = {}

  -- Iterate over the directories in the path and place them in a table
  for dir in string.gmatch(cwd, "[^/]+") do
    if maxDirs > 0 then
      table.insert(directories, dir)
      maxDirs = maxDirs - 1
    else
      break
    end
  end

  -- Iterate over the directories table in reverse and check for a .git folder
  for i = #directories, 1, -1 do
    -- Check if there is a .git folder in this directory
    if vim.fn.isdirectory(".git") == 1 then
      return true
    end
  end
  return false
end

-- Keymaps for when inside a git repo
if has_git_folder() then
  vim.keymap.set("n", "<leader>gg", function()
    vim.api.nvim_command([[ vertical Git ]])
    -- vim.api.nvim_command([[ Git ]])
  end)
end
