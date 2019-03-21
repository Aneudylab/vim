let &runtimepath .=",~/.vim"

execute pathogen#infect()

let mapleader= ","
" Setting color scheme
colorscheme Tomorrow-Night
set guifont=DejaVu\ Sans\ Mono:h10
filetype on
filetype indent on
syntax on

" Some settings
set nocompatible
set number
set relativenumber
set modelines=0

" Indenting settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Sanity settings
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
"set undofile

" Searching and replacing
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Lines
set nowrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" escape chars
set list
set listchars=eol:¬
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Mapings
nnoremap <leader>evrc :vsplit $MYVIMRC<cr>
nnoremap <leader>svrc :source $MYVIMRC<cr>
nnoremap <leader>emrc :vsplit ~/.vim/vimrc<cr>
nnoremap <leader>smrc :source ~/.vim/vimrc<cr>

" Splitting
set splitright
set splitbelow

" Course
nnoremap <up> <nop>
nnoremap <left> <nop>
nnoremap <down> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <left> <nop>
inoremap <down> <nop>
inoremap <right> <nop>

inoremap jk <esc>
inoremap <esc> <nop>

