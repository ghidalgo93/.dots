local M = {}
function M:configure()
	local status_ok, todo = pcall(require, "todo-comments")
	if not status_ok then
		return
	end

  todo.setup()
end

M.configure()
return M
