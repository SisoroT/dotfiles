-- autocomplete
return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- icons for autocomplete
		"onsails/lspkind-nvim",
		-- snippets
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = { "rafamadriz/friendly-snippets" },
			keys = {
				-- jump forwards
				{
					"<C-j>",
					function()
						require("luasnip").jump(1)
					end,
					mode = { "i", "s" },
				},
				-- jump backwards
				{
					"<C-k>",
					function()
						require("luasnip").jump(-1)
					end,
					mode = { "i", "s" },
				},
			},
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		-- autocomplete sources
		{ "hrsh7th/cmp-nvim-lua", event = "InsertEnter" },
		{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
		{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
		{ "hrsh7th/cmp-path", event = "InsertEnter" },
		{ "hrsh7th/cmp-calc", event = "InsertEnter" },
		{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
		{ "kristijanhusak/vim-dadbod-completion", event = "InsertEnter" },
	},

	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
			completion = {
				completeopt = "menuone,noinsert",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-Space>"] = cmp.mapping.complete(),
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<M-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
			},
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol", -- show only symbol annotations
				}),
			},
			-- You should specify your *installed* sources.
			sources = {
				{ name = "luasnip" },
				{ name = "vim-dadbod-completion" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "buffer" },
				{ name = "path" },
				{ name = "calc" },
			},
		})
	end,
}
