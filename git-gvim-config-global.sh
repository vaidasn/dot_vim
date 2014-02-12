#!/bin/sh

git config --global alias.vshow 'show --no-color'
git config --global alias.vdiff 'diff --no-color'
git config --global alias.edit '!e() { [[ -n $1 ]] && { exec gvim -n --servername $(git rev-parse --show-toplevel) --remote-tab-silent "$@" & } || exec gvim -n --servername $(git rev-parse --show-toplevel) & }; e'
git config --global pager.vshow 'gvim -R -M -f -'
git config --global pager.vdiff 'gvim -R -M -f -'
git config --global core.editor 'gvim -f'
