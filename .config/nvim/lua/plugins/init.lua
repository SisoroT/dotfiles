-- plugins w/o configs
return {
	-- see all diagnostics in buffer at once
	{
		"folke/trouble.nvim",
		keys = { { "<leader>t", "<cmd>TroubleToggle<cr>" } },
	},

	-- lsp signatures
	{
		"ray-x/lsp_signature.nvim",
		config = true,
	},

	-- better comments (adds TODO, FIXME, etc)
	{
		"folke/todo-comments.nvim",
		config = true,
	},

	-- visualize git conflicts
	{ "akinsho/git-conflict.nvim", version = "*", config = true },

	-- sudo save
	{
		"lambdalisue/suda.vim",
		init = vim.api.nvim_create_user_command("W", "SudaWrite", {}),
	},

	-- kill bad habits :)
	{
		"m4xshen/hardtime.nvim",
		config = true,
	},

	-- blankline for tabs
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

	-- highlights colors behind hex, rgb, and names
	{
		"NvChad/nvim-colorizer.lua",
		config = true,
	},

	-- markdown preview
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = "markdown",
		keys = { { "<leader>mp", ":MarkdownPreviewToggle<cr>" } },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
