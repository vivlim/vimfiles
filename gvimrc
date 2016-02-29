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

    " indent guides
    " these throw an error in cmd vim so just put them here.
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
endif

set lines=40 columns=120
