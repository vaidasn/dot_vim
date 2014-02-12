if has("gui_gtk2")
    set guifont=Liberation\ Mono\ 9,Monospace\ 9
elseif has("gui_win32")
    set guifont=Consolas:h11:cDEFAULT,Lucida_Console:h10:cDEFAULT
endif
if has("gui_running")
    set showtabline=2
    "Open help in new tab
    an 9999.10 &Help.&Overview<Tab><F1>	:tab help<CR>
    noremap <F1> :tab help<CR>
    inoremap <F1> <C-O>:tab help<CR>
    cnoremap <F1> <C-C>:tab help<CR>
endif
if (has("win32") || has("win64")) && !has("gui_running")
    set background=dark
endif
if has('mouse')
  set mouse=a
endif

set encoding=utf-8
"set fileencoding=utf-8

set history=100		" keep 100 lines of command line history
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching

set hlsearch
set mouse=a
set wildmenu

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

if filereadable($VIMRUNTIME . "/mswin.vim")
    source $VIMRUNTIME/mswin.vim
    "set selectmode=""
endif

" Use <Alt-/> for autocompletion
inoremap <M-/> <C-N>

autocmd FileType gitcommit,gitrebase set spell spelllang=en_us
autocmd BufEnter COMMIT_EDITMSG,ADD_EDIT.patch,addp-hunk-edit.diff,git-rebase-todo call setpos('.', [0, 1, 1, 0])
autocmd FileType java set number
if has("gui_running")
    let g:sh_fold_enabled=1
    set foldlevelstart=99
    autocmd FileType sh setlocal foldcolumn=1
endif
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \	if &omnifunc == "" |
                \		setlocal omnifunc=syntaxcomplete#Complete |
                \	endif
    function! Auto_complete_string()
        if pumvisible()
            return "\<C-n>"
        else
            return "\<C-x>\<C-o>\<C-r>=Auto_complete_opened()\<CR>"
        end
    endfunction

    function! Auto_complete_opened()
        if pumvisible()
            return "\<Down>"
        end
        return ""
    endfunction

    inoremap <expr> <Nul> Auto_complete_string()
    inoremap <expr> <C-Space> Auto_complete_string()
endif

"highlight clear SpellBad
"highlight SpellBad cterm=underline
highlight SpellBad ctermfg=black
highlight SpellCap ctermfg=white
highlight SpellRare ctermfg=black
highlight SpellLocal ctermfg=black

function! <SID>AfterBufEnter()
    if !expand("<afile>")
        let g:startinsert_on_focus = 1
    elseif !&ro
        let g:startinsert_on_focus = 0
        startinsert
    endif
endfunction
function! <SID>AfterFocusGained()
    if exists("g:startinsert_on_focus") && g:startinsert_on_focus
        startinsert
        let g:startinsert_on_focus = 0
    endif
endfunction
autocmd BufEnter * call <SID>AfterBufEnter()
autocmd FocusGained * call <SID>AfterFocusGained()
