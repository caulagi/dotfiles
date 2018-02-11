set ai
set tabstop=4
set ic
set shiftwidth=4
set expandtab

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.local/share/nvim/plugged')
Plug 'bling/vim-bufferline'
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
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
call plug#end()

syntax enable

set termguicolors
set background=dark

let g:pysmell_matcher='camel-case'
let g:rbpt_max = 16
let g:winresizer_enable = 1

let g:airline_section_error = '%{ALEGetStatusLine()}'
let g:ale_statusline_format = ['✘ %d', '∆ %d', '● ok']
let g:ale_fixers = {
\   'python': ['isort', 'autopep8'],
\}

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme = 'solarized'
let g:airline#extensions#default#layout = [
  \ [ 'y', 'z', 'error', 'c' ],
  \ [ 'x', 'a', 'b' ]
  \ ]
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#ale#enabled = 1

set laststatus=2  " always show status line

let mapleader=','
let maplocalleader=','

nmap <F2> <Esc>:1,$!xmllint --format -<CR>
nmap <F3> <Esc>i# -*- coding: utf-8 -*-<Esc>
nmap <F8> <Plug>(ale_fix)

nnoremap <c-p> :FZF<cr>
nnoremap <Leader>a :Ack!<cr>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


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

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
