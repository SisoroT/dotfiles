local actions = require("telescope.actions")
local M = {}
local opts = { noremap = true, silent = true }
require("telescope").setup({
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
			"rg",
			"files",
			"hidden",
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

--------------
-- keybinds --
--------------

-- search files in current directory
vim.api.nvim_set_keymap("n", "<leader>fc", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", opts)
-- search files in documents folder
vim.api.nvim_set_keymap(
	"n",
	"<leader>fd",
	":Telescope find_files find_command=rg,--ignore,--hidden,--files cwd=~/documents/<CR>",
	opts
)
-- search all files in .config folder
vim.api.nvim_set_keymap(
	"n",
	"<leader>F",
	":Telescope find_files find_command=rg,--ignore,--hidden,--files cwd=~/.config/<CR>",
	opts
)

-- search within current buffer
vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope current_buffer_fuzzy_find sorting_strategy=ascending<CR>", opts)
