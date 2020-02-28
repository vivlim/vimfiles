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

set autochdir " chdir to current file

" jk to leave insert mode.
inoremap jk <ESC>

" and terminal mode too~
tnoremap jk <C-\><C-n>

if has("win32") || has ("win16")
    let $VIMFILESDIR=$USERPROFILE.'/AppData/Local/nvim'
else
    let $VIMFILESDIR=$HOME.'/.nvim'
endif

" set the runtime path to include Vundle and initialize
set rtp+=$VIMFILESDIR/bundle/Vundle.vim/
call vundle#begin('$VIMFILESDIR/bundle/')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tssm/fairyfloss.vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'mbbill/undotree'
Plugin 'majutsushi/tagbar'
Plugin 'pelodelfuego/vim-swoop'
Plugin 'easymotion/vim-easymotion'
Plugin 'liuchengxu/vim-which-key'

if has('nvim')
  Plugin 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/denite.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

let g:mapleader = "\<Space>"
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>

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

" airline config
let g:airline#extensions#tabline#enabled = 1
set laststatus=2 " appear immediately, don't wait for a split to be created

" windows-specific settings
if has("win32") || has ("win16")
else
    " set theme if we aren't on windows, because there are terminals that have 256 color support...
    " on windows, defer setting this to gvimrc.

    if $COLORTERM == "truecolor"
        set termguicolors
        colorscheme fairyfloss
        let g:airline_theme = "fairyfloss"
    endif
endif

" windows-style cut,copy,paste
"nnoremap <C-v> "+gp
inoremap <C-v> <esc>"+gpa
"nnoremap <C-x> "+d
"nnoremap <C-c> "+y
vnoremap <C-c> "+y

" on windows, get a fill path from the clipboard, remove quotes, and try to
" open it in a split
nnoremap <C-o> :let<space>@f<space>=<space>substitute(@+,<space>"\"",<space>"",<space>'g')<cr>:sp<space><C-r>f<cr>

" full buffer cut & copy
nnoremap <C-s-x> :%d+<cr>
nnoremap <C-s-c> :%y+<cr>

" git bindings
nnoremap <space>gs :Gstatus<cr>
nnoremap <space>gd :Gdiff<cr>
nnoremap <space>gc :Gcommit<cr>

" toggle undotree
nnoremap <space>u :UndotreeToggle<cr>

" remap space,w to c-w
nnoremap <space>w <C-w>
nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l

" halp (show normal mode bindings)
nnoremap <space>? :nmap<cr>

" don't use clipboard as default register, but keep it here if i change my
" mind :thinking:
" set clipboard=unnamed

autocmd BufWritePre,BufRead *.pasta nnoremap <ENTER> ^"+y$<cr><C-z>

set shortmess+=I

" open a terminal
if has("win32") || has ("win16")
    nnoremap <space>T :terminal powershell<cr>i
else
    nnoremap <space>T :terminal<cr>i
endif

" begin EasyMotion config
let g:EasyMotion_do_mapping = 0 " disable default map
map <space><space> <Plug>(easymotion-bd-w)
nmap <space><space> <Plug>(easymotion-overwin-w)
" end EasyMotion config

" begin denite config
" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

nnoremap <space>df :Denite file/rec<cr>
nnoremap <space>dd :Denite directory_rec<cr>
nnoremap <space>db :Denite buffer<cr>
nnoremap <space>dr :Denite file/old<cr>
nnoremap <space>dc :Denite command<cr>
nnoremap <space>dx :Denite change<cr>
nnoremap <space>dg :Denite grep<cr>
nnoremap <C-p> :Denite file/rec buffer<cr>

" Ripgrep command on grep source
if has("win32") || has ("win16")
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
            \ ['-i', '--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
endif
" end denite config

" syntax highlighting
syntax on

set background=dark
colorscheme fairyfloss
let g:airline_theme = "fairyfloss"
set guifont=Fira\ Mono\ for\ Powerline:h14
