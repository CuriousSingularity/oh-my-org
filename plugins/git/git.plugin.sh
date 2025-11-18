#!/usr/bin/env bash
# Git plugin for Oh My Org
# Provides useful git aliases and functions

# Git aliases
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -v"
alias gc!="git commit -v --amend"
alias gca="git commit -v -a"
alias gca!="git commit -v -a --amend"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git pull"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gst="git status"
alias gsta="git stash"
alias gstp="git stash pop"
alias glog="git log --oneline --decorate --graph"
alias gloga="git log --oneline --decorate --graph --all"

# Git functions
gclean() {
  git branch --merged | grep -v "\*" | grep -v "main\|master\|develop" | xargs -n 1 git branch -d
}

gbranch() {
  git branch -a | grep -v "remotes" | sed 's/^..//'
}

gremote() {
  git branch -r | sed 's/origin\///'
}
