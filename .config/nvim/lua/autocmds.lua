local api = vim.api

-- highlight yanked text
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- open terminal in insert mode
api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.cmd("startinsert")
	end,
})

-- delete trailing whitespace on save
api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.cmd("silent! %s/\\s\\+$//e")
	end,
})
