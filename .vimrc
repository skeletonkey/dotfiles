" Vundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" cmds:
"   :PluginInstall - download and install
"   :PluginUpdate  - update all active plugins
"   :PluginClean   - remove plugins that are no longer used
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " Vundle itself
Plugin 'dense-analysis/ale'  	 " synchronous Lint Engine
Plugin 'fatih/vim-go'            " golang
Plugin 'frazrepo/vim-rainbow'    " Rainbow brackets
Plugin 'preservim/nerdtree'      " NerdTree
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdcommenter' " \ci to toggle comment
Plugin 'tpope/vim-fugitive'      " git plugin
Plugin 'mattn/vim-goimports'     " goimports
call vundle#end()

" Fuzzy Stuff
map <leader>ff :FufCoverageFile<CR>

" NERDTree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
"nnoremap <C-t> :NERDTreeToggle<CR> " collides with C-t for ctags
nnoremap <C-f> :NERDTreeFind<CR>
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" vim-rainbow
let g:rainbow_active=1

" ctags
autocmd BufWritePost *.go silent! !ctags . &

" vim-go autocomplete
au filetype go inoremap <buffer> . .<C-x><C-o>

syntax on

" indenting
set autoindent   " indent at the same level of the pervios line
set smartindent  " indent according to syntax
set showmatch    " show matching bracets
set tabstop=4    " # of spaces that a <Tab> uses
set shiftwidth=4 " # of spaces used for (auto)indenting
" set expandtab   " use spaces instead of insterting a \t when <Tab> is used


set hidden " Wehn a buffer is brought to foreground, remember undo history and marks

" window/screen
colorscheme torte
set colorcolumn=80,100 " mark columns
set lazyredraw         " Don't redraw when we don't have to
set noerrorbells       " turn off sound on errors
set novisualbell       " turn off flashing screen on errors
set number             " line numbers
set ruler              " column/line/% status info
set scrolloff=3        " Start scolling three lines before horizontal border of window
set sidescrolloff=3    " Start scrolling three columns before vertica border of window
set title              " show the filename in the window titlebar

" search
set hlsearch   " highlight mathcing string
set ignorecase " ignore case
set incsearch  " search as you type
set smartcase  " unless a capital is typed search is case insensitive
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR> " clear highlighting with space

