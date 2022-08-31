"    NVIM CONFIGURATION                  "
""""""""""""""""""""""""""""""""""""""""""
"                                        "
"    Sections:                           "
"    -> Plugins: 15                      "
"    -> General: 91                      "
"    -> Remaps: 203                      "
"    -> Plugin Settings and Remaps: 300  "
"    -> Misc: 375                        "
"                                        "
""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" native lsp
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-jdtls'
" makes it easier to install languages for lsp
Plug 'williamboman/nvim-lsp-installer'

" language server and autoformatting
Plug 'jose-elias-alvarez/null-ls.nvim'

" diagnostics
Plug 'folke/trouble.nvim'

" lsp signatures
Plug 'ray-x/lsp_signature.nvim'

" autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

" autocomplete sources
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'kristijanhusak/vim-dadbod-completion'

" icons for the autocomplete
Plug 'onsails/lspkind-nvim'

" databases
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" fuzzy file finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" file tree
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

" gitsigns
Plug 'lewis6991/gitsigns.nvim'

" quick commentary
Plug 'numToStr/Comment.nvim'

" quickly run code
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}

" auto bracket pairing
Plug 'windwp/nvim-autopairs'
" rainbow parens
Plug 'p00f/nvim-ts-rainbow'

" blankline for tabs
Plug 'lukas-reineke/indent-blankline.nvim'

" movement
Plug 'unblevable/quick-scope'
Plug 'phaazon/hop.nvim'

" sudo save
Plug 'lambdalisue/suda.vim'

" aesthetics
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()


""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""

" set colorscheme to dracula on bootup
colorscheme dracula

" enable true colors
set termguicolors

" automatically turn on relative line numbers
set nu relativenumber

" split windows open on bottom and right
set splitbelow splitright

"sets how many lines of history vim has to remember
set history=500

" enable filetype plugin
filetype plugin on
filetype indent on

" set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" shows the input at the bottom right corner
set showcmd

" hides the --INSERT under bar
set noshowmode

" set 7 lines to the cursor - when moving vertically using j/k
set so=7

" use spaces instead of tabs
set expandtab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" linebreak on 500 characters
set lbr
set tw=500

set ai "auto indent
set si "smart indent

" turn on the wild menu
set wildmenu

" always show the current position
set ruler

" height of the command bar
set cmdheight=1

" a buffer becomes hidden when it is abandoned
set hid

" configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" ignore case when searching except when using capitals
set ignorecase
set smartcase

" highlight search results and show while typing
set hlsearch
set incsearch

" show matching brackets when text indicator is over them
set showmatch
" how many tenths of a second to blink when matching brackets
set mat=2

" add a bit extra margin to the left
set foldcolumn=1

" enable syntax highlighting
syntax enable

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" use unix as the standard file type
set ffs=unix,dos,mac

" no annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" turn backup off, since most stuff is in svn, git etc. anyway...
set nobackup
set nowb
set noswapfile

" allows yanking to system clipboard
set clipboard=unnamedplus

" show dots trailing spaces and whitespace
set list
set listchars+=trail:·


""""""""""""""""""""""""""""""""""""""""""
" => Remaps
""""""""""""""""""""""""""""""""""""""""""

" sets leader key to spacebar
let mapleader = " "

" open mini file manager in a split window
nnoremap <leader>pv :wincmd v<bar> :Ex <bar><CR>
nnoremap <leader>ph :wincmd s<bar> :Ex <bar><CR>

" open terminal in split window
nnoremap <leader>ov :vsplit term://zsh<CR>
nnoremap <leader>oh :new +resize13 term://zsh<CR>
autocmd TermOpen * startinsert

" rebind exit for terminal
tnoremap <C-x> <C-\><C-n>
tnoremap <M-x> <C-\><C-n>

" make jumping between search results easier to follow
nnoremap n nzzzv
nnoremap N Nzzzv

" cursor doesn't move when joining lines
nnoremap J mzJ`z

" navigate double windows with space+vim keys while in normal mode
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" navigate double windows ctrl+vim keys
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" move the cursor in insert mode without arrow keys
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" alternative keybind for command mode
inoremap ii <Esc>
vnoremap ii <Esc>
snoremap ii <Esc>

" redo with space+r in normal mode
" nnoremap <leader>r <C-r>

" move to the end of the line with space+0 in normal and visual mode
nnoremap <leader>0 $
vnoremap <leader>0 $

" move files up and down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" move up and down 15 lines with Ctrl+J or K
nnoremap <C-j> 15j
nnoremap <C-k> 15k
vnoremap <C-j> 15j
vnoremap <C-k> 15k

" visual mode pressing * searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" clear highlighted search results
nnoremap <silent> <C-c> :noh<CR>
nnoremap <silent> <leader>n :noh<CR>

" navigate previous files with tab
nnoremap <TAB> :bnext<CR>
nnoremap <S-TAB> :bprevious<CR>

" resize with alt+hjkl
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-l> :vertical resize +2<CR>

" source shortcut
nnoremap <C-s> :so%<CR>

" close a buffer
nnoremap <leader>bd :bd<CR>

" find and replace
nnoremap S :%s//gI<Left><Left><Left>

" sort into table
vnoremap <leader>s !column --table<CR>


""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings and Remaps
""""""""""""""""""""""""""""""""""""""""""

" commentary remaps
lua require('Comment').setup()
nmap ee gcc
vmap ee gc
nmap q gcc
vmap q gc

" telescope find files
nnoremap <leader>fc :Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>
nnoremap <leader>fd :Telescope find_files find_command=rg,--ignore,--hidden,--files cwd=~/documents/<CR>
nnoremap <leader>F :Telescope find_files find_command=rg,--ignore,--hidden,--files cwd=~/.config/<CR>
" other telescope things
nnoremap <leader>fb :Telescope current_buffer_fuzzy_find sorting_strategy=ascending<CR>
nnoremap <leader>fe :Telescope file_browser hidden=true<CR>

" only open up quickscope on presses
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" toggle dbui
nnoremap <leader>du :DBUIToggle<CR>
vnoremap <leader>db :DB<CR>
let g:db = "mysql://sisoro:<password>@localhost/<database>"

" sudo save file
command! W SudaWrite

" lsp for java
augroup lsp
  au!
  au FileType java lua require('jdtls').start_or_attach({cmd = {'/home/sisoro/scripts/launch_jdtls'}})
augroup end

" built-in lsp
" source /home/sisoro/.config/nvim/plugins/nvim-lsp/lsp/lsp-config.vim
luafile /home/sisoro/.config/nvim/plugins/nvim-lsp/lsp/lsp-config.lua
luafile /home/sisoro/.config/nvim/plugins/nvim-lsp/lsp/lsp-installer.lua

" formatting
luafile /home/sisoro/.config/nvim/plugins/nvim-lsp/lsp/null-ls-config.lua

" diagnostics
luafile /home/sisoro/.config/nvim/plugins/nvim-lsp/lsp/trouble.lua

" autocomplete
luafile /home/sisoro/.config/nvim/plugins/nvim-lsp/autocomplete/cmp-config.lua
luafile /home/sisoro/.config/nvim/plugins/nvim-lsp/autocomplete/vsnip.lua

" quickly running code
luafile /home/sisoro/.config/nvim/plugins/sniprun.lua

" autopairs
luafile /home/sisoro/.config/nvim/plugins/autopairs.lua

" file explorer
luafile /home/sisoro/.config/nvim/plugins/nvim-tree.lua

" hop
luafile /home/sisoro/.config/nvim/plugins/hop.lua

" gitsigns
luafile /home/sisoro/.config/nvim/plugins/gitsigns.lua

" treesitter syntax highlighting
luafile /home/sisoro/.config/nvim/plugins/treesitter.lua

" telescope settings
luafile /home/sisoro/.config/nvim/plugins/telescope.lua

" status line
luafile /home/sisoro/.config/nvim/plugins/status-line/lualine.lua
" bufferline
luafile /home/sisoro/.config/nvim/plugins/status-line/bufferline.lua

" hex codes
lua require'colorizer'.setup()
lua require "lsp_signature".setup(cfg)


""""""""""""""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""""""""""""""

" highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank()

" delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
