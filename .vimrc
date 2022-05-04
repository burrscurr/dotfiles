call plug#begin('~/.vim/plugged')
" rust syntax highlighting, formatting etc.
" https://github.com/rust-lang/rust.vim#installation
Plug 'rust-lang/rust.vim'

" python code formatting
" https://black.readthedocs.io/en/stable/integrations/editors.html#vim
Plug 'psf/black', { 'branch': 'stable' }
call plug#end()

syntax on
" Don't auto-create indents
filetype plugin indent on

" Cursor position marker in bottom bar
set ruler

" Backspace not limited to just inserted characters:
" (https://unix.stackexchange.com/a/307974)
set backspace=indent,eol,start

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autowrite

" unicode options
set encoding=utf-8      "display file as utf-8 in terminal
set fileencoding=utf-8  "write file to disk as utf-8


autocmd Filetype gitcommit setlocal tw=70
												
autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab

autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype svg setlocal ts=2 sts=2 sw=2 expandtab

autocmd Filetype sql setlocal ts=4 sw=4 sts=4 expandtab

autocmd Filetype make setlocal noexpandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab

let g:tex_flavor = 'latex'
autocmd Filetype tex setlocal ts=2 sw=2 sts=2 expandtab tw=80
autocmd Filetype bib setlocal ts=2 sw=2 sts=2 expandtab

autocmd Filetype markdown setlocal ts=2 sts=2 sw=2 expandtab tw=80

autocmd Filetype conf setlocal ts=2 sts=2 sw=2 expandtab

" Automatically rustfmt rust code on save
let g:rustfmt_autosave = 1

" Run black automatically for python files.
augroup black_on_save
    autocmd!
    autocmd BufWritePre *.py Black
augroup end
