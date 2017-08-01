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

set autochdir " change directory to match the open file

" jk to leave insert mode.
inoremap jk <ESC>

" set the runtime path to include plug and initialize
call plug#begin()

" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neomru.vim'
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
Plug 'equalsraf/neovim-gui-shim'
Plug 'morhetz/gruvbox'
Plug 'Shougo/deoplete.nvim' " async completion
Plug 'leafgarland/typescript-vim'
Plug 'mhartington/nvim-typescript'

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

" enable deoplete at startup
let g:deoplete#enable_at_startup = 1

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

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
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
" Sort by strength of match, not source
"call unite#custom#profile('files', 'filters', 'sorter_rank')

" Begin Denite config
if exists("*denite#custom#var")
    " Use pt for file_rec
    call denite#custom#var('file_rec', 'command',
    \ ['pt', '--follow', '--nocolor', '--nogroup',
    \  (has('win32') ? '-g:' : '-g='), ''])

    " Pt command on grep source
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
            \ ['--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

    " C-P and C-N for switching candidates
    " Change mappings.
    call denite#custom#map(
            \ 'insert',
            \ '<C-n>',
            \ '<denite:move_to_next_line>',
            \ 'noremap'
            \)
    call denite#custom#map(
            \ 'insert',
            \ '<C-p>',
            \ '<denite:move_to_previous_line>',
            \ 'noremap'
            \)
    call denite#custom#map(
            \ 'insert',
            \ '<C-g>',
            \ '<denite:leave_mode>',
            \ 'noremap'
            \)
    " change working directory
    call denite#custom#map(
            \ 'insert',
            \ '<C-h>',
            \ '<denite:change_path>',
            \ 'noremap'
            \)
endif

" End denite config
"
" Content searching
nnoremap <space>/ :Denite grep:.<cr>

" Buffer manipulation
nnoremap <space>bd :bd<cr>

" undo tree
nnoremap <space>u :UndotreeToggle<cr>

" mru
nnoremap <space>fr :Denite file_mru<cr>

" Recursive file search
nnoremap <space>ff :Denite file_rec<cr>

" Buffer and MRU search
nnoremap <space>bb :Denite buffer file_mru<cr>

" commands
nnoremap <space>; :Denite command<cr>

" swoop
nnoremap <space>ss :Denite line<cr>

" resume
nnoremap <space>hl :Denite -resume<cr>

" airline config
let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " appear immediately, don't wait for a split to be created

" windows-specific settings
if has("win32") || has ("win16")
    " start explorer
    nnoremap <space>e :exe "!explorer " . shellescape(expand('%:p:h'))<cr>
    " start cmd
    nnoremap <space>c :exe '!start /D"' . shellescape(expand('%:p:h')) . '" cmd'<cr>
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

" show mappings
nnoremap <space>? :map <lt>space><cr>
nnoremap <leader>? :map <lt>leader><cr>

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

" use clipboard as default register
set clipboard=unnamed

" reload the config
nnoremap <space><C-r> :so $MYVIMRC<cr>

" window management
" remap space,w to c-w
nnoremap <space>w <C-w>
" maximize window
nnoremap <space>wm <C-w>o

" swap buffers very quickly
nnoremap <space><tab> :bprevious<cr>
nnoremap <space><S-tab> :bnext<cr>

" swap windows directionally
nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l

" vertical split
nnoremap <space>w/ :vsplit<cr>

" horizontal split
nnoremap <space>w- :sp<cr>

" make splits happen below and right so the focus is where I expect
set splitbelow
set splitright

" end window management

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
silent! colorscheme gruvbox

" need to make this work in cli mode
" Guifont Consolas:h10

