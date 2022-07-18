local M = {}
function M:configure()
	local status_ok, symbols = pcall(require, "symbols-outline")
	if not status_ok then
		return
	end
  local opts = {
      highlight_hovered_item = false,
      -- whether to show outline guides
      -- default: true
      show_guides = false,
  }
  symbols.setup(opts)
end

M.configure()
return M
