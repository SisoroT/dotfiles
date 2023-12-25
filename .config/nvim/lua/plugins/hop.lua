-- allows jumping anywhere in the file using keystrokes
return {
	"phaazon/hop.nvim",
	keys = {
		-- jump words
		{ "<leader>w", "<cmd>lua require'hop'.hint_words()<cr>", mode = { "n", "v" } },
		-- jump lines
		{ "<leader>x", "<cmd>lua require'hop'.hint_words()<cr>", mode = { "n", "v" } },
	},
	config = true,
}
