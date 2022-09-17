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
	experimental = {
		ghost_text = true,
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

-- you need setup cmp first put this after cmp.setup()
require("cmp").setup({
	map_cr = true, --  map <CR> on insert mode
	map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
	auto_select = true, -- automatically select the first item
	insert = false, -- use insert confirm behavior instead of replace
	map_char = { -- modifies the function or method delimiter by filetypes
		all = "(",
		tex = "{",
	},
})
