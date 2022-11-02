" Activate syntax highlighting
syntax on
" Don't auto-create indents
filetype plugin indent on

" Backspace not limited to just inserted characters:
" (https://unix.stackexchange.com/a/307974)
set backspace=indent,eol,start

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autowrite

" Use no line numbers by default
set nonumber
highlight LineNr ctermfg=grey ctermbg=black

" Jump to search result and highlight results.
set incsearch
set hlsearch

" unicode options
set encoding=utf-8      "display file as utf-8 in terminal
set fileencoding=utf-8  "write file to disk as utf-8

" Improve visibility of hard tabs, non-breaking spaces and trailing spaces
set list listchars=tab:→·,nbsp:␣,trail:·

autocmd Filetype gitcommit setlocal tw=70
autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab
autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype scss setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype svg setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype make setlocal noexpandtab
autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype bib setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype markdown setlocal ts=2 sts=2 sw=2 expandtab tw=80
let g:tex_flavor = 'latex'
autocmd Filetype tex setlocal ts=2 sw=2 sts=2 expandtab tw=80
autocmd Filetype conf setlocal ts=2 sts=2 sw=2 expandtab

" Automatically rustfmt rust code on save
let g:rustfmt_autosave = 1

" Format python code with isort and black.
augroup format_python_code
    autocmd!
    autocmd BufWritePre *.py Isort
    autocmd BufWritePre *.py Black
    autocmd BufWritePost *.py call flake8#Flake8()
augroup end

" Setup fzf
set rtp+=/opt/homebrew/opt/fzf

" Activate syntax highlighting from https://github.com/vim-python/python-syntax
let g:python_highlight_all = 1

" vim-flake8
let g:flake8_show_quickfix=0  " use :copen and :close to open/close the error message window
let g:flake8_show_in_file=1

" Status line plugin config
set laststatus=2
set noshowmode
