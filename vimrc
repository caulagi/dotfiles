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
Plugin 'rking/ag.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'nvie/vim-flake8'
Plugin 'jceb/vim-orgmode'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-speeddating'
Plugin 'fatih/vim-go'
Plugin 'simeji/winresizer'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-commentary'

call vundle#end()

let &runtimepath.=',~/.vim/bundle/ale'

filetype plugin indent on
syntax enable
set background=dark

let g:ag_working_path_mode="r"
let g:pysmell_matcher='camel-case'
let g:rbpt_max = 16
let g:winresizer_enable = 1

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linters = {
  \   'python': ['flake8'],
\}
let g:ale_sign_column_always = 1

let mapleader=','
let maplocalleader=','

map <F2> <Esc>:1,$!xmllint --format -<CR>
map <F3> <Esc>i# -*- coding: utf-8 -*-<Esc>
set statusline=%t%m%r\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [line=%l\ of\ %L]\ [col=%v]\ \[%{fugitive#head()}]
set laststatus=2

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

map <C-n> :NERDTreeToggle<CR>

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|)$|[\/]node_modules$'

function! InsertLine()
    let trace = expand("import pdb; pdb.set_trace()")
        execute "normal o".trace
endfunction
map <Leader>i :call InsertLine()<CR>
