set ai
set tabstop=4
set ic
set shiftwidth=4
set expandtab

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.local/share/nvim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'fatih/vim-go'
Plug 'jceb/vim-orgmode'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'nvie/vim-flake8'
Plug 'rust-lang/rust.vim'
Plug 'simeji/winresizer'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
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

nnoremap <c-p> :FZF<cr>
nnoremap <Leader>a :Ack!<cr>

set statusline=%t%m%r\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [line=%l\ of\ %L]\ [col=%v]\ \[%{fugitive#head()}]\ \[%{ALEGetStatusLine()}]
set laststatus=2

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

function! InsertPdb()
    let trace = expand("import pdb; pdb.set_trace()")
        execute "normal o".trace
endfunction
map <Leader>i :call InsertIPdb()<CR>
function! InsertIPdb()
    let trace = expand("import ipdb; ipdb.set_trace()")
        execute "normal o".trace
endfunction
map <Leader>j :call InsertIPdb()<CR>

let g:ackprg = 'rg --vimgrep --no-heading'
