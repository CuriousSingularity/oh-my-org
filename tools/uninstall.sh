#!/usr/bin/env bash
# Oh My Dev uninstallation script

set -e

# Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

OMD_DIR="${OMD_DIR:-$HOME/.oh-my-dev}"

print_info() {
  echo -e "${BLUE}[Oh My Dev]${RESET} $1"
}

print_success() {
  echo -e "${GREEN}[Oh My Dev]${RESET} $1"
}

print_error() {
  echo -e "${RED}[Oh My Dev]${RESET} $1"
}

# Confirm uninstallation
read -p "Are you sure you want to uninstall Oh My Dev? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 0
fi

# Remove Oh My Dev directory
if [[ -d "$OMD_DIR" ]]; then
  print_info "Removing Oh My Dev directory..."
  rm -rf "$OMD_DIR"
  print_success "Oh My Dev directory removed"
else
  print_info "Oh My Dev directory not found"
fi

# Detect shell configuration file
SHELL_RC=""
if [[ -f "$HOME/.zshrc" ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ -f "$HOME/.bashrc" ]]; then
  SHELL_RC="$HOME/.bashrc"
fi

# Remove Oh My Dev configuration from shell RC
if [[ -n "$SHELL_RC" ]] && [[ -f "$SHELL_RC" ]]; then
  print_info "Removing Oh My Dev configuration from $SHELL_RC..."

  # Create a temporary file without Oh My Dev configuration
  sed '/# Oh My Dev Configuration/,/source.*oh-my-dev\.sh/d' "$SHELL_RC" > "$SHELL_RC.tmp"
  mv "$SHELL_RC.tmp" "$SHELL_RC"

  print_success "Oh My Dev configuration removed from $SHELL_RC"
fi

echo ""
print_success "Oh My Dev uninstalled successfully!"
print_info "Please restart your terminal for changes to take effect"
echo ""
