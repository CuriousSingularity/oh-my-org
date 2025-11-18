#!/usr/bin/env bash
# Oh My Org installation script

set -e

# Colors
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

# Configuration
OMO_DIR="${OMO_DIR:-$HOME/.oh-my-org}"
OMO_REPO="${OMO_REPO:-https://github.com/curioussingularity/oh-my-org.git}"

print_info() {
  echo -e "${BLUE}[Oh My Org]${RESET} $1"
}

print_success() {
  echo -e "${GREEN}[Oh My Org]${RESET} $1"
}

print_error() {
  echo -e "${RED}[Oh My Org]${RESET} $1"
}

print_welcome() {
  clear
  echo -e "${BLUE}"
  cat << "EOF"
  ██████╗  ██╗  ██╗
 ██╔═══██╗ ██║  ██║
 ██║   ██║ ███████║
 ██║   ██║ ██╔══██║
 ╚██████╔╝ ██║  ██║
  ╚═════╝  ╚═╝  ╚═╝

 ███╗   ███╗ ██╗   ██╗
 ████╗ ████║ ╚██╗ ██╔╝
 ██╔████╔██║  ╚████╔╝
 ██║╚██╔╝██║   ╚██╔╝
 ██║ ╚═╝ ██║    ██║
 ╚═╝     ╚═╝    ╚═╝

  ██████╗  ██████╗   ██████╗
 ██╔═══██╗ ██╔══██╗ ██╔════╝
 ██║   ██║ ██████╔╝ ██║  ███╗
 ██║   ██║ ██╔══██╗ ██║   ██║
 ╚██████╔╝ ██║  ██║ ╚██████╔╝
  ╚═════╝  ╚═╝  ╚═╝  ╚═════╝
EOF
  echo -e "${RESET}"
  echo ""
  echo -e "${GREEN}╔════════════════════════════════════════════════╗${RESET}"
  echo -e "${GREEN}║                                                ║${RESET}"
  echo -e "${GREEN}║${RESET}  🎯 Terminal Organization Framework          ${GREEN}║${RESET}"
  echo -e "${GREEN}║${RESET}  ✨ Auto-update • Plugins • Themes           ${GREEN}║${RESET}"
  echo -e "${GREEN}║${RESET}  🐚 Works with Bash & Zsh                    ${GREEN}║${RESET}"
  echo -e "${GREEN}║                                                ║${RESET}"
  echo -e "${GREEN}╚════════════════════════════════════════════════╝${RESET}"
  echo ""
}

print_completion() {
  echo ""
  echo -e "${GREEN}╔════════════════════════════════════════════════╗${RESET}"
  echo -e "${GREEN}║                                                ║${RESET}"
  echo -e "${GREEN}║${RESET}  ${GREEN}✓${RESET} Installation Complete!                    ${GREEN}║${RESET}"
  echo -e "${GREEN}║                                                ║${RESET}"
  echo -e "${GREEN}╚════════════════════════════════════════════════╝${RESET}"
  echo ""
  echo -e "${BLUE}📋 Next Steps:${RESET}"
  echo ""
  echo -e "  ${YELLOW}1.${RESET} Restart your terminal, or run:"
  echo -e "     ${GREEN}source $SHELL_RC${RESET}"
  echo ""
  echo -e "  ${YELLOW}2.${RESET} Enable plugins (optional):"
  echo -e "     ${GREEN}export OMO_PLUGINS=(git docker)${RESET}"
  echo ""
  echo -e "  ${YELLOW}3.${RESET} Set a theme (optional):"
  echo -e "     ${GREEN}export OMO_THEME=\"default\"${RESET}"
  echo ""
  echo -e "${BLUE}📚 Configuration:${RESET}"
  echo -e "  • Main config: ${YELLOW}$SHELL_RC${RESET}"
  echo -e "  • Custom config: ${YELLOW}$OMO_DIR/custom/custom.sh${RESET}"
  echo ""
  echo -e "${BLUE}🔗 Documentation:${RESET}"
  echo -e "  ${YELLOW}https://github.com/curioussingularity/oh-my-org${RESET}"
  echo ""
  echo -e "${GREEN}Happy organizing! 🚀${RESET}"
  echo ""
}

# Show welcome screen
print_welcome

# Check if git is installed
if ! command -v git >/dev/null 2>&1; then
  print_error "Git is not installed. Please install git first."
  exit 1
fi

# Check if Oh My Org is already installed
if [[ -d "$OMO_DIR" ]]; then
  print_info "Oh My Org is already installed at $OMO_DIR"
  read -p "Do you want to reinstall? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
  fi
  rm -rf "$OMO_DIR"
fi

# Clone the repository
print_info "Cloning Oh My Org to $OMO_DIR..."
if git clone "$OMO_REPO" "$OMO_DIR"; then
  print_success "Oh My Org cloned successfully!"
else
  print_error "Failed to clone Oh My Org"
  exit 1
fi

# Create custom directories
mkdir -p "$OMO_DIR/custom/plugins"
mkdir -p "$OMO_DIR/custom/themes"

# Create custom configuration file
if [[ ! -f "$OMO_DIR/custom/custom.sh" ]]; then
  cat > "$OMO_DIR/custom/custom.sh" << 'EOF'
# Custom configuration for Oh My Org
# Add your custom shell configurations here

# Example: Custom aliases
# alias myalias="echo 'Hello from Oh My Org'"

# Example: Custom functions
# my_function() {
#   echo "Custom function"
# }
EOF
fi

# Detect shell
SHELL_RC=""
if [[ -n "$ZSH_VERSION" ]] || [[ "$SHELL" == *"zsh"* ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ -n "$BASH_VERSION" ]] || [[ "$SHELL" == *"bash"* ]]; then
  SHELL_RC="$HOME/.bashrc"
else
  print_error "Unsupported shell. Oh My Org supports bash and zsh."
  exit 1
fi

# Add Oh My Org to shell configuration
print_info "Adding Oh My Org to $SHELL_RC..."

OMO_CONFIG="
# Oh My Org Configuration
export OMO_DIR=\"$OMO_DIR\"

# Enable auto-update (set to false to disable)
export OMO_AUTO_UPDATE=true

# Update check interval in seconds (default: 86400 = 24 hours)
export OMO_UPDATE_CHECK_INTERVAL=86400

# Theme (optional)
# export OMO_THEME=\"default\"

# Plugins to load (optional)
# export OMO_PLUGINS=(git docker kubectl)

# Source Oh My Org
source \"\$OMO_DIR/oh-my-org.sh\"
"

# Check if already configured
if grep -q "Oh My Org Configuration" "$SHELL_RC" 2>/dev/null; then
  print_info "Oh My Org is already configured in $SHELL_RC"
else
  echo "$OMO_CONFIG" >> "$SHELL_RC"
  print_success "Oh My Org added to $SHELL_RC"
fi

# Show completion message
print_completion
