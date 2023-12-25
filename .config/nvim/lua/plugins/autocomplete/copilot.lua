-- github copilot

return {
	"github/copilot.vim",
	event = "BufRead",
	keys = {
		-- accept full suggestion
		{
			"<M-a>",
			"copilot#Accept()",
			mode = "i",
			silent = true,
			script = true,
			expr = true,
			replace_keycodes = false,
		},
		-- dismiss suggestion
		{ "<M-d>", "<Plug>(copilot-dismiss)", mode = "i" },
		-- trigger suggest
		{ "<M-s>", "<Plug>(copilot-suggest)", mode = "i" },
		-- next and prev suggestion
		{ "<M-l>", "<Plug>(copilot-next)", mode = "i" },
		{ "<M-h>", "<Plug>(copilot-previous)", mode = "i" },
	},

	config = function()
		-- disable tab complete
		vim.g.copilot_no_tab_map = true
	end,
}
