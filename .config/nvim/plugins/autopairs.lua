require("nvim-autopairs").setup({
	-- enable_check_bracket_line = true,

	-- change default fast_wrap
	fast_wrap = {
		map = "<C-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
		offset = 0, -- Offset from pattern match
		end_key = "w",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		hightlight = "Search",
	},
})
