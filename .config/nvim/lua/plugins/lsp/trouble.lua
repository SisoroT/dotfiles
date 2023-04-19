require("trouble").setup({
	-- toggle trouble view
	vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true }),
})
