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
set timeoutlen=250

set clipboard=unnamedplus


"set autochdir " chdir to current file
" different variant to automatically chdir
autocmd BufEnter * silent! lcd %:p:h

" jk to leave insert mode.
inoremap jk <ESC>

" and terminal mode too~
tnoremap jk <C-\><C-n>

if has("win32") || has ("win16")
    let $VIMFILESDIR=$USERPROFILE.'/AppData/Local/nvim'
else
    let $VIMFILESDIR=$HOME.'/.nvim'
endif

call plug#begin(stdpath('data') . '/plugged')

" plugin on GitHub repo
Plug 'tpope/vim-fugitive' " git wrapper
  " TODO: doc

Plug 'tpope/vim-sleuth' " automatic shiftwidth/expandtab

Plug 'tpope/vim-commentary' " comments
  " gcc - comment out a line
  " gc - comment out target of a motion
  " gc (in visual) - comment selection
  " gc (operator pending) - target a comment
  " :g/TODO/Commentary - use in a :global invocation

Plug 'tpope/vim-vinegar' " enhanced netrw
  " Press - in any buffer to hop up to the directory listing and seek to the file you just came from. Keep bouncing to go up, up, up. Having rapid directory access available changes everything.
  " All that annoying crap at the top is turned off, leaving you with nothing but a list of files. This is surprisingly disorienting, but ultimately very liberating. Press I to toggle until you adapt.
  " The oddly C-biased default sort order is replaced with a sensible application of 'suffixes'.
  " File hiding: files are not listed that match with one of the patterns in 'wildignore'.
  " If you put let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' in your vimrc, vinegar will initialize with dot files hidden. Press gh to toggle dot file hiding.
  " Press . on a file to pre-populate it at the end of a : command line. This is great, for example, to quickly initiate a :grep of the file or directory under the cursor. There's also !, which starts the line off with a bang. Type !chmod +x and get :!chmod +x path/to/file.
  " Press y. to yank an absolute path for the file under the cursor.
  " Press ~ to go home.
  " Use Vim's built-in CTRL-^ (CTRL-6) for switching back to the previous buffer from the netrw buffer.

Plug 'tpope/vim-obsession' " session recording
  " Use :Obsess (with optional file/directory name) to start recording to a session file and :Obsess! to stop and throw it away. That's it. Load a session in the usual manner: vim -S, or :source it.

Plug 'tpope/vim-tbone' " tmux interaction
  " :Tmux lets you call any old tmux command (with really good tab complete).
  " :Tyank and :Tput give you direct access to tmux buffers.
  " :Twrite sends a chunk of text to another pane. Give an argument like windowtitle.2, top-right, or last, or let it default to the previously given argument.
  " :Tattach lets you use a specific tmux session from outside of it.

Plug 'tpope/vim-jdaddy' " json manipulation and pretty printing
  " aj provides a text object for the outermost JSON object, array, string, number, or keyword.
  " gqaj "pretty prints" (wraps/indents/sorts keys/otherwise cleans up) the JSON construct under the cursor.
  " gwaj takes the JSON object on the clipboard and extends it into the JSON object under the cursor.
  " There are also ij variants that target innermost rather than outermost JSON construct.

Plug 'tpope/vim-repeat' " remap . so that it works with plugins
Plug 'tpope/vim-surround' " mappings to interact with *surroundings* in pairs
" type quickly, there's a timeout.
" cs"' inside of "Hello World!" changes it to 'Hello world!'
" cs'<q> would change that to <q>Hello world!</q>
" cst" would change that back to "Hello world!"
" ysiw] would wrap a word in square brackets (iw is a text object) "[Hello] world!"

Plug 'itchyny/lightline.vim' " status line
Plug 'tssm/fairyfloss.vim' " theme i like
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'pelodelfuego/vim-swoop'
Plug 'easymotion/vim-easymotion'
Plug 'liuchengxu/vim-which-key'
Plug 'sbdchd/neoformat'
Plug 'Shougo/neco-syntax'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim',
Plug 'gpanders/vim-oldfiles'
Plug 'laher/fuzzymenu.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'fabi1cazenave/suckless.vim'
let g:suckless_tmap = 1
let g:suckless_mappings = {
\        '<M-[zxc]>'      :   'SetTilingMode("[sdf]")'    ,
\        '<M-[aswd]>'     :    'SelectWindow("[hjkl]")'   ,
\        '<M-[ASWD]>'     :      'MoveWindow("[hjkl]")'   ,
\      '<C-M-[aswd]>'     :    'ResizeWindow("[hjkl]")'   ,
\        '<M-[hjkl]>'     :    'SelectWindow("[hjkl]")'   ,
\        '<M-[HJKL]>'     :      'MoveWindow("[hjkl]")'   ,
\      '<C-M-[hjkl]>'     :    'ResizeWindow("[hjkl]")'   ,
\        '<M-[oO]>'       :    'CreateWindow("[sv]")'     ,
\        '<M-C>'          :     'CloseWindow()'           ,
\        '<M-[123456789]>':       'SelectTab([123456789])',
\        '<M-[!@#$%^&*(]>': 'MoveWindowToTab([123456789])',
\      '<C-M-[123456789]>': 'CopyWindowToTab([123456789])',
\}
set splitbelow
set splitright
Plug 'fabi1cazenave/termopen.vim'

if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
  "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  "Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

if has("win32") || has ("win16")
    "Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
else
    "Plug 'wellle/tmux-complete.vim'
    "Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif

let g:mapleader = "\<Space>"
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

" <TAB>: cycle completions.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

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

" lightline config
set noshowmode " don't need redundant "-- INSERT --"

let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ], [ 'cwd' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename',  'cwd' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ] ] },
      \ 'component': {
      \   'cwd': '%{getcwd()}%<'
      \ },
      \ }

" windows-specific settings
if has("win32") || has ("win16")
    " on windows, get a fill path from the clipboard, remove quotes, and try to
    " open it in a split
    nnoremap <space>fo :let<space>@f<space>=<space>substitute(@+,<space>"\"",<space>"",<space>'g')<cr>:sp<space><C-r>f<cr>

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
"inoremap <C-v> <esc>"+gpa
"nnoremap <C-x> "+d
"nnoremap <C-c> "+y
"vnoremap <C-c> "+y


" make managing configs easier
nnoremap <space>ce :e $MYVIMRC<cr>
nnoremap <space>cr :source $MYVIMRC<cr>

" git bindings
nnoremap <space>gs :Gstatus<cr>
nnoremap <space>gd :Gdiff<cr>
nnoremap <space>gc :Gcommit<cr>
nnoremap <space>gp :Git push<cr>
nnoremap <space>gP :Git pull<cr>
nnoremap <space>gf :Git fetch<cr>
nnoremap <space>gh :0Glog<cr>
nnoremap <space>gl :Gclog<cr>
nnoremap <space>gb :Git blame<cr>
nnoremap <space>ga :Gwrite<cr>

" toggle undotree
nnoremap <space>u :UndotreeToggle<cr>

" remap space,w to c-w
nnoremap <space>w <C-w>
nnoremap <space>h <C-w>h
nnoremap <space>j <C-w>j
nnoremap <space>k <C-w>k
nnoremap <space>l <C-w>l

" new tab shortcut
nnoremap <M-t> :tabnew<cr>

nnoremap <space>n :NERDTreeToggle<cr>
nnoremap <space>N :NERDTreeFind<cr>
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'

" halp (show normal mode bindings)
nnoremap <space>? :nmap<cr>

" don't use clipboard as default register, but keep it here if i change my
" mind :thinking:
" trying it again. it lagged in vsvim because something else was locking the
" clipboard (??) but maybe it'll be ok.
"set clipboard=unnamed

autocmd BufWritePre,BufRead *.pasta nnoremap <ENTER> ^"+y$<cr><C-z>

set shortmess+=I

" open a terminal
if has("win32") || has ("win16")
    nnoremap <space>t :call TermOpen('powershell')<cr>
else
    nnoremap <space>t :call TermOpen()<cr>
endif

" begin EasyMotion config
let g:EasyMotion_do_mapping = 0 " disable default map
map <space><space> <Plug>(easymotion-bd-w)
nmap <space><space> <Plug>(easymotion-bd-w)
" end EasyMotion config

" space b to show list of buffers
set wildcharm=<C-z>
set wildmenu

nnoremap <space>dg :Denite grep<cr>

" file bindings
" yank filename
nnoremap <space>fy :let @+ = expand("%:t")<cr>:echo "yanked filename"<cr>
" yank file path
nnoremap <space>fY :let @+ = expand("%:p")<cr>:echo "yanked file path"<cr>
" new file
nnoremap <space>fn :new<cr>

" cd to current file's directory
nnoremap <space>cd :lcd %:p:h<cr>:echo "changed working directory to current file path"<cr>

" advanced ripgrep
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --multiline --multiline-dotall --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" FZF bindings
" files (use buffer working directory)
nnoremap <space>ff :Files<cr>
" files (specify directory)
nnoremap <space>fF :Files 
" git-tracked files
nnoremap <space>fg :call fzf#run({'source': 'git ls-files', 'sink': 'e'})<cr>
" ripgrep
nnoremap <space>/ :Rg 
" commands
nnoremap <space>: :Commands<cr>
nmap <Leader>p <Plug>Fzm
" buffers
nnoremap <space>b :Buffers<cr>
" lines in open buffers
nnoremap <space>l :Lines<cr>

" recent files
nnoremap <space>rf :History<cr>
" recent commands
nnoremap <space>r: :History:<cr>
" recent searches
nnoremap <space>r/ :History/<cr>

" commits
nnoremap <space>g? :Commits<cr>
" commits for current buffer
nnoremap <space>g/ :BCommits<cr>

nnoremap <C-Tab> <C-^>
nnoremap <space><Tab> <C-^>

" previous buffer

" on windows, add 'open path in explorer'
if has("win32") || has ("win16")
    nnoremap <space>fe :silent !start explorer "%:p:h"<cr>
endif

" syntax highlighting
syntax on

" ctrl-space mapping key
let g:CtrlSpaceDefaultMappingKey = "<C-space> "

" :w!! write as sudo. https://stackoverflow.com/a/48237738
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

set background=dark
colorscheme fairyfloss
let g:airline_theme = "fairyfloss"
"set guifont=Fira\ Mono\ for\ Powerline:h14
"set guifont=CozetteVector:h24

" read local config if it exists
if filereadable(expand("~/.nvim_local.vim"))
    source ~/.nvim_local.vim
endif

if !(exists("$nvim_bigfont") && exists("$nvim_smallfont"))
    let $nvim_smallfont = "Fira_Mono_for_Powerline:h14"
    let $nvim_bigfont = "Fira_Mono_for_Powerline:h24"
endif

if !(exists("$nvim_notes_file"))
    let $nvim_notes_file = "~/nvim-scratch.txt"
endif

execute "nnoremap <space>fN :sp " . $nvim_notes_file . "<cr>"

execute "set guifont=" . $nvim_smallfont
" ctrl - and + to switch font size quickly.
nnoremap <C--> :execute "set guifont=" . $nvim_smallfont<cr>
nnoremap <C-=> :execute "set guifont=" . $nvim_bigfont<cr>

" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>

"lua require’nvim_lsp'.rust_analyzer.setup({})
