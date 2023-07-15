print("Cleanup file")
local is_nvim_instance_running = function()
	if vim.fn.exists("nv_ls_nvim") == 1 then
		return 1
	end
	return 0
end

-- Kill the eslint_d and prettierd processes if no
-- instance of neovim is running
local function cleanup()
	local eslint_d_pid = vim.fn.jobstart({ "eslint_d" })
	local prettier_d_pid = vim.fn.jobstart({ "prettierd" })

	if not is_nvim_instance_running() then
		vim.fn.jobstop(eslint_d_pid)
		vim.fn.jobstop(prettier_d_pid)
	end
end

vim.fn([[autocmd VimLeavePre * call cleanup()]])
-- vim.keymap.set("n", "<leader>u", function()
-- 	cleanup()
-- 	print("Cleanup ran")
-- end)
