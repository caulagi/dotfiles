set ai
set tabstop=4
set ic
set shiftwidth=4
set expandtab

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'rking/ag.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'nvie/vim-flake8'
Plugin 'jceb/vim-orgmode'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-speeddating'

call vundle#end()

filetype plugin indent on
syntax enable
set background=dark
colorscheme solarized

let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:syntastic_python_checkers=['flake8']
let g:ag_working_path_mode="r"
let g:pysmell_matcher='camel-case'

let mapleader=','
let maplocalleader=','

map <F2> <Esc>:1,$!xmllint --format -<CR>
map <F3> <Esc>i# -*- coding: utf-8 -*-<Esc>
" set statusline=%t%m%r\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [line=%l\ of\ %L]\ [col=%v]
set laststatus=2
" set modeline

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

map <C-n> :NERDTreeToggle<CR>

if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|)$|[\/]node_modules$'
