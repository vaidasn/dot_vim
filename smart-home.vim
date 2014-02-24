" Smart Home key
" Heavily reworked SmartHome script from
" http://vim.wikia.com/wiki/Smart_home#More_features

if exists("g:loaded_dot_vim_smart_home")
  finish
endif
let g:loaded_dot_vim_smart_home = 1

function! s:SmartHome()
    let first_nonblank = match(getline('.'), '\S') + 1
    if first_nonblank == 0
        if col('.') + 1 >= col('$')
            normal 0
        else
            normal ^
        endif
        return ''
    endif
    if col('.') == first_nonblank
        " if at first nonblank, go to start line
        normal 0
        return ''
    endif
    let current_cursor = getpos(".")
    let saved_column = current_cursor[2]
    let saved_offset = current_cursor[3]
    let not_first_pos = saved_column > 1 || saved_offset > 0
    if &wrap && not_first_pos
        let saved_winline = winline()
        let saved_wincol = wincol()
        while 1
            if current_cursor[3] > 0
                let current_cursor[3] -= 1
            elseif current_cursor[2] > 1
                let current_cursor[2] -= 1
            else
                break
            endif
            call setpos('.', current_cursor)
            if wincol() != saved_wincol
                break
            endif
        endwhile
        let do_g0 = -1
        if winline() == saved_winline
            let current_cursor[2] = 1
            let current_cursor[3] = 0
            call setpos('.', current_cursor)
            let do_g0 = winline() != saved_winline ? 1 : 0
        endif
        let current_cursor[2] = saved_column
        let current_cursor[3] = saved_offset
        call setpos('.', current_cursor)
        if do_g0 > 0
            normal g0
            return ''
        elseif do_g0 == 0
            normal ^
            return ''
        endif
    endif
    if not_first_pos
        normal hg^
        if !&wrap
            let new_cursor = getpos(".")
            if new_cursor[2] > saved_column || 
                        \   (new_cursor[2] == saved_column &&
                        \   new_cursor[3] >= saved_offset)
                normal g0
            endif
        endif
    else
        normal ^
    endif
    return ''
endfunction
noremap <silent> <Home> :call <SID>SmartHome()<CR>
inoremap <silent> <Home> <C-R>=<SID>SmartHome()<CR>
