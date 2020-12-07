colorscheme calmar256-dark
color  calmar256-dark
map <leader> = ","
let mapleader = ","
let g:mapleader = ","
map <leader> ","
" use python3
if exists('py2') && has('python')
elseif has('python3')
endif

filetype on                  " required
" When started as "evim", evim.vim will already have done these settings.

if v:progname =~? "evim"
  finish
endif
mapclear "<F9>"
imapclear "<F9>"
nmapclear "<F9>"
mapclear "<F9>"
noremap "<F9><NoWait>" : "<Cmd>:!export ATHAME_ENABLED=0<CR>"
inoremap "<C-Space>" : "<ESC>"
inoremap "<C-Space>" "<ESC>"
map <leader>w :w! !sudo tee %<CR>
map <leader>mm :set modifiable<CR>
map <leader>mm :set modifiable<CR>
map <leader>fzc :Commands<CR>
map <leader>fzh :Helptags<CR>
map <leader>ff :set filetype=bash<CR>
map <leader>ft :set fo-=t<CR>
map <leader>fo :set fo+=t<CR>
map <leader>fm :mode<CR>
map <leader>f1 :set tw=120<CR>:redraw<cr>
map <leader>f2 :set tw=65<CR>:redraw<cr>
map <leader>f3 :set tw=30<CR>:redraw<cr>
map <leader><F1> <esc>vap%"paragraph
map <leader><F13> <esc>"paragraph p
" sessions
noremap <F1> :mksession! .vim.session <CR>
noremap <F2> :source .vim.session <CR>
noremap <F3> :! rm .vim.session <CR>
map <ESC> <ESC> :set iminsert=0<CR>
map <leader>wq : :wq!<CR>
map <leader>qq : :q!<CR>
map <leader>aq : '<Cmd>:!assw<CR>'

" Bail out if something that ran earlier, e.g. a system wide vimrc, does not
" want Vim to use these default values.
runtime! AnsiEsc.vim

let g:BASH_GlobalTemplateFile = '/home/rayiik/.vim/bash-support/templates/Templates'
if exists('skip_defaults_vim')
  finish
endif

" file type and syntax highliting on
let b:current_syntax = 'bash'
let g:colorizer_auto_filetype='bash,sh,vim'
command ColorHighlight syntax
let g:colirizer_x11_names = 1
let g:colirizer_syntax = 1

filetype plugin on
filetype indent on
syntax on

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.

if &compatible
  set nocompatible
endif

" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.

silent! while 0
  set nocompatible
silent! endwhile

" whitespaces

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=cyan guibg=cyan
autocmd InsertLeave * redraw!
match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd BufWritePre * :%s/\s\+$//e
"packloadall
let g:Bash_AlsoBash = [ '*.SlackBuild' , 'rc.*' ]
" color scheme

" for autoread to auto load

au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w
set shell=bash
set number
set fo+=t
set t_Co=256
set shellpipe
set nocursorline
set shellredir
set title
set guifont=Hack:h16:i
set bs=2
set noautoindent
set ruler
set shortmess=aoOTI
set nocompatible
set showmode
set splitbelow
set nomodeline
set showcmd
set showmatch
set tabstop=8
set shiftwidth=4
set noexpandtab
set cinoptions=(0,m1,:1
set tw=120
set lazyredraw
set formatoptions=tcqro2
set smartindent
set laststatus=2
set nomodeline
set clipboard=unnamed
set softtabstop=2
set showtabline=1
set sidescroll=5
set scrolloff=4
set hlsearch
set incsearch

set wrap
set linebreak
set statusline+=[%{&fo}]
syntax on
set number
set fo+=t
set t_Co=256
set ruler
runtime AnsiEsc
set showmatch
set expandtab
set clipboard=unnamed
map <leader>wq : :wq!<CR>
map <leader>qq : :q!<CR>
set hlsearch
set hidden
set number
set colorcolumn=140
set complete=.,w,b,u,t
set wildmenu
set wildmode=list:longest,full
set completeopt=longest,menuone,preview
set ignorecase
" set foldtext
set smartcase
set foldmethod=marker
set ttyfast
set history=10000
set hidden
set colorcolumn=120
set number
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview
set noswapfile
set nrformats-=octal
set foldlevelstart=0
set wildmenu
set wildmode=list:longest,full
set statusline+=%{getcwd()}\/\%f%=%-14.(%l,%c%V%)\ %P
set autoread
" set conceallevel=2
set concealcursor=vin
set spellsuggest=fast,
set magic
set spell

set autowrite
set background=dark

" backup
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

" make directories automatically if they don't already exist
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" close brackets
"map <Leader>( <insert>()<Esc>i
"imap <C-M-<> <insert><><Esc>i
"nmap <Leader>{ <insert>{}<Esc>i
"nmap <Leader>[ <insert>[]<Esc>i
"nmap <Leader>" <insert>""<Esc>i
"nmap <Leader>' <insert>''<Esc>i
"nmap <Leader><C-`> <insert>``<Esc>i

" cursorline
au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline

" clang stuff
let g:clang_library_path='/usr/lib/'
let g:clang_user_options='|| exit 0'
let g:clang_complete_auto = 0
let g:clang_compelte_macros=1
let g:clang_complete_copen = 0
let g:clang_debug = 1
let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_snippets_engine='clang_complete'
let g:clang_auto_select = 1
let g:clang_use_library = 1
let g:clang_complete_optional_args_in_snippets = 1

" jedi
let g:jedi#completions_enabled = 1
let g:jedi#force_py_version = 3

" possible to timeout.
if has('reltime')
  set incsearch
endif
"
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=*
set signcolumn=yes
let syntastic_agregate_errors = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_sh_checkers = ["checkbashisms", "shellcheck", "sh"]
let g:syntastic_bash_checkers = ["checkbashisms", "shellcheck", "sh"]
let g:syntastic_check_on_open = 0
let g:syntastic_shell = "/bin/bash"
let b:sytnastic_shell = "/bin/bash"
let g:syntastic_check_on_wq = 0

let g:syntastic_always_enable_highlighting = 1
let g:syntastic_mode = 2
let b:syntastic_mode = 2
let g:syntastic_mode_map = {
     \ "mode": "active",
      \ "active_filetypes": ["bash", "sh", "vim", "**"],
      \ "passive_filetypes": ["bash", "sh", "vim", "html"]}
nnoremap <Leader><esc> :Errors<CR>
nnoremap <Leader>\sc, :SyntasticCheck<CR>
vnoremap <Leader>,o :lopen<CR>
nnoremap <Leader>,c :lclose<CR>


highlight SyntasticErrorSign guifg=white guibg=black
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin on
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
     autocmd bufreadpost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup end
" endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".

nnoremap    <buffer>   ''   ciW''<Esc>P
nnoremap    <buffer>   ""   ciW""<Esc>P
"

nnoremap  <buffer>  <silent>  <LocalLeader>t1   a[ -  ]<Left><Left><Left>
inoremap  <buffer>  <silent>  <LocalLeader>t1    [ -  ]<Left><Left><Left>
"
nnoremap  <buffer>  <silent>  <LocalLeader>t2   a[  -  ]<Left><Left><Left><Left><Left>
inoremap  <buffer>  <silent>  <LocalLeader>t2    [  -  ]<Left><Left><Left><Left><Left>


" Use Vim defaults instead of 100% vi compatibility
" Avoid side-effects when nocompatible has already been set.
if &compatible
  set nocompatible
endif

set backspace=indent,eol,start
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set suffixes-=.h
set suffixes-=.obj

" Move temporary files to a secure location to protect against CVE-2017-1000382
if exists('$XDG_CACHE_HOME')
  let &g:directory=$XDG_CACHE_HOME
else
  let &g:directory=$HOME . '/.cache'
endif
let &g:undodir=&g:directory . '/vim/undo//'
let &g:backupdir=&g:directory . '/vim/backup//'
let &g:directory.='/vim/swap//'
" Create directories if they doesn't exist
if ! isdirectory(expand(&g:directory))
  silent! call mkdir(expand(&g:directory), 'p', 0700)
endif
if ! isdirectory(expand(&g:backupdir))
  silent! call mkdir(expand(&g:backupdir), 'p', 0700)
endif
if ! isdirectory(expand(&g:undodir))
  silent! call mkdir(expand(&g:undodir), 'p', 0700)
endif

" Make shift-insert work like in Xterm
if has('gui_running')
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif
