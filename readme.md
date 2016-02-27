shitty readme for my vimconfig
==============================

1. clone this
2. git submodule init
3. git submodule update
4. start vim
5. :PluginInstall
6. restart vim & you're good to go (if you're on windows. haven't made this work on linux yet (or I did and did not update this readme))

# quick reference of special bindings
* windows-style clipboard (ctrl+x|c|v)
    * ctrl+shift+x|c to cut or copy the entire buffer
* (gvim only) ctrl+l to copy absolute path of current file, then minimize
* jk in insert mode to leave it
* <C-p> for recursive filename search
* <space>u for generic unite
* <space>; for excommands
* <space>/ to recursively grep (Unite)
* <space>b for buffers/windows/bookmarks
* <space>e to start explorer
* <space>c to start cmd
* <space>n to start NERDtree
* substitutions all have 'g' at end by default
