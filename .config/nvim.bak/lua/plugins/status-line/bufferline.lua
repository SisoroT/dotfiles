-- top status line for buffers
return {
	"akinsho/bufferline.nvim",

	config = function()
		require("bufferline").setup({
			options = {
				show_buffer_close_icons = false,
				show_close_icon = false,
				offsets = {
					{
						filetype = "NvimTree",
						text = "NvimTree",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		})
	end,
}
