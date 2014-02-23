#!/bin/sh

git config --global alias.vshow 'show --no-color'
git config --global alias.vdiff 'diff --no-color'
git config --global alias.vstatus '!
    cd "${GIT_PREFIX:-.}"
    git status | sed "s/^/# /" | gvim -n -c "set ft=gitcommit nomodified" -'
git config --global alias.edit '!
    e() {
        local s=GVIM
        if [[ -n $1 ]]; then
            cd "${GIT_PREFIX:-.}"
            exec gvim -n --servername $s --remote-tab-silent "$@" &
        else
            exec gvim -n --servername $s &
        fi
    }
    e'
#
git config --global alias.core-edit '!
    e() {
        if ! gvim --serverlist | grep -q ^GVIM$; then
            gvim --servername GVIM &
            sleep 1
        fi
        gvim --servername GVIM --remote-tab-wait-silent "$@"
    }
    e'
#
git config --global pager.vshow 'gvim -R -M -'
git config --global pager.vdiff 'gvim -R -M -'
git config --global core.editor 'git core-edit'
