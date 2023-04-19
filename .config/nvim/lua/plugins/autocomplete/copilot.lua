local function map(mode, keybind, command)
	vim.keymap.set(mode, keybind, command, { noremap = true, silent = true, script = true, expr = true })
end

-- disable tab complete
vim.g.copilot_no_tab_map = true

-- change keybind for accepting suggestions
map("i", "<M-a>", "copilot#Accept()")

-- change keybind to dismiss copilot suggestions
map("i", "<M-d>", "copilot#Dismiss()")

-- change keybind for next and previous suggestions
map("i", "<M-l>", "copilot#Next()")
map("i", "<M-h>", "copilot#Previous()")
