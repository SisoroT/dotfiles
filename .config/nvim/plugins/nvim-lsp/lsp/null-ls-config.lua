require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.prettier.with({
            extra_args = { "--tab-width", "4", "--no-semi", "--single-quote", "--jsx-single-quote" },
        }),
        require("null-ls").builtins.formatting.stylua,
        -- require("null-ls").builtins.formatting.codespell,
        require("null-ls").builtins.diagnostics.codespell,
        require("null-ls").builtins.diagnostics.flake8,
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
