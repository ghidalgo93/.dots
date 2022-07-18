local M = {}
function M:configure()
    local status_ok, telescope = pcall(require, "telescope")
    local actions = require('telescope.actions')
    if not status_ok then
        print("telescope not found")
        return
    end

    telescope.setup {
        builtin = {
            buffers = {
                ignore_current_buffer = true,
                sort_mru = true
            },
            git_branches = {
                mappings = {
                    i = {
                        ["c-d"] = actions.git_delete_branch
                    },
                    n = {
                        ["c-d"] = actions.git_delete_branch
                    }
                }
            }
        },
        defaults = {
            file_sorter = require('telescope.sorters').get_fzy_sorter,
            prompt_prefix = ' >',
            color_devicons = true,
            theme = "ivy",

            file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

            path_display={'absolute'},
            mappings = {
                i = {
                    ["<C-q>"] = actions.send_to_qflist,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                },
            }
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },
            ["ui-select"] = {
                require("telescope.themes").get_dropdown {
                    -- even more opts
                }

                -- pseudo code / specification for writing custom displays, like the one
                -- for "codeactions"
                -- specific_opts = {
                --   [kind] = {
                --     make_indexed = function(items) -> indexed_items, width,
                --     make_displayer = function(widths) -> displayer
                --     make_display = function(displayer) -> function(e)
                --     make_ordinal = function(e) -> string
                --   },
                --   -- for example to disable the custom builtin "codeactions" display
                --      do the following
                --   codeactions = false,
                -- }
            },
        }
    }

    telescope.load_extension('fzy_native')
    telescope.load_extension('changed_files')
    telescope.load_extension('ui-select')
    telescope.load_extension('file_browser')
end

M.configure()
return M
