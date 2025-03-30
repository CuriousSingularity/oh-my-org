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

# Caution: Shortcut for forceful removal of files/directories
alias rmf="rm -rf"

# Docker: Shortcuts for managing Docker containers and images
alias dockerps="docker ps -a"
alias dockerrmidangling="docker rmi $(docker images -f "dangling=true" -q)"
alias dockerrm="docker rm $(docker ps -a -q)"
alias dockerrun="docker run -it --rm"
alias dockerrmimage="docker rmi $(docker images -q)"
