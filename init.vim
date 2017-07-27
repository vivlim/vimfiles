set nocompatible              " be iMproved, required
set hidden                    " instead of closing buffers, just hide them.
filetype off                  " required

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

" jk to leave insert mode.
inoremap jk <ESC>

" set the runtime path to include plug and initialize
call plug#begin()

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-session'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0ng/vim-hybrid'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'pelodelfuego/vim-swoop'
Plug 'easymotion/vim-easymotion'
Plug 'Shougo/neomru.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'equalsraf/neovim-gui-shim'

" Windows-only plugins
if has("win32") || has ("win16")
    Plug 'PProvost/vim-ps1'
endif

" All of your Plugins must be added before the following line
call plug#end()            " required
" Brief help
" :PlugList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugSearch foo - searches for foo; append `!` to refresh local cache
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this lineset fileformat=dos


" big history B)
set history=1000
set undolevels=1000
if has("persistent_undo")
    let myUndoDir = expand($HOME . '/vimundo')
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

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

filetype on
filetype plugin on
filetype indent on

set pastetoggle=<F2>
nnoremap <leader>< :cpf<cr>
nnoremap <leader>> :cnf<cr>

" Set unite default matcher to fuzzy
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Sort by strength of match, not source
call unite#custom#profile('files', 'filters', 'sorter_rank')

" File searching like ctrlp.vim
nnoremap <C-p> :Unite file_rec/async -start-insert<cr>
let g:unite_source_rec_async_command = [$HOME . '/vimfiles/bin/ag.exe', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']

let g:unite_source_grep_command = $HOME . '/vimfiles/bin/ag.exe'
let g:unite_source_grep_default_opts =
\ '-i --vimgrep --hidden --ignore ' .
\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

" Content searching
nnoremap <space>/ :Unite grep:.<cr>

" Buffers
nnoremap <space>b :Unite buffer -start-insert<cr>

" default unite
nnoremap <space>u :Unite<cr>

" mru
nnoremap <space>f :Unite neomru/file -start-insert<cr>
nnoremap <space>d :Unite neomru/directory -start-insert<cr>

" sessions
nnoremap <space>e :Unite session<cr>
nnoremap <space>S :UniteSessionSave<space>

" commands
nnoremap <space>; :Unite command<cr>

nnoremap <space>ss :Swoop<cr>

" airline config
let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " appear immediately, don't wait for a split to be created

" windows-specific settings
if has("win32") || has ("win16")
    " start explorer
    nnoremap <space>e :!explorer .<cr>
    " start cmd
    nnoremap <space>c :!start<cr>
else
    " set theme if we aren't on windows, because there are terminals that have 256 color support...
    " on windows, defer setting this to gvimrc.
    set t_Co=256

    let g:airline_theme = "hybrid"

    " indent guides
    " these throw an error in cmd vim so just put them here.
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1

endif

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

" git status
nnoremap <space>g :Gstatus<cr>

" toggle undotree
nnoremap <space>au :UndotreeToggle<cr>

" remap space,w to c-w
nnoremap <space>w <C-w>

" use clipboard as default register
set clipboard=unnamed

" reload the config
nnoremap <space><C-r> :so $MYVIMRC<cr>

" swap buffers very quickly
nnoremap <space><tab> :bprevious<cr>

" swap windows directionally
nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l

autocmd BufWritePre,BufRead *.pasta nnoremap <ENTER> ^"+y$<cr><C-z>

set shortmess+=I

" my custom commands
command UpdateVimConfig :e ~/vimfiles/vimrc|:Gpull|:PluginInstall|:source %
command CdCurrentFilePath :cd %:p:h

" tagbar config begin
if has("win32") || has ("win16")
    let g:tagbar_ctags_bin = $HOME . '/vimfiles/bin/ctags.exe'
endif
nnoremap <space>t :TagbarToggle<cr>

" do not sort tags by default.
let g:tagbar_sort = 0

" tagbar config end

" begin EasyMotion config
let g:EasyMotion_do_mapping = 0 " disable default map
map <space><space> <Plug>(easymotion-bd-w)
nmap <space><space> <Plug>(easymotion-overwin-w)
" end EasyMotion config

" syntax highlighting
syntax on

" theme stuff for neovim
set background=dark
colorscheme hybrid

" need to make this work in cli mode
" Guifont Consolas:h10

