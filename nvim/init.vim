set ai
set tabstop=4
set ic
set shiftwidth=4
set expandtab

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.local/share/nvim/plugged')


Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'nvie/vim-flake8'
Plug 'jceb/vim-orgmode'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-speeddating'
Plug 'fatih/vim-go'
Plug 'simeji/winresizer'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

call plug#end()

let &runtimepath.=',~/.config/nvim/bundle/ale'

filetype plugin indent on
syntax enable

set termguicolors
set background=dark

let g:pysmell_matcher='camel-case'
let g:rbpt_max = 16
let g:winresizer_enable = 1
let g:ale_sign_column_always = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

let mapleader=','
let maplocalleader=','

map <F2> <Esc>:1,$!xmllint --format -<CR>
map <F3> <Esc>i# -*- coding: utf-8 -*-<Esc>

set statusline=%t%m%r\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [line=%l\ of\ %L]\ [col=%v]\ \[%{fugitive#head()}]\ \[%{ALEGetStatusLine()}]
set laststatus=2

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

function! InsertLine()
    let trace = expand("import pdb; pdb.set_trace()")
        execute "normal o".trace
endfunction
map <Leader>i :call InsertLine()<CR>

let g:ackprg = 'rg --vimgrep --no-heading'
