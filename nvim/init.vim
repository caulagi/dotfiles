set autoindent
set tabstop=4
set ignorecase
set shiftwidth=4
set expandtab
set undofile

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
Plug 'dense-analysis/ale'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'prettier/vim-prettier', {
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] }
Plug 'airblade/vim-rooter'
call plug#end()

syntax enable

au FileType yaml set shiftwidth=2 tabstop=2
au FileType json set shiftwidth=2 tabstop=2

let g:pysmell_matcher='camel-case'
let g:rbpt_max = 16
let g:winresizer_enable = 1
let g:strip_whitespace_on_save = 1
let g:strip_whitespace_confirm = 0

" LINTING and language server
let g:ale_fixers = {
\   'python': ['black'],
\   'javascript': ['prettier'],
\}
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\}
let g:ale_sign_column_always = 1

" STATUS line
let g:airline_powerline_fonts = 1
let g:airline_theme = 'minimalist'
let g:airline#extensions#default#layout = [
  \ [ 'y', 'error', 'warning', 'c' ],
  \ [ 'x', 'a', 'b', 'z' ]
  \ ]
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = "✘ "
let g:airline#extensions#ale#warning_symbol = "∆ "
let g:airline#extensions#ale#show_line_numbers = 0
let g:airline_skip_empty_sections = 1
set laststatus=2  " always show status line

let mapleader=','
let maplocalleader=','

nmap <F2> <Esc>:1,$!xmllint --format -<CR>
nmap <F3> <Esc>i# -*- coding: utf-8 -*-<Esc>

nnoremap <c-p> :FZF<cr>
nnoremap <Leader>a :Ack!<cr>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-K> <Plug>(ale_fix)


au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"

" format json files as <leader>jq
if executable('jq')
    command! -nargs=? Jq call s:Jq(<f-args>)
    function! s:Jq(...)
        let l:filetype = &filetype
        if 'json' != l:filetype
            echo "This File Is No Json File"
            return
        endif
        if 0 == a:0
            let l:arg = "."
        else
            let l:arg=a:1
        endif
        execute "%! jq \"" . l:arg . "\""
    endfunction
    nmap <leader>jq :Jq<CR>
    nmap <leader>jqs :Jq -S<CR>
endif

function! InsertIPdb()
    let trace = expand("import ipdb; ipdb.set_trace()")
        execute "normal o".trace
endfunction
map <Leader>j :call InsertIPdb()<CR>

let g:ackprg = 'rg --vimgrep --no-heading'

" configuration for language server
set hidden

autocmd BufNewFile,BufRead *.tf set ft=terraform syntax=terraform
autocmd BufNewFile,BufRead *.tfvars set ft=terraform syntax=terraform
autocmd BufNewFile,BufRead *.hcl set ft=terraform syntax=terraform

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ 'python': ['pyls'],
    \ 'javascript': ['javascript-typescript-langserver'],
    \ 'yaml': ['yaml-language-server', '--stdio'],
    \ 'terraform': ['terraform-ls', 'serve'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

autocmd ColorScheme janah highlight Normal ctermbg=235
colorscheme janah
