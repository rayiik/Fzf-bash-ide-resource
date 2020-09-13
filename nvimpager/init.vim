set runtimepath=/home/rayiik/.vim/
set runtimepath+=/home/rayiik/.vim/plugin/
set runtimepath+=/home/rayiik/.vim/after
set runtimepath+=/home/rayiik/.vim/bash-support/
let &packpath = &runtimepath
colorscheme calmar256-dark
map <leader> = ","
map <leader>w :w! !sudo tee %<cr>
syntax on
set number
set fo+=t
set t_Co=256
set ruler
set nocompatible
runtime AnsiEsc
set showmatch
set expandtab
set clipboard=unnamed
map <leader>wq : :wq!<CR>
map <leader>qq : :q!<CR>
set hlsearch
set hidden
set number
set colorcolumn=81
set complete=.,w,b,u,t
set wildmenu
set wildmode=list:longest,full
set spell
set completeopt=longest,menuone,preview
set magic
let mapleader = ","
set spellsuggest=fast
let g:mapleader = ","
set incsearch
set ignorecase
set background=dark
set smartcase
set foldmethod=marker
set ttyfast
set incsearch
runtime bash-support
runtime fzf
runtime man
set writeany
set modifiable
setglobal modifiable
