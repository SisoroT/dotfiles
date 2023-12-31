-- diagnostics, linting, and autoformatting
return {
    "nvimtools/none-ls.nvim",

    config = function()
        local null_ls = require("null-ls")
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
            on_attach = function(client, bufnr)
                if client.server_capabilities.documentFormattingProvider then
                    local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = group,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
    end,
}
