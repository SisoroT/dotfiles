local o = vim.o
local g = vim.g

-- function to help mapping keybinds
local function map(mode, keybind, command)
	vim.keymap.set(mode, keybind, command, { noremap = true, silent = true })
end

-- Mappings
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<C-n>", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<C-p>", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "<S-H>", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

vim.diagnostic.config({
	virtual_text = false,
	float = { focusable = false },
})

-- show diagnostics on hover
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })]])

-- function to toggle cursor hold for diagnostics floats
function _G.toggle_floats()
	if o.updatetime == 200 then
		o.updatetime = 10000
	else
		o.updatetime = 200
	end
end

-- function to toggle diagnostics
g.diagnostics_visible = true
function _G.toggle_diagnostics()
	if g.diagnostics_visible then
		g.diagnostics_visible = false
		vim.diagnostic.disable()
	else
		g.diagnostics_visible = true
		vim.diagnostic.enable()
	end
end

-- toggle diagnostics and floats
map("n", "<leader>dd", ":call v:lua.toggle_diagnostics()<CR>")
map("n", "<leader>df", ":call v:lua.toggle_floats()<CR>")
