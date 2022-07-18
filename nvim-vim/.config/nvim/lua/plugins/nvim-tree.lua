local M = {}
function M:configure()
	local status_ok, nvimtree = pcall(require, "nvim-tree")
	if not status_ok then
		return
	end

  nvimtree.setup {
  diagnostics = {
    enable = true
  },
  view = {
		number = true,
		relativenumber = true,
    auto_resize = true,
    },
    renderer = {
      full_name = true,
      highlight_opened_files = "name",
      icons = {
        glyphs = {
          default = '',
          symlink = '',
          git = {
              unstaged = "",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌"
            }
        }
      }
    }
  }
end

M.configure()
return M
