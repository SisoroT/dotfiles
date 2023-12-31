return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = {
		{ "<leader>a", "<cmd>lua require('harpoon'):list():append()<cr>" },
		-- { "<leader>v", "<cmd>lua require('harpoon.ui'):toggle_quick_menu(harpoon:list())<cr>" },
		{ "<leader>h", "<cmd>lua require('harpoon'):list():select(1)<cr>" },
		{ "<leader>j", "<cmd>lua require('harpoon'):list():select(2)<cr>" },
		{ "<leader>k", "<cmd>lua require('harpoon'):list():select(3)<cr>" },
		{ "<leader>l", "<cmd>lua require('harpoon'):list():select(4)<cr>" },
		{ "<C-S-P>", "<cmd>lua require('harpoon'):list():prev()<cr>" },
		{ "<C-S-N>", "<cmd>lua require('harpoon'):list():next()<cr>" },
	},

	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		-- vim.keymap.set("n", "<leader>a", function()
		-- 	harpoon:list():append()
		-- end)
		vim.keymap.set("n", "<leader>v", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		--
		-- vim.keymap.set("n", "<leader>h", function()
		-- 	harpoon:list():select(1)
		-- end)
		-- vim.keymap.set("n", "<leader>j", function()
		-- 	harpoon:list():select(2)
		-- end)
		-- vim.keymap.set("n", "<leader>k", function()
		-- 	harpoon:list():select(3)
		-- end)
		-- vim.keymap.set("n", "<leader>l", function()
		-- 	harpoon:list():select(4)
		-- end)
		--
		-- -- Toggle previous & next buffers stored within Harpoon list
		-- vim.keymap.set("n", "<C-S-P>", function()
		-- 	harpoon:list():prev()
		-- end)
		-- vim.keymap.set("n", "<C-S-N>", function()
		-- 	harpoon:list():next()
		-- end)
	end,
}
