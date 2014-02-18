" Smart Home key
" Heavily based on SmartHome script from
" http://vim.wikia.com/wiki/Smart_home#More_features

function! <SID>SmartHome(cmd_prefix)
    let first_nonblank = match(getline('.'), '\S') + 1
    if first_nonblank == 0
        return a:cmd_prefix . (col('.') + 1 >= col('$') ? '0' : '^')
    endif
    if col('.') == first_nonblank
        return a:cmd_prefix . '0'  " if at first nonblank, go to start line
    endif
    let current_cursor = getpos(".")
    let saved_column = current_cursor[2]
    let saved_offset = current_cursor[3]
    let not_first_pos = saved_column > 1 || saved_offset > 0
    if &wrap
        let saved_winline = winline()
        if not_first_pos
            if saved_offset > 0
                let current_cursor[3] -= 1
            else
                let current_cursor[2] -= 1
            endif
        endif
        call setpos('.', current_cursor)
        if winline() == saved_winline
            let current_cursor[2] = 1
            let current_cursor[3] = 0
            call setpos('.', current_cursor)
            let do_g0 = winline() != saved_winline ? 1 : 0
            let current_cursor[2] = saved_column
            let current_cursor[3] = saved_offset
            call setpos('.', current_cursor)
            return a:cmd_prefix . (do_g0 ? 'g0' : '^')
        endif
    endif
    return not_first_pos ? "\<Left>" . a:cmd_prefix . 'g^' : a:cmd_prefix . '^'
endfunction
noremap <expr> <silent> <Home> <SID>SmartHome('')
inoremap <expr> <silent> <Home> <SID>SmartHome("\<C-\>\<C-O>")
