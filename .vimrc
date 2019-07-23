""double-quotes are comments for the .vimrc file
set nocompatible
set nocp
set backspace=indent,eol,start
set t_Co=8
set t_Sb=m
set t_Sf=m

""pathogen plugin manager
execute pathogen#infect()

"" ColorScheme
let g:solarized_termcolors=256 "Terminal-only mode
colorscheme solarized


"" enable syntax highlighting
syntax enable
syntax on
filetype plugin indent on

"" enable filetype detection
" necessary for Taglist
filetype on


"" incsearch plugin
set hlsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"" Remapping Escape to <j><k> sequence, to reduce hand movement
inoremap jk <ESC>
