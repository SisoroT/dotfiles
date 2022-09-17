require("hop").setup()

-- place this in one of your configuration file(s)
vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap("v", "<leader>w", "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>x", "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap("v", "<leader>x", "<cmd>lua require'hop'.hint_lines()<cr>", {})
