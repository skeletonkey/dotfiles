"   Pathogen
"       Easily install plugins
"       https://github.com/tpope/vim-pathogen
"
"   ctrlp <depricated>
"       Fuzzy file search (amongst other)
"       https://github.com/kien/ctrlp.vim
"       git clone https://github.com/kien/ctrlp.vim.git bundle/ctrlp.vim
"
"   Fugitive
"       Git wrapper
"       https://github.com/tpope/vim-fugitive
"       cd ~/.vim/bundle
"       git clone git://github.com/tpope/vim-fugitive.git
"       vim -u NONE -c "helptags vim-fugitive/doc" -c q
"
"   FuzzyFinder
"       Fuzzy file search (amongst other)
"       http://www.vim.org/scripts/script.php?script_id=1984
"       Download script and follow instructions on the page.
"       Requires L9 to work.
"
"   L9
"       VI Script Library
"       http://www.vim.org/scripts/script.php?script_id=3252
"       
"   Nerdtree
"       File System Explorer
"       cd ~/.vim/bundle/
"       git clone https://github.com/scrooloose/nerdtree.git
"       :Helptags
"       :help NERD_tree.txt
"
"   Tagbar
"       easy way to browse the tags of the current file
"       https://github.com/majutsushi/tagbar
"       cd ~/.vim/bundle/
"       git clone https://github.com/majutsushi/tagbar.git
"       vim -u NONE -c "helptags tagbar/doc" -c q
"
" Old:
"   Exuberant Ctags - http://ctags.sf.net
" Checkout:
" https://github.com/scrooloose/nerdcommenter
"

" load without vimrc: vi -u NONE filename
" reload vimrc: :source $MYVIMRC
" see what vimrc is being used: :echo $MYVIMRC

noremap <F5> :set number!<CR><ESC>
noremap <F6> :set list!<CR>
noremap <F7> :Gblame<CR>
noremap <F8> :TagbarToggle<CR>
noremap <F9> :NERDTreeToggle<CR>

map <leader>ff :FufCoverageFile<CR>

syntax on

au FilterWritePre * if &diff | set t_Co=0 | endif

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

" Pathogen
execute pathogen#infect()

" Tagbar settings
autocmd VimEnter * nested :call tagbar#autoopen(1) " auto open tagbar if file is supported
let g:tagbar_left=1        " open panel on left side
let g:tagbar_width=20      " panel only 30 chars wide
let g:tagbar_sort=1        " sort alphabetically
let g:tagbar_compact=1     " remove help line at top of the window
let g:tagbar_expand=0      " expand window the width of tagbar window
let g:tagbar_singleclick=1 " use single click instead of double click
let g:tagbar_autopreview=0 " auto preview line of tag hover over
