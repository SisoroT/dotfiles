require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,

	["sumneko_lua"] = function()
		require("lspconfig").sumneko_lua.setup({
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
		require("lspconfig").pyright.setup({
			settings = {
				python = {
					analysis = {
						uselibrarycodefortypes = true,
						diagnosticseverityoverrides = {
							reportgeneraltypeissues = "none",
							reportoptionalmemberaccess = "none",
							reportoptionalsubscript = "none",
							reportprivateimportusage = "none",
						},
					},
				},
			},
		})
	end,
	["clangd"] = function()
		require("lspconfig").clangd.setup({
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
})