opts = { noremap = true, silent = true }

-- toggle DBUI
vim.api.nvim_set_keymap("n", "<leader>du", ":DBUIToggle<CR>", opts)
-- run entire file
vim.api.nvim_set_keymap("n", "<leader>db", ":%DB<CR>", opts)
-- run selection
vim.api.nvim_set_keymap("v", "<leader>db", ":DB<CR>", opts)

-- set database connection as global variable
vim.g.db = "mysql://sisoro:Kurisu@localhost/girrafe"
