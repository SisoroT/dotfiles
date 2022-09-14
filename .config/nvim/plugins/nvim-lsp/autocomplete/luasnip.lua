local opts = { noremap = true, silent = true }

-- jump forwards
vim.api.nvim_set_keymap("i", "<C-j>", "<cmd>lua require('luasnip').jump(1)<Cr>", opts)
vim.api.nvim_set_keymap("s", "<C-j>", '<cmd>lua require("luasnip").jump(1)<Cr>', opts)
-- jump backwards
vim.api.nvim_set_keymap("i", "<C-k>", '<cmd>lua require("luasnip").jump(-1)<Cr>', opts)
vim.api.nvim_set_keymap("s", "<C-k>", '<cmd>lua require("luasnip").jump(-1)<Cr>', opts)

-- load snippets
require("luasnip.loaders.from_vscode").lazy_load()
