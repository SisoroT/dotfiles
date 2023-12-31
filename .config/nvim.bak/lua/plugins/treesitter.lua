-- better syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufRead",
	build = ":TSUpdate",
	dependencies = {
		-- rainbow parens
		"HiPhish/rainbow-delimiters.nvim",
		-- auto match html/jsx tags
		"windwp/nvim-ts-autotag",
		-- show context of current buffer contents
		"nvim-treesitter/nvim-treesitter-context",
	},

	config = function()
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all" (the listed parsers should always be installed)
			ensure_installed = {
				"bash",
				"c",
				"c_sharp",
				"comment",
				"css",
				"html",
				"javascript",
				"json",
				"lua",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
			auto_install = true,
			-- List of parsers to ignore installing (for "all")
			ignore_install = {},
			highlight = {
				enable = true, -- false will disable the whole extension
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = false,
			},
			autopairs = {
				enable = true,
			},
			autotag = {
				enable = true,
			},
		})
	end,
}
