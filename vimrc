set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim/
call vundle#begin('$USERPROFILE/vimfiles/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'w0ng/vim-hybrid'
Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this lineset fileformat=dos

set encoding=utf-8
set list listchars=tab:→\ ,trail:·

set nocompatible
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set expandtab " never make tabs
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

" big history B)
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc,*.class

" don't save cluttery backup or swap files
set nobackup
set noswapfile

set number " show line numbers

set ttyfast

set gdefault " substitutions all have 'g' at end by default

" leader + space: drop hilights
nnoremap <leader><space> :noh<cr>

" leader + w: re-hardwrap text
nnoremap <leader>w gqip

" tab binds
nnoremap <leader>, :tabp<cr>
nnoremap <leader>. :tabn<cr>

" j and k move up and down screen lines, not file lines.
" nnoremap j gj
" nnoremap k gk

" jk to leave insert mode.
inoremap jk <ESC>

filetype on
filetype plugin on
filetype indent on

set pastetoggle=<F2>
nnoremap <leader>< :cpf<cr>
nnoremap <leader>> :cnf<cr>

" File searching like ctrlp.vim
nnoremap <C-p> :Unite file_rec/async -start-insert<cr>
let g:unite_source_rec_async_command = [$HOME . '/vimfiles/bin/ag.exe', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']

let g:unite_source_grep_command = $HOME . '/vimfiles/bin/ag.exe'
let g:unite_source_grep_default_opts =
\ '-i --vimgrep --hidden --ignore ' .
\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

" point vimproc to the dll sitting in /bin
let g:vimproc#dll_path = $USERPROFILE . '/vimfiles/bin/vimproc_win32.dll'

" Content searching
nnoremap <space>/ :Unite grep:.<cr>

" Buffers
nnoremap <space>b :Unite buffer window bookmark -start-insert<cr>

" default unite
nnoremap <space>u :Unite -start-insert<cr>

" commands
nnoremap <space>; :Unite command -start-insert<cr>

" airline config
let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " appear immediately, don't wait for a split to be created

" start explorer
nnoremap <space>e :VimProcBang explorer .<cr>
" start cmd
nnoremap <space>c :VimProcBang start<cr>

" windows-style cut,copy,paste
nnoremap <C-v> "+gp
inoremap <C-v> <esc>"+gpa
nnoremap <C-x> "+d
nnoremap <C-c> "+y
vnoremap <C-c> "+y

" full buffer cut & copy
nnoremap <C-s-x> :%d+<cr>
nnoremap <C-s-c> :%y+<cr>

" start nerdtree
nnoremap <space>n :NERDTreeToggle<cr>

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

set background=dark
colorscheme hybrid

set gfn=Consolas:h11:cANSI
