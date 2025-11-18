#!/usr/bin/env bash
# Utility functions for Oh My Dev

# Color definitions
OMD_COLOR_RESET="\033[0m"
OMD_COLOR_GREEN="\033[0;32m"
OMD_COLOR_YELLOW="\033[0;33m"
OMD_COLOR_RED="\033[0;31m"
OMD_COLOR_BLUE="\033[0;34m"

# Print formatted messages
omd_info() {
  echo -e "${OMD_COLOR_BLUE}[Oh My Dev]${OMD_COLOR_RESET} $1"
}

omd_success() {
  echo -e "${OMD_COLOR_GREEN}[Oh My Dev]${OMD_COLOR_RESET} $1"
}

omd_warning() {
  echo -e "${OMD_COLOR_YELLOW}[Oh My Dev]${OMD_COLOR_RESET} $1"
}

omd_error() {
  echo -e "${OMD_COLOR_RED}[Oh My Dev]${OMD_COLOR_RESET} $1"
}

# Check if command exists
omd_command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Get current timestamp
omd_timestamp() {
  date +%s
}

# Check if running in interactive shell
omd_is_interactive() {
  [[ $- == *i* ]]
}
