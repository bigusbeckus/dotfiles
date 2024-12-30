local M = {}

function M.is_windows()
	return jit.os:find("Windows")
end

return M
