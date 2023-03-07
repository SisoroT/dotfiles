local lspconfig = require("lspconfig")
-- needed for css
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- required for :LspInstall command
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"clangd",
		"cssls",
		"html",
		"intelephense",
		"jsonls",
		"lua_ls",
		"pyright",
		"sqlls",
		"tailwindcss",
		"tsserver",
		"vimls",
	},
})
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		lspconfig[server_name].setup({})
	end,
	-- Next, you can provide targeted overrides for specific servers.
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						-- get the language server to recognize the `vim` global
						globals = { "vim" },
					},
				},
			},
		})
	end,
	["pyright"] = function()
		lspconfig.pyright.setup({
			settings = {
				python = {
					analysis = {
						useLibraryCodeForTypes = true,
						diagnosticSeverityOverrides = {
							reportGeneralTypeIssues = "none",
							reportOptionalMemberAccess = "none",
							reportOptionalSubscript = "none",
							reportPrivateImportUsage = "none",
						},
					},
				},
			},
		})
	end,
	["clangd"] = function()
		lspconfig.clangd.setup({
			cmd = {
				"clangd",
				"--background-index",
				"--pch-storage=memory",
				"--clang-tidy",
				"--suggest-missing-includes",
				"--completion-style=detailed",
				"--cross-file-rename",
				"--offset-encoding=utf-16", -- fixes multiple encoding issue
			},
		})
	end,
	["cssls"] = function()
		lspconfig.cssls.setup({
			capabilities = capabilities,
		})
	end,
	["tailwindcss"] = function()
		lspconfig.tailwindcss.setup({
			filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
		})
	end,
})
