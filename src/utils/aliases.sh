#!/usr/bin/env bash

# Shell management
alias reload="exec $SHELL -l"

# File listing shortcuts
alias lsa="ls -ah"

# Git shortcuts
alias gita="git add ."
alias gitb="git branch"
alias gitc="git commit -m"
alias gitco="git checkout"
alias gitd="git diff"
alias gitl="git log --oneline --graph --decorate"
alias gitp="git pull"
alias gits="git status"
alias gitr="git remote -v"

# Search tools
alias fd="fdfind"
alias fzf="fzf -x --multi --cycle --reverse"
alias grp="grep --color=auto -Rni"

# File operations (use with caution)
alias rmf="rm -rf"

# Docker shortcuts
alias dps="docker ps -a"
alias dstop="docker stop \$(docker ps -q)"
alias drun="docker run -it --rm"
alias drmall="docker rmi -f \$(docker images -q)"

# Weather widget
alias wttr="bash \$HOME/.oh-my-org/src/tools/widgets/weather.sh"
