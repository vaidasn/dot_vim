if has("gui_gtk2")
    set showtabline=2
    set guifont=Liberation\ Mono\ 9
endif
if has('mouse')
  set mouse=a
endif
set history=50		" keep 50 lines of command line history
set showcmd		" display incomplete commands
set incsearch		" do incremental searching


set hls

set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

source $VIMRUNTIME/mswin.vim
"set selectmode=""

start
