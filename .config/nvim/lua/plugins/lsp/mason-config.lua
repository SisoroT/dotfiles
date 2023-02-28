local lspconfig = require("lspconfig")

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
	["tailwindcss"] = function()
		lspconfig.tailwindcss.setup({
			cmd = { "tailwindcss-language-server", "--stdio" },
			filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			root_dir = lspconfig.util.root_pattern(
				"tailwind.config.js",
				"postcss.config.js",
				"package.json",
				"tsconfig.json",
				"jsconfig.json",
				".git"
			),
		})
	end,
})
