require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
	},

	indent = {
		enable = false,
	},

	rainbow = {
		enable = true,
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = {

			"#ff5555",
			"#ffb86c",
			"#f1fa8c",
			"#50fa7b",
			"#8be9fd",
			"#ff79c6",
			"#bd93f9",
		}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})

-- allows bracket rainbow parens plugin to still come through
-- require"nvim-treesitter.highlight"
-- local hlmap = vim.treesitter.highlighter.hl_map
-- hlmap.error = nil
-- hlmap["punctuation.delimiter"] = "Delimiter"
-- hlmap["punctuation.bracket"] = nil
