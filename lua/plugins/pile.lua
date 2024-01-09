return {

    -- begin plugins that were configured by Plug
    -- plugin on GitHub repo
    "tpope/vim-fugitive", -- git wrapper
    -- TODO: doc

    "tpope/vim-sleuth", -- automatic shiftwidth/expandtab

    "tpope/vim-commentary", -- comments
    -- gcc - comment out a line
    -- gc - comment out target of a motion
    -- gc (in visual) - comment selection
    -- gc (operator pending) - target a comment
    -- :g/TODO/Commentary - use in a :global invocation

    -- "tpope/vim-vinegar", -- enhanced netrw
    -- Press - in any buffer to hop up to the directory listing and seek to the file you just came from. Keep bouncing to go up, up, up. Having rapid directory access available changes everything.
    -- All that annoying crap at the top is turned off, leaving you with nothing but a list of files. This is surprisingly disorienting, but ultimately very liberating. Press I to toggle until you adapt.
    -- The oddly C-biased default sort order is replaced with a sensible application of 'suffixes'.
    -- File hiding: files are not listed that match with one of the patterns in 'wildignore'.
    -- If you put let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' in your vimrc, vinegar will initialize with dot files hidden. Press gh to toggle dot file hiding.
    -- Press . on a file to pre-populate it at the end of a : command line. This is great, for example, to quickly initiate a :grep of the file or directory under the cursor. There's also !, which starts the line off with a bang. Type !chmod +x and get :!chmod +x path/to/file.
    -- Press y. to yank an absolute path for the file under the cursor.
    -- Press ~ to go home.
    -- Use Vim's built-in CTRL-^ (CTRL-6) for switching back to the previous buffer from the netrw buffer.

    "tpope/vim-obsession", -- session recording
    -- Use :Obsess (with optional file/directory name) to start recording to a session file and :Obsess! to stop and throw it away. That's it. Load a session in the usual manner: vim -S, or :source it.

    "tpope/vim-tbone", -- tmux interaction
    -- :Tmux lets you call any old tmux command (with really good tab complete).
    -- :Tyank and :Tput give you direct access to tmux buffers.
    -- :Twrite sends a chunk of text to another pane. Give an argument like windowtitle.2, top-right, or last, or let it default to the previously given argument.
    -- :Tattach lets you use a specific tmux session from outside of it.

    "tpope/vim-jdaddy", -- json manipulation and pretty printing
    -- aj provides a text object for the outermost JSON object, array, string, number, or keyword.
    -- gqaj "pretty prints" (wraps/indents/sorts keys/otherwise cleans up) the JSON construct under the cursor.
    -- gwaj takes the JSON object on the clipboard and extends it into the JSON object under the cursor.
    -- There are also ij variants that target innermost rather than outermost JSON construct.

    "tpope/vim-repeat", -- remap . so that it works with plugins
    -- "tpope/vim-surround", -- mappings to interact with *surroundings* in pairs
    -- type quickly, there's a timeout.
    -- cs"' inside of "Hello World!" changes it to 'Hello world!"
    -- cs'<q> would change that to <q>Hello world!</q>
    -- cst" would change that back to "Hello world!"
    -- ysiw] would wrap a word in square brackets (iw is a text object) "[Hello] world!"

    -- Git branch viewer with tpope/fugitive integration
    -- :Flog or :Flogsplit to open it
    -- g? to view bindings once open
    "rbong/vim-flog",

    -- Read or write files using sudo
    "lambdalisue/suda.vim",
    -- Automatically use it when target file is not readable or writable
    -- let g:suda_smart_edit = 1

    "mbbill/undotree",
    "majutsushi/tagbar",
    "sbdchd/neoformat",
    -- "Shougo/neco-syntax",

    -- "nvim-telescope/telescope-fzf-native.nvim", { 'branch': 'main', 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' } -- TODO migration

    -- For luasnip users.
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    "gpanders/vim-oldfiles",

    "ojroques/nvim-osc52",

    -- "fabi1cazenave/termopen.vim",
    -- TODO migration how to do this
    --let g:termopen_autoinsert = 0 -- do not automatically enter insert mode when moving to terminals

    -- end plugins that were configured by Plug
}
