set nocompatible              " be iMproved, required
set hidden                    " instead of closing buffers, just hide them.
filetype off                  " required

set encoding=utf-8
set list listchars=tab:→\ ,trail:·

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
set timeoutlen=500

set exrc " execute ./.nvim.lua, ./.nvimrc, ./.exrc when `:trust`ed.

set mouse=a " meese

set clipboard=unnamedplus

"set autochdir " chdir to current file
" different variant to automatically chdir
"autocmd BufEnter * silent! lcd %:p:h

" jk to leave insert mode.
inoremap jk <ESC>

" Ctrl+(jk) to get out of a terminal, allowing us to use j and k normally most
" of the time. this should be OK since we can use <C-w> regardless of mode
tnoremap <C-j><C-k> <C-\><C-n>

if has("win32") || has ("win16")
    let $VIMFILESDIR=$USERPROFILE.'/AppData/Local/nvim'
else
    let $VIMFILESDIR=$HOME.'/.nvim'
endif

let g:mapleader = "\<Space>"
"nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>

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

nnoremap <leader>M :make<cr>

" leader + w: re-hardwrap text
nnoremap <leader>w gqip

filetype on
filetype plugin on
filetype indent on

set pastetoggle=<F2>
nnoremap <leader>< :cpf<cr>
nnoremap <leader>> :cnf<cr>

" lightline config
set noshowmode " don't need redundant "-- INSERT --"

if exists('*GetTabCwd')
    delfunction GetTabCwd
endif

function! GetTabCwd(tabNum)
    return getcwd()
endfunction

set showtabline=2 " always show tabline

let g:lightline = {
            \ 'colorscheme': 'catppuccin',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'relativepath', 'modified' ], [  ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'relativepath' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ] ] },
      \ 'tab': {
      \   'active': [ 'tabnum', 'filename', 'modified' ],
      \   'inactive': [ 'tabnum', 'filename', 'modified']
      \              },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': [ [ 'cwd' ] ],
      \ },
      \ 'component': {
      \   'cwd': '%{getcwd()}%<',
      \ },
      \ 'tab_component_function': {
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': 'lightline#tab#tabnum',
      \   'cwd': 'GetTabCwd',
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \ },
      \ }

function! LightlineReadonly()
  " show "suda" in the status line if editing file via suda
  return &readonly && &filetype !=# 'help' ? 'RO' : match(expand('%:p'), '^suda://') >= 0 ? "suda" : ''
endfunction

" windows-specific settings
if has("win32") || has ("win16")
    " on windows, get a fill path from the clipboard, remove quotes, and try to
    " open it in a split
    nnoremap <space>fo :let<space>@f<space>=<space>substitute(@+,<space>"\"",<space>"",<space>'g')<cr>:sp<space><C-r>f<cr>

    " use powershell
    " https://www.reddit.com/r/neovim/comments/vpnhrl/how_do_i_make_neovim_use_powershell_for_external/iekfbez/
    set shell=powershell.exe
    set shellxquote=
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
    let &shellquote   = ''
    let &shellpipe    = '| Out-File -Encoding UTF8 %s'
    let &shellredir   = '| Out-File -Encoding UTF8 %s'
    set termguicolors " always set this on windows, and only use terminals that support it.

else
    if $COLORTERM == "truecolor"
        set termguicolors
    endif
endif

" windows-style cut,copy,paste
"nnoremap <C-v> "+gp
"inoremap <C-v> <esc>"+gpa
"nnoremap <C-x> "+d
"nnoremap <C-c> "+y
"vnoremap <C-c> "+y

if !exists('*ReloadMyConfig')
    function! ReloadMyConfig()
        source $MYVIMRC

        " https://github.com/itchyny/lightline.vim/issues/241
        call lightline#init()
        call lightline#colorscheme()
        call lightline#update()
    endfunction
endif

" make managing configs easier
nnoremap <space>ce :e $MYVIMRC<cr>
nnoremap <space>cr :call ReloadMyConfig()<cr>

" git bindings
nnoremap <space>gs :Git<cr>
nnoremap <space>gd :Gdiff<cr>
nnoremap <space>gp :Git push<cr>
nnoremap <space>gP :Git pull<cr>
nnoremap <space>gf :Git fetch<cr>
nnoremap <space>gh :0Glog<cr>
nnoremap <space>gl :Gclog<cr>
nnoremap <space>gB :Git blame<cr>
nnoremap <space>ga :Gwrite<cr>

" toggle undotree
nnoremap <space>u :UndotreeToggle<cr>

" new tab shortcut
nnoremap <space>T :tabnew<cr>

" halp (show normal mode bindings)
nnoremap <space>? :nmap<cr>

" don't use clipboard as default register, but keep it here if i change my
" mind :thinking:
" trying it again. it lagged in vsvim because something else was locking the
" clipboard (??) but maybe it'll be ok.
"set clipboard=unnamed

autocmd BufWritePre,BufRead *.pasta nnoremap <ENTER> ^"+y$<cr><C-z>

set shortmess+=I

" file bindings
" yank filename
nnoremap <space>fy :let @+ = expand("%:t")<cr>:echo "yanked filename"<cr>
" yank file path
nnoremap <space>fY :let @+ = expand("%:p")<cr>:echo "yanked file path"<cr>
" new file
nnoremap <space>fn :new<cr>

" cd to current file's directory
nnoremap <space>fcd :lcd %:p:h<cr>:echo "changed working directory to current file path"<cr>

nnoremap <C-Tab> <C-^>
nnoremap <space><Tab> <C-^>

" neotree mappings
nnoremap - :Neotree filesystem reveal=true position=current<cr>
nnoremap <space>tf :Neotree filesystem reveal=true position=left<cr>
" end neotree mappings

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
colorscheme witchhazel-hypercolor-viv
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

" transparency
" set winblend=15
" set pumblend=15

" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>

" markdown folding
let g:markdown_folding = 1
let g:markdown_enable_folding = 1
autocmd FileType markdown setlocal foldcolumn=4
set foldlevel=3 " automatically open 3 levels of folds

" quick reference for folds
" za: toggle current fold
" zr: open all of next depth, globally
" zR: open all folds, any depth
" zm: close the deepest level of folds globally
" zM: close all folds, any depth

"lua require’nvim_lsp'.rust_analyzer.setup({})

lua << EOF
GLOBAL_TRACE=false -- enable tracing for some plugins
-- begin 'lazy.nvim' package manager
-- begin bootstrap
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
    end
    vim.opt.rtp:prepend(lazypath)
-- end bootstrap

require("lazy").setup("plugins", {
    change_detection = { notify = false, },
})

-- end 'lazy.nvim' package manager

  function copy()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
      require('osc52').copy_register('+')
    end
  end

  vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
EOF
