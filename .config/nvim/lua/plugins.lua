-- Automatically compile, update, and install on file save
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
	pattern = "plugins.lua",
	command = "source <afile> | PackerSync",
})

-- If packer runs into an error, print that there was an error and return
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("Packer encountered an error while loading")
	return
end

-- Install plugins
return packer.startup({
	function(use)
		---------------------
		-- Package Manager --
		---------------------

		-- have packer manage itself
		use("wbthomason/packer.nvim")

		----------------------
		-- Required plugins --
		----------------------

		-- a lot of useful lua functions that many plugins rely on
		use("nvim-lua/plenary.nvim")

		----------------------------------
		-- LSP, Linting, and Formatting --
		----------------------------------

		use({
			-- easier installation of packages for lsp, linters, and formatters
			{
				"williamboman/mason.nvim",
				config = function()
					require("plugins.lsp.mason")
				end,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("plugins.lsp.mason-config")
				end,
			},
			-- native lsp
			{
				"neovim/nvim-lspconfig",
				config = function()
					require("plugins.lsp.lsp-config")
				end,
			},
		})

		-- diagnostics and autoformatting
		use({
			"jose-elias-alvarez/null-ls.nvim",
			event = "BufRead",
			config = function()
				require("plugins.lsp.null-ls-config")
			end,
		})

		-- java lsp
		use({
			"mfussenegger/nvim-jdtls",
			config = function()
				require("plugins.lsp.jdtls")
			end,
			ft = "java",
		})

		-- diagnostics
		use({
			"folke/trouble.nvim",
			config = function()
				require("plugins.lsp.trouble")
			end,
		})

		-- lsp signatures
		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup(cfg)
			end,
		})

		-----------------------------
		-- Completion and Snippets --
		-----------------------------

		-- icons for autocomplete
		use("onsails/lspkind-nvim")
		-- autocomplete
		use({
			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
				config = function()
					require("plugins.autocomplete.cmp-config")
				end,
				requires = {
					{
						"L3MON4D3/LuaSnip",
						event = "InsertEnter",
						config = function()
							require("plugins.autocomplete.luasnip")
						end,
						requires = {
							{
								"rafamadriz/friendly-snippets",
								event = "CursorHold",
							},
						},
					},
				},
			},
			-- autocomplete sources
			{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-calc", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "kristijanhusak/vim-dadbod-completion", after = "nvim-cmp" },
		})

		-- github copilot
		use({
			"github/copilot.vim",
			config = function()
				require("plugins.autocomplete.copilot")
			end,
		})

		--------------------------
		-- Editor Niceties --
		--------------------------

		-- auto bracket pairing
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("plugins.autopairs")
			end,
			after = "nvim-cmp",
		})

		-- quick commentary
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("plugins.comment")
			end,
		})

		-- sudo save
		use({
			"lambdalisue/suda.vim",
			setup = "vim.api.nvim_create_user_command('W', 'SudaWrite', {})",
		})

		---------------------------------------------
		-- Navigation, Fuzzy Search, and File Tree --
		---------------------------------------------

		-- fuzzy file finder
		use({
			{
				"nvim-telescope/telescope.nvim",
				event = "CursorHold",
				config = function()
					require("plugins.telescope")
				end,
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				after = "telescope.nvim",
				run = "make",
				config = function()
					require("telescope").load_extension("fzf")
				end,
			},
		})

		-- file tree
		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("plugins.nvim-tree")
			end,
		})

		-- movement
		use({
			"unblevable/quick-scope",
			setup = "vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }",
		})
		use({
			"phaazon/hop.nvim",
			event = "BufRead",
			config = function()
				require("plugins.hop")
			end,
		})

		----------------------------------------
		-- Theme, Icons, Statusbar, Bufferbar --
		----------------------------------------

		-- colorschemes
		use("folke/tokyonight.nvim")
		use("rktjmp/lush.nvim")
		use("Dracula/vim")

		-- blankline for tabs
		use("lukas-reineke/indent-blankline.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			config = function()
				require("plugins.status-line.lualine")
			end,
		})
		use({
			"akinsho/bufferline.nvim",
			config = function()
				require("plugins.status-line.bufferline")
			end,
		})
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		})
		use("kyazdani42/nvim-web-devicons")
		use({
			{
				"nvim-treesitter/nvim-treesitter",
				run = ":TSUpdate",
				config = function()
					require("plugins.treesitter")
				end,
			},
			-- rainbow parens
			{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
			-- auto match html/jsx tags
			{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
			-- show context of current buffer contents
			{ "nvim-treesitter/nvim-treesitter-context", after = "nvim-treesitter" },
		})

		-----------
		-- Other --
		-----------

		-- gitsigns
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("plugins.gitsigns")
			end,
		})

		-- quickly run code
		use({
			"michaelb/sniprun",
			run = "bash ./install.sh",
			config = function()
				require("plugins.sniprun")
			end,
		})

		use({
			-- allows for interatction with databases
			{ "tpope/vim-dadbod" },
			-- provides a ui for vim-dadbod
			{
				"kristijanhusak/vim-dadbod-ui",
				after = "vim-dadbod",
				config = function()
					require("plugins.dadbod")
				end,
			},
		})
	end,
})
