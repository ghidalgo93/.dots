local M = {}
function M:configure()
	local status_ok, trouble = pcall(require, "trouble")
	if not status_ok then
		return
	end

  trouble.setup {}
end

M.configure()
return M
