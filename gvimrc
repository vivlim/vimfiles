set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

nnoremap <C-l> :let @+=expand("%:p")<cr><C-z>

" set gui theme
set background=dark
colorscheme fairyfloss
let g:airline_theme = "fairyfloss"

if has("win32") || has ("win16")
    " indent guides
    " these throw an error in cmd vim so just put them here.
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1

    set gfn=ProggyCleanTT:h12:qNONANTIALIASED,Monaco:h9:qNONANTIALIASED,Consolas:h9
    "set gfn=Consolas:h9

    " get out of system32 at launch
    if getcwd() == 'C:\Windows\system32'
        cd $HOME
    endif
else
    set gfn=Dina
endif

set lines=40 columns=120
