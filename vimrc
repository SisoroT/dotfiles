"   VIM CONFIGURATION                    "
""""""""""""""""""""""""""""""""""""""""""
"                                        "
" Sections:                              "
"    -> Plugins: 15                      "
"    -> General: 70                      "
"    -> Remaps: 170                      "
"    -> Plugin Settings and Remaps: 212  "
"    -> Misc: 263                        "
"                                        "
""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Nerd Tree
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
"Plug 'scrooloose/nerdcommenter'

" Quick commentary
Plug 'tpope/vim-commentary'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" CoC recommended config
let g:coc_start_at_startup = 1
let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-css',
\ 'coc-ultisnips',
\ 'coc-tsserver',
\ 'coc-emmet',
\ 'coc-tag',
\ 'coc-omni',
\ 'coc-syntax',
\ 'coc-yaml',
\ 'coc-solargraph',
\ 'coc-phpls',
\ 'coc-html',
\ 'coc-tailwindcss',
\ 'coc-markdownlint',
\ 'coc-git'
\ ]

" Formatting
Plug 'prettier/vim-prettier', {
\ 'do': 'yarn install',
\ 'branch': 'release/0.x'
\ }
let g:prettier#config#parser = 'babylon'

" Marks changes to line as you make them
Plug 'dense-analysis/ale'

" Aesthetics
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""

" set colorscheme to dracula on bootup
colorscheme dracula

" Automatically turn on relative line numbers
set nu relativenumber

" Split windows open on bottom and right
set splitbelow splitright

"Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Shows the input at the bottom right corner
set showcmd

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Use spaces instead of tabs
set expandtab
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Turn on the wild menu
set wildmenu

" Always show the current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching except when using capitals
set ignorecase
set smartcase

" Highlight search results and show while typing
set hlsearch
set incsearch

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" Add a bit extra margin to the left
set foldcolumn=1

" Enable syntax highlighting
syntax enable

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


""""""""""""""""""""""""""""""""""""""""""
" => Remaps
""""""""""""""""""""""""""""""""""""""""""

" sets leader key to spacebar
let mapleader = " "

" open mini file manager in a split window
nnoremap <leader>pv :wincmd v<bar> :Ex <bar>

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

" Alternative keybind for command mode
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

" Visual mode pressing * searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>


""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings and Remaps
""""""""""""""""""""""""""""""""""""""""""

" Show hidden files in Nerd Tree
let NERDTreeShowHidden=1

" Nerd Tree remaps
nmap <leader>t :NERDTreeToggle<CR>

" Nerd Commenter toggle
" nmap <leader>e <plug>NERDCommenterToggle
" vmap <leader>e <plug>NERDCommenterToggle

" tpope commentary remaps
nmap <leader>e gcc
vmap <leader>e gc
nmap ee gcc
vmap ee gc

" air-line
let g:airline_powerline_fonts = 1 
 
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
 
" unicode symbols
let g:airline_left_sep = '»' 
let g:airline_left_sep = '▶' 
let g:airline_right_sep = '«' 
let g:airline_right_sep = '◀' 
let g:airline_symbols.linenr = '␊' 
let g:airline_symbols.linenr = '␤' 
let g:airline_symbols.linenr = '¶' 
let g:airline_symbols.branch = '⎇'  
let g:airline_symbols.paste = 'ρ' 
let g:airline_symbols.paste = 'Þ' 
let g:airline_symbols.paste = '∥' 
let g:airline_symbols.whitespace = 'Ξ' 
 
" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


""""""""""""""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""""""""""""""

" Delete trailing white space on save, useful for some filetypes
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" :W sudo saves the file
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

