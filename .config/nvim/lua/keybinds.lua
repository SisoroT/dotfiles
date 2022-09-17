local g = vim.g
local function map(mode, keybind, command)
	vim.keymap.set(mode, keybind, command, { noremap = true, silent = true })
end

-- map leader key to space
g.mapleader = " "
g.maplocalleader = " "

-- open terminal in split window
map("n", "<leader>ov", ":vsplit | term<CR>")
map("n", "<leader>oh", ":split | resize 20 | term<CR>")

-- rebind exit for terminal
map("t", "<C-x>", "<C-\\><C-n>")

-- make jumping between search results easier to follow
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- cursor doesn't move when joining lines
map("n", "J", "mzJ`z")

-- navigate double windows with space+vim keys while in normal mode
map("n", "<leader>h", "<C-w>h")
map("n", "<leader>j", "<C-w>j")
map("n", "<leader>k", "<C-w>k")
map("n", "<leader>l", "<C-w>l")

-- navigate double windows ctrl+vim keys
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- move the cursor left and right in insert mode without arrow keys
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

-- alternative keybind for normal mode
map({ "i", "v" }, "ii", "<Esc>")

-- move to the end of the line with space+0 in normal and visual mode
map({ "n", "v" }, "<leader>0", "$")

-- move up and down 15 lines with ctrl+j or k
map({ "n", "v" }, "<C-j>", "15j")
map({ "n", "v" }, "<C-k>", "15k")

-- clear highlighted search results
map("n", "<leader>n", ":noh<CR>")

-- move to the next/previous buffer
map("n", "<Tab>", ":bnext<CR>")
map("n", "<S-Tab>", ":bprevious<CR>")

-- resize with alt+hjkl
map("n", "<M-h>", ":vertical resize -2<CR>")
map("n", "<M-j>", ":resize -2<CR>")
map("n", "<M-k>", ":resize +2<CR>")
map("n", "<M-l>", ":vertical resize +2<CR>")

-- source shortcut
map("n", "<C-s>", ":so%<CR>")

-- close a buffer
map("n", "<leader>bd", ":bd<CR>")

-- keybind to use find and replace
map("n", "<S-s>", ":%s//gI<Left><Left><Left>")

-- move line up and down in normal and visual modes
-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map("x", "<S-j>", ":move '>+1<CR>gv=gv")
map("x", "<S-k>", ":move '<-2<CR>gv=gv")

-- use operator pending mode to visually select the whole buffer
-- e.g. dA = delete buffer ALL, yA = copy whole buffer ALL
map("o", "A", ":<C-U>normal! mzggVG<CR>`z")
map("x", "A", ":<C-U>normal! ggVG<CR>")
