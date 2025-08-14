alias reload="exec $SHELL -l"

# Visualize: Shortcuts for listing files and directories
alias lsa="ls -ah"

# Git: Shortcuts for common Git operations
alias gita="git add ."
alias gitb="git branch"
alias gitc="git commit -m"
alias gitco="git checkout"
alias gitd="git diff"
alias gitl="git log --oneline --graph --decorate"
alias gitp="git pull"
alias gits="git status"

# Search: Shortcut for fuzzy finding
alias fd="fdfind"
alias fzf="fzf -x --multi --cycle --reverse"
alias grp="grep --color=auto -Rni"

# Caution: Shortcut for forceful removal of files/directories
alias rmf="rm -rf"

# Docker: Shortcuts for managing Docker containers and images
alias dps="docker ps -a"
alias drm="docker rm \$(docker ps -a -q)"
alias drmi="docker rmi \$(docker images -f 'dangling=true' -q)"
alias drun="docker run -it --rm"
alias drmall="docker rmi \$(docker images -q)"

alias wttr="bash $HOME/.oh-my-org/src/tools/widgets/weather.sh"
