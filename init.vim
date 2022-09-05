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

set mouse=a " meese

set clipboard=unnamedplus

"set autochdir " chdir to current file
" different variant to automatically chdir
"autocmd BufEnter * silent! lcd %:p:h

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

" Git branch viewer with tpope/fugitive integration
" :Flog or :Flogsplit to open it 
" g? to view bindings once open
Plug 'rbong/vim-flog'

" Read or write files using sudo
Plug 'lambdalisue/suda.vim'
" Automatically use it when target file is not readable or writable
" let g:suda_smart_edit = 1

Plug 'itchyny/lightline.vim' " status line
Plug 'vivlim/witchhazel', { 'branch': 'scratch' }
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'
Plug 'pelodelfuego/vim-swoop'
Plug 'easymotion/vim-easymotion'
Plug 'sbdchd/neoformat'
Plug 'Shougo/neco-syntax'

"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp', { 'branch': 'main' }
Plug 'hrsh7th/cmp-buffer', { 'branch': 'main' }
Plug 'hrsh7th/cmp-path', { 'branch': 'main' }
Plug 'hrsh7th/cmp-cmdline', { 'branch': 'main' }
Plug 'hrsh7th/nvim-cmp', { 'branch': 'main' }
" For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'


Plug 'gpanders/vim-oldfiles'

Plug 'folke/which-key.nvim', {'branch': 'main'}

Plug 'fabi1cazenave/termopen.vim'
let g:termopen_autoinsert = 0 " do not automatically enter insert mode when moving to terminals

if has("win32") || has ("win16")
    "Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
else
    "Plug 'wellle/tmux-complete.vim'
    "Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif

let g:mapleader = "\<Space>"
"nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>

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
      \   'cwd': '%{getcwd()}%<',
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

else
    " set theme if we aren't on windows, because there are terminals that have 256 color support...
    " on windows, defer setting this to gvimrc.

    if $COLORTERM == "truecolor"
        set termguicolors
        colorscheme witchhazel-hypercolor-viv
        let g:airline_theme = "witchhazel"
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
nnoremap <space>gs :Git<cr>
nnoremap <space>gd :Gdiff<cr>
nnoremap <space>gc :Gcommit<cr>
nnoremap <space>gp :Git push<cr>
nnoremap <space>gP :Git pull<cr>
nnoremap <space>gf :Git fetch<cr>
nnoremap <space>gh :0Glog<cr>
nnoremap <space>gl :Gclog<cr>
nnoremap <space>gB :Git blame<cr>
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

" file bindings
" yank filename
nnoremap <space>fy :let @+ = expand("%:t")<cr>:echo "yanked filename"<cr>
" yank file path
nnoremap <space>fY :let @+ = expand("%:p")<cr>:echo "yanked file path"<cr>
" new file
nnoremap <space>fn :new<cr>

" cd to current file's directory
nnoremap <space>cd :lcd %:p:h<cr>:echo "changed working directory to current file path"<cr>

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
colorscheme witchhazel-hypercolor-viv
let g:airline_theme = "witchhazel"
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
  local ts = require("telescope.builtin")
  local wk = require("which-key")
  local lsp = require("lspconfig")
  local cmp = require("cmp")

  wk.setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  wk.register({
    f = {
        name = "file",
        f = { function() ts.find_files{} end, "find file" },
        F = { "(todo: find file in path)" },
        g = { "(todo: git-tracked files?)" },
        ["/"] = { function() ts.live_grep{} end, "live grep" },
    },
    r = {
        name = "recent",
        f = { function() ts.oldfiles{} end, "files" },
        [":"] = { function() ts.command_history{} end, "commands" },
        ["/"] = { function() ts.search_history{} end, "searches" },
    },
    g = {
        name = "git",
        ["?"] = { function() ts.git_commits{} end, "fzf commits" },
        ["/"] = { function() ts.git_bcommits{} end, "fzf buffer commits" },
        b = { function() ts.git_branches{} end, "fzf branches" },
    },
    ["/"] = { function() ts.current_buffer_fuzzy_find{} end, "current buffer fzf" },
    b = { function() ts.buffers{} end, "telescope buffers" },
    [":"] = { function() ts.builtin{} end, "telescope pickers" },
  }, { prefix = "<space>" })

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- TAB to Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- suggested config from nvim-lspconfig
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  end

  lsp.nil_ls.setup{
    autostart = true,
    capabilities = capabilities
  }
  lsp.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {}
    }
  }
EOF
