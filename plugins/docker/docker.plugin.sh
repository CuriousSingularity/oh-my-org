#!/usr/bin/env bash
# Docker plugin for Oh My Org
# Provides useful docker aliases and functions

# Docker aliases
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dexec="docker exec -it"
alias dlog="docker logs"
alias dlogf="docker logs -f"
alias dstop="docker stop"
alias drm="docker rm"
alias drmi="docker rmi"

# Docker Compose aliases
alias dcup="docker-compose up"
alias dcupd="docker-compose up -d"
alias dcdown="docker-compose down"
alias dcrestart="docker-compose restart"
alias dclogs="docker-compose logs"
alias dclogsf="docker-compose logs -f"

# Docker functions
dcleanup() {
  echo "Removing stopped containers..."
  docker container prune -f
  echo "Removing unused images..."
  docker image prune -f
  echo "Removing unused volumes..."
  docker volume prune -f
  echo "Removing unused networks..."
  docker network prune -f
}

dstopall() {
  docker stop $(docker ps -q)
}

drmall() {
  docker rm $(docker ps -a -q)
}
