local actions = require ("telescope.actions")
local M ={}
require('telescope').setup {
    defaults = {
        color_devicons = true,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-s>"] = actions.select_horizontal,
            },
        },
        file_sorter = {
            'rg',
            'files',
            'hidden',
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
        },
    },
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- M.find_files = function()
--     telescope_builtin.find_files {
--         find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
--         previewer = false
--     }
-- end

-- local M = {}
-- M.search_dotfiles = function()
--     require("telescope.builtin").find_files({
--         prompt_title = "< ~ >",
--         cwd = "~/",
--         hidden = true,
--     })
-- end

-- return M
