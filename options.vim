if has("gui_gtk2")
    set showtabline=2
    set guifont=Liberation\ Mono\ 9
elseif has("gui_win32")
    set showtabline=2
    set guifont=Consolas:h11:cANSI
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

autocmd FileType gitcommit set spell spelllang=en_us
autocmd FileType java set number
"highlight clear SpellBad
"highlight SpellBad cterm=underline
highlight SpellBad ctermfg=black
highlight SpellCap ctermfg=white
highlight SpellRare ctermfg=black
highlight SpellLocal ctermfg=black

start
