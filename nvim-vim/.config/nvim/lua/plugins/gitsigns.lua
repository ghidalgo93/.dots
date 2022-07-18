local M = {}
function M:configure()
	local status_ok, gitsigns = pcall(require, "gitsigns")
	if not status_ok then
		return
	end

  gitsigns.setup()
end

M.configure()
return M
