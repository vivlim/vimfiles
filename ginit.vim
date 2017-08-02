Guifont! Consolas:h10
call GuiWindowMaximized(1)

function! BumpFont(diff)
    let l:font = execute("Guifont")

    let l:fsize = substitute(l:font, '^.*:h\([^:]*\).*$', '\1', '')
    let l:fsize += a:diff
    let l:guifont = substitute(l:font, ':h\([^:]*\)', ':h' . l:fsize, '')
    let l:guifont = substitute(l:guifont, '\n', '', '') " remove whitepace
    execute("Guifont! " . l:guifont)

endfunction

" bindings to resize font with ctrl plus and minus
nnoremap <C-=> :call BumpFont(1)<cr>
nnoremap <C--> :call BumpFont(-1)<cr>
