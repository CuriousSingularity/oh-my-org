#!/usr/bin/env bash
# Oh My Org uninstallation script

set -e

# Colors
GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

OMO_DIR="${OMO_DIR:-$HOME/.oh-my-org}"

print_info() {
  echo -e "${BLUE}[Oh My Org]${RESET} $1"
}

print_success() {
  echo -e "${GREEN}[Oh My Org]${RESET} $1"
}

print_error() {
  echo -e "${RED}[Oh My Org]${RESET} $1"
}

# Confirm uninstallation
read -p "Are you sure you want to uninstall Oh My Org? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 0
fi

# Remove Oh My Org directory
if [[ -d "$OMO_DIR" ]]; then
  print_info "Removing Oh My Org directory..."
  rm -rf "$OMO_DIR"
  print_success "Oh My Org directory removed"
else
  print_info "Oh My Org directory not found"
fi

# Detect shell configuration file
SHELL_RC=""
if [[ -f "$HOME/.zshrc" ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ -f "$HOME/.bashrc" ]]; then
  SHELL_RC="$HOME/.bashrc"
fi

# Remove Oh My Org configuration from shell RC
if [[ -n "$SHELL_RC" ]] && [[ -f "$SHELL_RC" ]]; then
  print_info "Removing Oh My Org configuration from $SHELL_RC..."

  # Create a temporary file without Oh My Org configuration
  sed '/# Oh My Org Configuration/,/source.*oh-my-org\.sh/d' "$SHELL_RC" > "$SHELL_RC.tmp"
  mv "$SHELL_RC.tmp" "$SHELL_RC"

  print_success "Oh My Org configuration removed from $SHELL_RC"
fi

echo ""
print_success "Oh My Org uninstalled successfully!"
print_info "Please restart your terminal for changes to take effect"
echo ""
