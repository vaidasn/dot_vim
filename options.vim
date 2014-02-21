if has("gui_gtk2")
    set guifont=Liberation\ Mono\ 9,Monospace\ 9
elseif has("gui_win32")
    set guifont=Consolas:h11:cDEFAULT,Lucida_Console:h10:cDEFAULT
endif
if has("gui_running")
    execute "set runtimepath+=" . expand("<sfile>:p:h") . "/.eclipse.vim"
    colorscheme eclipse
    unlet did_install_default_menus
    source $VIMRUNTIME/menu.vim

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
set showbreak=∞

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
" <Ctrl-F6> switches windows
inoremap <C-F6> <C-O><C-W>p
noremap <C-F6> <C-W>p
" <Tab> increases indent and <Shit-Tab> decreases indent
inoremap <S-Tab> <C-O><<
vnoremap <S-Tab> <gv
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
nnoremap <Tab> >>
" <Ctrl-Tab> re-indents line or selection
inoremap <C-Tab> <C-O>==
vnoremap <C-Tab> =
noremap <C-Tab> ==
" Use <Alt-.> and <Alt-,> for quick list (search result) navigation
inoremap <M-,> <C-O>:cprevious<CR>
noremap <M-,> :cprevious<CR>
inoremap <M-.> <C-O>:cnext<CR>
noremap <M-.> :cnext<CR>
" Use <Ctrl-F>, <Ctrl-K>, and <F3> for searching
if has("win32")  || has("win16") || has("gui_gtk")
    inoremap <C-F> <C-O>::promptfind<CR>
    noremap <C-F> :promptfind<CR>
    vnoremap <C-F> y:promptfind <C-R>=substitute(@", "[\r\n]", '\\n', 'g')<CR><CR>
else
    inoremap <C-F> <C-O>/
    noremap <C-F> /
endif
inoremap <C-?> <C-O>/
noremap <C-?> /
inoremap <F3> <C-O>n
noremap <F3> n
inoremap <C-K> <C-O>*
noremap <C-K> *
" <Ctrl-Enter> jums to tag, <Alt-Right>/<Alt-Left> goes forwad/backward in the jump list
noremap <C-CR> <C-]>
inoremap <C-CR> <C-O><C-]>
noremap <M-Right> <C-I>
inoremap <M-Right> <C-O><C-I>
noremap <M-Left> <C-O>
inoremap <M-Left> <C-O><C-O>
" <MiddleMouse> pastes at mouse position
noremap <MiddleMouse> <LeftMouse><MiddleMouse>
inoremap <MiddleMouse> <LeftMouse><MiddleMouse>
snoremap <MiddleMouse> <LeftMouse><MiddleMouse>
xnoremap <MiddleMouse> <LeftMouse><MiddleMouse>

autocmd FileType gitcommit,gitrebase setlocal spell spelllang=en_us
autocmd FileType man setlocal tabstop=8
autocmd BufEnter COMMIT_EDITMSG,ADD_EDIT.patch,addp-hunk-edit.diff,git-rebase-todo call setpos('.', [0, 1, 1, 0])
autocmd FileType java setlocal number
if has("gui_running")
    let g:sh_fold_enabled=1
    set foldlevelstart=99
    autocmd FileType sh setlocal foldcolumn=1
endif
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \   if &omnifunc == "" |
                \       setlocal omnifunc=syntaxcomplete#Complete |
                \   endif
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

" Workaround leaving insert mode during command exection
" Fixes editing files using server with --remote* options
function! <SID>AfterInsertLeave()
    if exists("b:insert_enter_time") && b:insert_enter_time == localtime()
        set insertmode
        let b:reset_insertmode = 1
        let b:insert_enter_time = 0
    endif
endfunction
function! <SID>AfterInsertEnter()
    if exists("b:reset_insertmode") && b:reset_insertmode
        let b:reset_insertmode = 0
        set noinsertmode
        startinsert
    endif
    let b:insert_enter_time = &insertmode ? 0: localtime()
endfunction
autocmd InsertLeave * cal <SID>AfterInsertLeave()
autocmd InsertEnter * cal <SID>AfterInsertEnter()

autocmd BufReadPost,BufNewFile * if !&ro | startinsert | endif
"autocmd StdinReadPost * startinsert

" vim: set fenc=utf-8 :
