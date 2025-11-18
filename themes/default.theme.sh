#!/usr/bin/env bash
# Default theme for Oh My Org

# Simple and clean prompt
# Format: [user@host:directory] $

# Color definitions
THEME_USER_COLOR="\033[0;32m"    # Green
THEME_HOST_COLOR="\033[0;34m"    # Blue
THEME_DIR_COLOR="\033[0;33m"     # Yellow
THEME_GIT_COLOR="\033[0;35m"     # Magenta
THEME_RESET="\033[0m"

# Get git branch if in a git repository
omo_git_branch() {
  if command -v git >/dev/null 2>&1; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
      echo " ($branch)"
    fi
  fi
}

# Set the prompt
if [[ -n "$ZSH_VERSION" ]]; then
  # ZSH prompt
  setopt PROMPT_SUBST
  PROMPT='%{$THEME_USER_COLOR%}%n%{$THEME_RESET%}@%{$THEME_HOST_COLOR%}%m%{$THEME_RESET%}:%{$THEME_DIR_COLOR%}%~%{$THEME_RESET%}%{$THEME_GIT_COLOR%}$(omo_git_branch)%{$THEME_RESET%} $ '
elif [[ -n "$BASH_VERSION" ]]; then
  # Bash prompt
  PS1="\[$THEME_USER_COLOR\]\u\[$THEME_RESET\]@\[$THEME_HOST_COLOR\]\h\[$THEME_RESET\]:\[$THEME_DIR_COLOR\]\w\[$THEME_RESET\]\[$THEME_GIT_COLOR\]\$(omo_git_branch)\[$THEME_RESET\] $ "
fi
