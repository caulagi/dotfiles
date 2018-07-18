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
Plug 'reasonml-editor/vim-reason-plus'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'prettier/vim-prettier', {
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] }
call plug#end()

syntax enable

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
let g:airline_theme = 'minimalist'
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

function! InsertIPdb()
    let trace = expand("import ipdb; ipdb.set_trace()")
        execute "normal o".trace
endfunction
map <Leader>j :call InsertIPdb()<CR>

let g:ackprg = 'rg --vimgrep --no-heading'

" configuration for language server
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

autocmd ColorScheme janah highlight Normal ctermbg=235
colorscheme janah
