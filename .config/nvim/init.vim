"    NVIM CONFIGURATION                  "
""""""""""""""""""""""""""""""""""""""""""
"                                        "
" Sections:                              "
"    -> Plugins: 15                      "
"    -> General: 72                      "
"    -> Remaps: 185                      "
"    -> Plugin Settings and Remaps: 284  "
"    -> Misc: 354                        "
"                                        "
""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

" autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_start_at_startup = 1
let g:coc_global_extensions = [
\ 'coc-explorer',
\ 'coc-snippets',
\ 'coc-tag',
\ 'coc-omni',
\ 'coc-syntax',
\ 'coc-markdownlint',
\ 'coc-git',
\ 'coc-vimlsp',
\ 'coc-java',
\ 'coc-json',
\ 'coc-prettier',
\ 'coc-yank'
\]

" fuzzy file finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" quick commentary
Plug 'tpope/vim-commentary'

" auto bracket pairing
Plug 'jiangmiao/auto-pairs'

" marks changes to line as you make them
Plug 'dense-analysis/ale'

" movement
Plug 'unblevable/quick-scope'
Plug 'easymotion/vim-easymotion'

" sudo save
Plug 'lambdalisue/suda.vim'

" aesthetics
Plug 'luochen1990/rainbow'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'sheerun/vim-polyglot'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""

" set colorscheme to dracula on bootup
colorscheme dracula

" enable true colors
" set termguicolors

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

" show dots for tabs and trailing spaces
set list
set listchars=
set listchars+=tab:$·
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:⣿

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
nnoremap <leader>oh :split term://zsh<CR> :resize 13<CR>

" rebind exit for terminal
tnoremap <C-x> <C-\><C-n>
tnoremap <M-x> <C-\><C-n>

" make "Y" yank from cursor to end of line
nnoremap Y y$

" make jumping between search results easier to follow
nnoremap n nzzzv
nnoremap N Nzzzv

" cursor doesnt move when joining lines
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

" alternative keybind for command mde
:inoremap kj <Esc>
:inoremap ii <Esc>
:vnoremap ii <Esc>

" redo with space+r in normal mode
nnoremap <leader>r <C-r>

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
nnoremap <C-c> :noh<CR>
nnoremap <leader>c :noh<CR>

" navigate previous files with tab
nnoremap <TAB> :bprevious<CR>
nnoremap <S-TAB> :bnext<CR>

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

" tpope commentary remaps
nmap ee gcc
vmap ee gc
nmap q gcc
vmap q gc

" telescope find files
nnoremap <leader>f :Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>
nnoremap <leader>F :Telescope find_files find_command=rg,--ignore,--hidden,--files cwd=~/.config/<CR>

" only open up quickscope on presses
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" show coc explorer and close when alone
nmap <leader>e :CocCommand explorer<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" scroll through coc results using tab
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" press shift-o to expand snippets
inoremap <expr><S-o> pumvisible() ? "\<C-y>" : "\<S-o>"

" sudo save file
command! W SudaWrite

" rainbow parenthesis
let g:rainbow_active = 1

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" makes top bar look better
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

" airline symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''

" show top bar
set showtabline=2

" hides the --INSERT under bar
set noshowmode

" treesitter syntax highlighting
luafile /home/sisoro/.config/nvim/plugins/treesitter.lua

" telescope settings
luafile /home/sisoro/.config/nvim/plugins/telescope.lua

" fixes linting for c#
let g:ale_linters = { 'cs': ['OmniSharp'] }


""""""""""""""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""""""""""""""

" delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" :W sudo saves the file (currently doesn't work in neovim)
" command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

