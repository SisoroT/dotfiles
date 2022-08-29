require("null-ls").setup({
    sources = {
        -- python
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.diagnostics.flake8,

        -- lua
        require("null-ls").builtins.formatting.stylua,

        -- javascirpt, css, html
        require("null-ls").builtins.formatting.prettier.with({
            extra_args = { "--tab-width", "4", "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),

        -- sql
        require("null-ls").builtins.formatting.pg_format,
        require("null-ls").builtins.diagnostics.sqlfluff.with({
            extra_args = { "--dialect", "mysql" },
        }),

        -- spellchecking
        -- require("null-ls").builtins.formatting.codespell,
        require("null-ls").builtins.diagnostics.codespell,
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
