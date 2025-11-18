#!/usr/bin/env bash
# Oh My Dev installation script

set -e

# Colors
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

# Configuration
OMD_DIR="${OMD_DIR:-$HOME/.oh-my-dev}"
OMD_REPO="${OMD_REPO:-https://github.com/curioussingularity/oh-my-dev.git}"

print_info() {
  echo -e "${BLUE}[Oh My Dev]${RESET} $1"
}

print_success() {
  echo -e "${GREEN}[Oh My Dev]${RESET} $1"
}

print_error() {
  echo -e "${RED}[Oh My Dev]${RESET} $1"
}

print_welcome() {
  # Clear screen only if TERM is set (not in CI environments)
  if [[ -n "$TERM" ]]; then
    clear
  fi
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

 ██████╗  ███████╗ ██╗   ██╗
 ██╔══██╗ ██╔════╝ ██║   ██║
 ██║  ██║ █████╗   ██║   ██║
 ██║  ██║ ██╔══╝   ╚██╗ ██╔╝
 ██████╔╝ ███████╗  ╚████╔╝
 ╚═════╝  ╚══════╝   ╚═══╝
EOF
  echo -e "${RESET}"
  echo ""
  echo -e "${GREEN}╔════════════════════════════════════════════════╗${RESET}"
  echo -e "${GREEN}║                                                ║${RESET}"
  echo -e "${GREEN}║${RESET}  🎯 Developer Productivity Framework         ${GREEN}║${RESET}"
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
  echo -e "     ${GREEN}export OMD_PLUGINS=(git docker uv utils claude-code)${RESET}"
  echo ""
  echo -e "  ${YELLOW}3.${RESET} Set a theme (optional):"
  echo -e "     ${GREEN}export OMD_THEME=\"default\"${RESET}"
  echo ""
  echo -e "${BLUE}📚 Configuration:${RESET}"
  echo -e "  • Main config: ${YELLOW}$SHELL_RC${RESET}"
  echo -e "  • Custom config: ${YELLOW}$OMD_DIR/custom/custom.sh${RESET}"
  echo ""
  echo -e "${BLUE}🔗 Documentation:${RESET}"
  echo -e "  ${YELLOW}https://github.com/curioussingularity/oh-my-dev${RESET}"
  echo ""
  echo -e "${GREEN}Boost your productivity! 🚀${RESET}"
  echo ""
}

# Show welcome screen
print_welcome

# Check if git is installed
if ! command -v git >/dev/null 2>&1; then
  print_error "Git is not installed. Please install git first."
  exit 1
fi

# Check if Oh My Dev is already installed
if [[ -d "$OMD_DIR" ]]; then
  print_info "Oh My Dev is already installed at $OMD_DIR"
  read -p "Do you want to reinstall? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 0
  fi
  rm -rf "$OMD_DIR"
fi

# Clone the repository
print_info "Cloning Oh My Dev to $OMD_DIR..."
if git clone "$OMD_REPO" "$OMD_DIR"; then
  print_success "Oh My Dev cloned successfully!"
else
  print_error "Failed to clone Oh My Dev"
  exit 1
fi

# Create custom directories
mkdir -p "$OMD_DIR/custom/plugins"
mkdir -p "$OMD_DIR/custom/themes"

# Create custom configuration file
if [[ ! -f "$OMD_DIR/custom/custom.sh" ]]; then
  cat > "$OMD_DIR/custom/custom.sh" << 'EOF'
# Custom configuration for Oh My Dev
# Add your custom shell configurations here

# Example: Custom aliases
# alias myalias="echo 'Hello from Oh My Dev'"

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
  print_error "Unsupported shell. Oh My Dev supports bash and zsh."
  exit 1
fi

# Add Oh My Dev to shell configuration
print_info "Adding Oh My Dev to $SHELL_RC..."

OMD_CONFIG="
# Oh My Dev Configuration
export OMD_DIR=\"$OMD_DIR\"

# Enable auto-update (set to false to disable)
export OMD_AUTO_UPDATE=true

# Update check interval in seconds (default: 86400 = 24 hours)
export OMD_UPDATE_CHECK_INTERVAL=86400

# Theme (optional)
# export OMD_THEME=\"default\"

# Plugins to load (optional)
# export OMD_PLUGINS=(git docker uv utils)

# Source Oh My Dev
source \"\$OMD_DIR/oh-my-dev.sh\"
"

# Check if already configured
if grep -q "Oh My Dev Configuration" "$SHELL_RC" 2>/dev/null; then
  print_info "Oh My Dev is already configured in $SHELL_RC"
else
  echo "$OMD_CONFIG" >> "$SHELL_RC"
  print_success "Oh My Dev added to $SHELL_RC"
fi

# Show completion message
print_completion
