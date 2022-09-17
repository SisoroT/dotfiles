-- options for keybinds
local opts = { noremap = true, silent = true, script = true, expr = true }

-- disable tab complete
vim.g.copilot_no_tab_map = true
-- change keybind for accepting suggestions
vim.api.nvim_set_keymap("i", "<M-a>", "copilot#Accept()", opts)

-- change keybind for next and previous suggestions
vim.api.nvim_set_keymap("i", "<M-l>", "copilot#Next()", opts)
vim.api.nvim_set_keymap("i", "<M-h>", "copilot#Previous()", opts)

-- change keybind to dismiss copilot suggestions
vim.api.nvim_set_keymap("i", "<M-d>", "copilot#Dismiss()", opts)
