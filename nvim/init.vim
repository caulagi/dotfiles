set ai
set tabstop=4
set ic
set shiftwidth=4
set expandtab

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'rust-lang/rust.vim'
Plugin 'nvie/vim-flake8'
Plugin 'jceb/vim-orgmode'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-speeddating'
Plugin 'fatih/vim-go'
Plugin 'simeji/winresizer'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'

call vundle#end()

let &runtimepath.=',~/.config/nvim/bundle/ale'

filetype plugin indent on
syntax enable
set background=dark

let g:pysmell_matcher='camel-case'
let g:rbpt_max = 16
let g:winresizer_enable = 1
let g:ale_sign_column_always = 1

let mapleader=','
let maplocalleader=','

map <F2> <Esc>:1,$!xmllint --format -<CR>
map <F3> <Esc>i# -*- coding: utf-8 -*-<Esc>

set statusline=%t%m%r\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [line=%l\ of\ %L]\ [col=%v]\ \[%{fugitive#head()}]
set laststatus=2

au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

function! InsertLine()
    let trace = expand("import pdb; pdb.set_trace()")
        execute "normal o".trace
endfunction
map <Leader>i :call InsertLine()<CR>

let g:ackprg = 'rg --vimgrep --no-heading'
