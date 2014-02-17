#!/bin/sh

git config --global alias.vshow 'show --no-color'
git config --global alias.vdiff 'diff --no-color'
git config --global alias.edit '!e() { s="$(git rev-parse --show-toplevel 2>/dev/null)"; [[ -z $s ]] && s=GVIM; '`
                               `'[[ -n $1 ]] && '`
                               `'{ cd "${GIT_PREFIX:-.}"; exec gvim -n --servername $s --remote-tab-silent "$@" & } || '`
                               `'exec gvim -n --servername $s & }; e'
git config --global pager.vshow 'gvim -R -M -f -'
git config --global pager.vdiff 'gvim -R -M -f -'
git config --global core.editor 'gvim -f'
