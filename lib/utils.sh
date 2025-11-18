#!/usr/bin/env bash
# Utility functions for Oh My Org

# Color definitions
OMO_COLOR_RESET="\033[0m"
OMO_COLOR_GREEN="\033[0;32m"
OMO_COLOR_YELLOW="\033[0;33m"
OMO_COLOR_RED="\033[0;31m"
OMO_COLOR_BLUE="\033[0;34m"

# Print formatted messages
omo_info() {
  echo -e "${OMO_COLOR_BLUE}[Oh My Org]${OMO_COLOR_RESET} $1"
}

omo_success() {
  echo -e "${OMO_COLOR_GREEN}[Oh My Org]${OMO_COLOR_RESET} $1"
}

omo_warning() {
  echo -e "${OMO_COLOR_YELLOW}[Oh My Org]${OMO_COLOR_RESET} $1"
}

omo_error() {
  echo -e "${OMO_COLOR_RED}[Oh My Org]${OMO_COLOR_RESET} $1"
}

# Check if command exists
omo_command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Get current timestamp
omo_timestamp() {
  date +%s
}

# Check if running in interactive shell
omo_is_interactive() {
  [[ $- == *i* ]]
}
