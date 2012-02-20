call pathogen#infect()
call pathogen#helptags()

set nocompatible

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

set fileformats=unix
set fileformat=unix

" Whitespace stuff
set nowrap
" set wrapmargin=2
" set textwidth=72
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'fancy'

let mapleader = ","

let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :%s///ge<CR>

nnoremap <silent> <Leader>t :CommandT<CR>
nnoremap <silent> <Leader>b :CommandTBuffer<CR>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

set backspace=indent,eol,start

filetype plugin indent on

" Clear last search
nnoremap <Leader>/ :let @/ = ""<CR>

" Show (partial) command in the status line
set showcmd

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
