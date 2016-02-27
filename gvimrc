set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

nnoremap <C-l> :let @+=expand("%:p")<cr><C-z>

" on windows we haven't set the theme yet
if has("win32") || has ("win16")
    set background=dark
    colorscheme hybrid
    let g:airline_theme = "hybrid"
endif

set lines=40 columns=120
