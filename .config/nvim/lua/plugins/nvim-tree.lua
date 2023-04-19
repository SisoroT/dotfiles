-- keybinds
local function on_attach(bufnr)
	local map = vim.keymap.set
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	map("n", "o", api.node.open.edit, opts("Open"))
	map("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
	map("n", "<CR>", api.tree.change_root_to_node, opts("CD"))
	map("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
	map("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
	map("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
	map("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	map("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
	map("n", "P", api.node.navigate.parent, opts("Parent Directory"))
	map("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
	map("n", "l", api.node.open.edit, opts("Open"))
	map("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	map("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
	map("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
	map("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
	map("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	map("n", "R", api.tree.reload, opts("Refresh"))
	map("n", "a", api.fs.create, opts("Create"))
	map("n", "d", api.fs.remove, opts("Delete"))
	map("n", "r", api.fs.rename, opts("Rename"))
	map("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	map("n", "x", api.fs.cut, opts("Cut"))
	map("n", "c", api.fs.copy.node, opts("Copy"))
	map("n", "p", api.fs.paste, opts("Paste"))
	map("n", "y", api.fs.copy.filename, opts("Copy Name"))
	map("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	map("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	map("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
	map("n", "]c", api.node.navigate.git.next, opts("Next Git"))
	map("n", "<BS>", api.tree.change_root_to_parent, opts("Up"))
	map("n", "s", api.node.run.system, opts("Run System"))
	map("n", "q", api.tree.close, opts("Close"))
	map("n", "g?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
	on_attach = on_attach,
	-- hijack the cursor in the tree to put it at the start of the filename
	hijack_cursor = true,
	-- show lsp diagnostics in the signcolumn
	diagnostics = {
		enable = true,
	},
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		enable = true,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd = true,
	},
	view = {
		-- width of the window, can be either a number (columns) or a string in `%`
		width = 30,
	},
})

-- launch commands
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { noremap = true, silent = true })

-- closes neovim automatically when the tree is the last **WINDOW** in the view
vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])
