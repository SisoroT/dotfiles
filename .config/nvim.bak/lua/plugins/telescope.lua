-- fuzzy file finder
return {
	"nvim-telescope/telescope.nvim",
	lazy = true,
	keys = {
		-- search files in current directory
		{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
		-- search all files in .config folder
		{
			"<leader>fc",
			"<cmd>lua require('telescope.builtin').find_files({prompt_title = 'Search ~/.config/', cwd = vim.fn.expand('~/.config/')})<cr>",
		},
		-- search for string in cwd with ripgrep
		{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
	},

	config = function()
		local actions = require("telescope.actions")

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
				vimgrep_arguments = {
					"rg",
					"--hidden",
					"--no-ignore",
					"--smart-case",
					"--column",
				},
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden" },
				},
				live_grep = { "rg", "--hidden" },
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
	end,
}
