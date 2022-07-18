local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			-- lunarvim has operators, motions, and text_objects as false. Speed?
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow, rounded
		position = "top", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = {
		"<silent>",
		"<cmd>",
		"<Cmd>",
		"<CR>",
		"call",
		"lua",
		"^:",
		"^ ",
	}, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local normal_opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local normal_mappings = {
	["T"] = { "<cmd>NvimTreeFindFile<cr>zz", "Explorer" },
  ["e"] = {
      "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>",
      "Show line diagnostics"
  },
	["w"] = { "<cmd>w<CR>", "Save" },
	["q"] = { "<cmd>q<CR>", "Quit" },
	["f"] = { "<cmd>Telescope find_files theme=ivy<CR>", "Find File" },
  ["m"] = { "<cmd>HopWord<cr>", "Word" },
	["n"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["v"] = { "<cmd>vsplit<CR>", "Vertical split" },
	["h"] = { "<cmd>split<CR>", "Horizontal split" },
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	["z"] = { "<cmd>ZenMode<cr>", "ZenMode" },
	["o"] = { "<cmd>MaximizerToggle<cr>", "Focus Window" },
	["md"] = { "<cmd>MarkdownPreviewToggle<cr>", "Markdown View" },
  ["I"] = { "<cmd>e ~/.config/nvim/init.vim<CR>", "Open VimRC" },
  ["S"] = { "<cmd>call WindowSwap#EasyWindowSwap()<CR>", "Swap Windows" },

  a = {
    name = "All",
    w = { "<cmd>wa<CR>", "Save" },
    q = { "<cmd>qa<CR>", "Quit" },
    f = { "<cmd>qa!<CR>", "Force Quit" },
  },


	b = {
		name = "Buffers",
		j = { "<cmd>BufferPick<cr>", "jump to buffer" },
		f = { "<cmd>Telescope buffers<cr>", "Find buffer" },
		w = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
		b = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy())<cr>",
			"Buffers",
		},
		e = {
			"<cmd>BufferCloseAllButCurrent<cr>",
			"close all but current buffer",
		},
		h = {
			"<cmd>BufferCloseBuffersLeft<cr>",
			"close all buffers to the left",
		},
		D = {
			"<cmd>BufferOrderByDirectory<cr>",
			"sort BufferLines automatically by directory",
		},
    l = {
      "<cmd>bd #<CR>",
      "Close last buffer",
    },
		L = {
			"<cmd>BufferOrderByLanguage<cr>",
			"sort BufferLines automatically by language",
		},
	},

	p = {
		name = "Packer",
		-- TODO: add commands to reload, remove all, reinstall, etc.
		-- see lunarvim reload_lv_config in their util file for deets
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

  d = {
    name = "debug",
    d = {
     "<cmd>lua require'dap'.continue()<cr>",
      "Continue",
    },
    u = {
     "<cmd>lua require('dapui').toggle()<cr>",
      'Toggle UI',
    },
    b = {
     "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
      'Breakpoint',
    },
    o = {
     "<cmd>lua require'dap'.step_over()<cr>",
      'Step Over',
    },
    i = {
     "<cmd>lua require'dap'.step_into()<cr>",
      'Step Into',
    },
    t = {
      "<cmd>lua require'neotest'.run.run({strategy = 'dap'})<cr>",
      "Debug Test"
    }
  },

	l = {
		name = "lsp",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope diagnostics<cr>",
			"Document Diagnostics",
		},
        e = {
          "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>",
          "Show line diagnostics"
        },
		g = {
			"<cmd>lua vim.lsp.buf.definition()<cr>",
			"Goto Definition",
		},
        h = {
          "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",
          "Hover",
        },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
	},
	j = {
    name = "Jump",
    a = { "<cmd>A<CR>", "Jump to alternative" },
    v = { "<cmd>AV<CR>", "Jump to alternative in vertical split" }
  },
  r = {
    name = "Runner",
    t = {
      "<cmd>lua require('telescope').extensions.vstask.tasks()<cr>",
      "Tasks",
    },
    i = {
      "<cmd>lua require('telescope').extensions.vstask.inputs()<cr>",
      "Inputs",
    },
  },
	s = {
		name = "Search",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		d = {
			"<cmd>Telescope find_files hidden=true<cr>",
			"Find File (+hidden)",
		},
    D = {
      "<cmd>lua require('telescope.builtin').live_grep({ search_dirs = { 'telescope'.extensions.file_browser.file_browser }})<CR>",
      "Live grep in current directory"
    },
		b = { "<cmd>Telescope git_branches theme=ivy<cr>", "Checkout branch" },
		c = { "<cmd>Telescope current_buffer_fuzzy_find theme=ivy<CR>", "Fuzzy find current" },
		C = { "<cmd>Telescope commands theme=ivy<cr>", "Commands" },
		h = { "<cmd>Telescope command_history theme=ivy<cr>", "Command history" },
    j = { "<cmd>Telescope jumplist theme=ivy<cr>", "Jump list" },
		m = { "<cmd>Telescope changed_files theme=ivy<cr>", "Modified Files" },
		M = { "<cmd>Telescope man_pages theme=iv<cr>", "Man Pages" },
		o = { "<cmd>Telescope oldfiles theme=ivy<cr>", "Old files" },
    O = { "<cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>", "Grep open files" },
		r = { "<cmd>Telescope lsp_references theme=ivy<cr>", "Goto References" },
		R = { "<cmd>Telescope registers theme=ivy<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Text" },
		T = { "<cmd>Telescope theme=ivy<cr>", "Telescope" },
		u = { "<cmd>Telescope grep_string theme=ivy<CR>", "Text under cursor" },
		k = { "<cmd>Telescope keymaps theme=ivy<cr>", "Keymaps" },
		p = {
			"<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
			"Colorscheme with Preview",
		},
    w = {
      "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>",
      "Specific string"
    }
	},
	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>vsplit <cr>|<cmd> term<cr>i", "Vertical" },
	},
	y = {
    name = "Copy",
    p = { "<cmd>let @+ = expand('%')<cr>", "Copy file path" }
  },
}

wk.setup(setup)
wk.register(normal_mappings, normal_opts)
