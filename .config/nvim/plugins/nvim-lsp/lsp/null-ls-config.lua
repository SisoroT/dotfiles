require("null-ls").setup({
	sources = {
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.diagnostics.flake8,
		require("null-ls").builtins.formatting.black.with({
			extra_args = { "--fast" },
		}),
		-- require("null-ls").builtins.formatting.prettier.with({
		-- 	extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		-- }),
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.completion.spell,
	},

	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
