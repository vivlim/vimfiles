outdated readme for my vimconfig
==============================
this needs to be updated for my recent neovim config, but isn't yet. sorry, future me!

1. clone this (on linux, clone to .vim instead of vimfiles)
2. git submodule init
3. git submodule update
4. start vim
5. :PluginInstall
6. (linux only. prebuilt dll in the git repo for windows vim x86) :VimProcInstall
7. restart vim & you're good to go (if you're on windows. haven't made this work on linux yet (or I did and did not update this readme))

# quick reference of special bindings & behavior
* windows-style clipboard (ctrl+x|c|v)
    * ctrl+shift+x|c to cut or copy the entire buffer
* (gvim only) ctrl+l to copy absolute path of current file, then minimize
* jk in insert mode to leave it
* Ctrl-p for recursive filename search
* space, u for generic unite
* space, ; for excommands
* space, / to recursively grep (Unite)
* space, b for buffers/windows/bookmarks
* space, e to start explorer
* space, c to start cmd
* space, n to start NERDtree
* space, g to show git status (using fugitive-vim, only works inside of a git repo.)
* space, t to toggle tag tree
* space, e to see saved sessions (capital S to save current session)
* space, s to swoop
* substitutions all have 'g' at end by default
* [surround-vim](https://github.com/tpope/vim-surround) and all that entails
* [commentary-vim](https://github.com/tpope/vim-commentary), notably 'gc' to comment the target of a motion
* shift+u to toggle undotree
* (gvim only, in a file with the extension .pasta) enter to copy the current line to the windows clipboard & minimize
* Add custom command UpdateVimConfig which will pull this stuff to the machine you run it on.

# neovim-remote
`pip3 install --user neovim-remote`

then set the environment variable `NVIM_LISTEN_ADDRESS` to something like:
* `\\.\pipe\nvim-remote` on windows
* `/tmp/nvim-remote` on others
