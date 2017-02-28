" load without vimrc: vi -u NONE filename
" reload vimrc: :source $MYVIMRC
" see what vimrc is being used: :echo $MYVIMRC

"set tags=.tags " let it know that ctags output file is actually in .tags

filetype plugin indent on " Automatically detect file types

noremap <F5> :set number!<CR><ESC> " show line numbers
noremap <F6> :set list!<CR>        " show lineendings

syntax on

set ignorecase " ignore case
set smartcase  " unless a capital is typed
set hlsearch   " highlight matching string
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR> " clear highlighting with space
set incsearch  " searches as you type
set showmatch  " show matching bracets
set hidden " When a buffer is brought to foreground, remember undo history and marks
set lazyredraw " Don't redraw when we don't have to
set scrolloff=3 " Start scrolling three lines before horizontal border of window
set sidescrolloff=3 " Start scrolling three columns before vertical border of window
set title " Show the filename in the window titlebar

set noerrorbells " turn off sound on errors
set novisualbell " turn off that damn flashing screen on errors
autocmd! GUIEnter * set vb t_vb= " turn of bell in MacVim

set ai " auto indent
set si " smart indent
set wildmenu " turn on command line completion
"set columns=80 " open the window with 80 columns
"set cindent " this one removes indent when commenting a line ?????
set smartindent
set autoindent
set ruler " show ruler

set tabstop=4 " # of spaces that a <Tab> uses
set shiftwidth=4 " # of spaces used for (auto)indent
" set softtabstop=4 " # mixes spaces and tab in insert mode so that things stay lined up
set expandtab " use spaces instead of inserting \t when <Tab> is used

colorscheme murphy
if (has("gui_running"))
	set colorcolumn=80
    colorscheme morning
    "highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
    "set guifont=Bitstream\ Vera\ Sans\ Mono\ 9 " font
endif

" set K to perldoc -f while on that keyword
set keywordprg=perldoc\ -f

" CTRL-A = select all
noremap <C-A> gggH<C-O>G

" CTRL-X = Cut
vnoremap <C-X> "+x

" CTRL-C = Copy
vnoremap <C-C> "+y

" CTRL-V = Paste
map <C-V>      "+gP

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q> <C-V>

" VIM Plugin - vim-plug (https://github.com/junegunn/vim-plug)
"    Installation follow curl command example on the README page
"    In Vi run after adding plugins: :PlugInstall to install plugins
" Plugins can be found here: https://vimawesome.com/
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
call plug#end()

" nerd nerdtree plugin
map <C-n> :NERDTreeToggle<CR>
