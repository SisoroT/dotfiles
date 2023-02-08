-- If null-ls runs into an error, print that there was an error and return
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	print("null_ls encountered an error while loading")
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

require("null-ls").setup({
	sources = {
		-- python
		formatting.black,
		diagnostics.flake8,

		-- lua
		formatting.stylua,

		-- javascript, css, html
		formatting.prettier.with({
			extra_args = { "--tab-width", "4", "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		-- html only
		diagnostics.tidy,
		-- javascript only
		diagnostics.eslint,
		code_actions.eslint,

		-- php
		formatting.phpcbf.with({
			extra_args = { "--standard=PSR12" },
		}),
		diagnostics.phpcs.with({
			extra_args = { "--standard=PSR12", "--ignore=PEAR.Commenting.FileComment.Missing" },
		}),

		-- sql
		formatting.sqlfluff.with({
			extra_args = { "--dialect", "mysql" },
		}),
		diagnostics.sqlfluff.with({
			extra_args = { "--dialect", "mysql", "--exclude-rules", "L044" },
		}),

		-- shell
		formatting.shfmt,
		diagnostics.shellcheck,

		-- spellchecking
		-- formatting.codespell,
		diagnostics.codespell,
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            augroup END
            ]])
		end
	end,
})
