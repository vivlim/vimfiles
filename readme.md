shitty readme for my vimconfig
==============================

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
* substitutions all have 'g' at end by default
* [surround-vim](https://github.com/tpope/vim-surround) and all that entails
* [commentary-vim](https://github.com/tpope/vim-commentary), notably 'gc' to comment the target of a motion
* shift+u to toggle undotree
