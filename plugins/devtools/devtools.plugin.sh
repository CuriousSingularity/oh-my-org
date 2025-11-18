#!/usr/bin/env bash
# DevTools plugin for Oh My Dev
# Provides organized installation of developer tools and utilities
#
# USAGE EXAMPLES:
#
# 1. Check installation status of all tools:
#    $ devtools_status
#    or
#    $ dev-status
#
# 2. Install all tools at once:
#    $ devtools_install_all
#    or
#    $ dev-install-all
#
# 3. Install by category:
#    $ devtools_install_essentials    # Core dev tools (git, vim, tmux, etc.)
#    $ devtools_install_system         # System monitoring (htop, nvtop, sensors)
#    $ devtools_install_shell          # Shell enhancements (zsh, powerline)
#    $ devtools_install_modern         # Modern CLI tools (lsd, fd-find)
#    $ devtools_install_network        # Network utilities (speedtest, net-tools)
#
# 4. Update all installed tools:
#    $ devtools_update
#    or
#    $ dev-update
#
# 5. Run post-install configuration:
#    $ devtools_configure
#
# 6. Quick setup workflow:
#    $ devtools_install_all     # Install everything
#    $ devtools_configure       # Configure kernel modules, etc.
#    $ devtools_status          # Verify installation

# Color codes for output
DEVTOOLS_GREEN="\033[0;32m"
DEVTOOLS_RED="\033[0;31m"
DEVTOOLS_BLUE="\033[0;34m"
DEVTOOLS_YELLOW="\033[0;33m"
DEVTOOLS_RESET="\033[0m"

# Check if a command exists
_devtools_command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if snap package is installed
_devtools_snap_installed() {
  snap list "$1" >/dev/null 2>&1
}

# Print status of a tool
_devtools_print_status() {
  local tool=$1
  local check_type=${2:-command}  # command or snap

  if [[ "$check_type" == "snap" ]]; then
    if _devtools_snap_installed "$tool"; then
      echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} $tool"
      return 0
    fi
  else
    if _devtools_command_exists "$tool"; then
      echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} $tool"
      return 0
    fi
  fi

  echo -e "  ${DEVTOOLS_RED}✗${DEVTOOLS_RESET} $tool"
  return 1
}

# Install essential development tools
# Essential tools: git, tmux, vim, ssh, curl, wget, tree, unzip
devtools_install_essentials() {
  echo -e "${DEVTOOLS_BLUE}Installing essential development tools...${DEVTOOLS_RESET}"

  sudo apt update
  sudo apt install -y \
    git \
    tmux \
    vim \
    ssh \
    curl \
    wget \
    tree \
    unzip

  echo -e "${DEVTOOLS_GREEN}✓ Essential tools installed${DEVTOOLS_RESET}"
}

# Install system monitoring and management tools
# System tools: htop, nvtop, neofetch, lm-sensors, cpufrequtils, fontconfig
devtools_install_system() {
  echo -e "${DEVTOOLS_BLUE}Installing system monitoring tools...${DEVTOOLS_RESET}"

  sudo apt update
  sudo apt install -y \
    htop \
    nvtop \
    neofetch \
    lm-sensors \
    cpufrequtils \
    fontconfig

  echo -e "${DEVTOOLS_GREEN}✓ System tools installed${DEVTOOLS_RESET}"
}

# Install shell enhancements
# Shell tools: zsh, powerline, fonts-powerline
devtools_install_shell() {
  echo -e "${DEVTOOLS_BLUE}Installing shell enhancement tools...${DEVTOOLS_RESET}"

  sudo apt update
  sudo apt install -y \
    zsh \
    powerline \
    fonts-powerline

  echo -e "${DEVTOOLS_GREEN}✓ Shell tools installed${DEVTOOLS_RESET}"
  echo ""
  echo -e "${DEVTOOLS_YELLOW}Note: To set zsh as default shell, run:${DEVTOOLS_RESET}"
  echo -e "  ${DEVTOOLS_BLUE}chsh -s \$(which zsh)${DEVTOOLS_RESET}"
}

# Install modern CLI tool replacements
# Modern tools: lsd, fd-find
devtools_install_modern() {
  echo -e "${DEVTOOLS_BLUE}Installing modern CLI tools...${DEVTOOLS_RESET}"

  # Install fd-find via apt
  sudo apt update
  sudo apt install -y fd-find

  # Install lsd via snap
  if _devtools_command_exists snap; then
    sudo snap install lsd
  else
    echo -e "${DEVTOOLS_YELLOW}⚠ snap not available, skipping lsd${DEVTOOLS_RESET}"
  fi

  echo -e "${DEVTOOLS_GREEN}✓ Modern CLI tools installed${DEVTOOLS_RESET}"
}

# Install network utilities
# Network tools: speedtest-cli, net-tools
devtools_install_network() {
  echo -e "${DEVTOOLS_BLUE}Installing network utilities...${DEVTOOLS_RESET}"

  sudo apt update
  sudo apt install -y \
    speedtest-cli \
    net-tools

  echo -e "${DEVTOOLS_GREEN}✓ Network tools installed${DEVTOOLS_RESET}"
}

# Install all developer tools
devtools_install_all() {
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_BLUE}  Installing All Developer Tools${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo ""

  devtools_install_essentials
  echo ""
  devtools_install_system
  echo ""
  devtools_install_shell
  echo ""
  devtools_install_modern
  echo ""
  devtools_install_network

  echo ""
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_GREEN}✓ All tools installed successfully${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo ""
  echo -e "${DEVTOOLS_YELLOW}Next steps:${DEVTOOLS_RESET}"
  echo -e "  1. Run post-install configuration: ${DEVTOOLS_BLUE}devtools_configure${DEVTOOLS_RESET}"
  echo -e "  2. Check installation status: ${DEVTOOLS_BLUE}devtools_status${DEVTOOLS_RESET}"
}

# Update all installed tools
devtools_update() {
  echo -e "${DEVTOOLS_BLUE}Updating all installed tools...${DEVTOOLS_RESET}"

  # Update apt packages
  sudo apt update
  sudo apt upgrade -y

  # Update snap packages
  if _devtools_command_exists snap; then
    sudo snap refresh
  fi

  echo -e "${DEVTOOLS_GREEN}✓ All tools updated${DEVTOOLS_RESET}"
}

# Post-install configuration (kernel modules, etc.)
devtools_configure() {
  echo -e "${DEVTOOLS_BLUE}Running post-install configuration...${DEVTOOLS_RESET}"
  echo ""

  # Load drivetemp kernel module for drive temperature monitoring
  echo -e "${DEVTOOLS_BLUE}Configuring drive temperature monitoring...${DEVTOOLS_RESET}"

  if sudo modprobe drivetemp 2>/dev/null; then
    echo -e "${DEVTOOLS_GREEN}✓ drivetemp module loaded${DEVTOOLS_RESET}"

    # Add to /etc/modules for persistence
    if ! grep -q "^drivetemp$" /etc/modules 2>/dev/null; then
      echo "drivetemp" | sudo tee -a /etc/modules >/dev/null
      echo -e "${DEVTOOLS_GREEN}✓ drivetemp added to /etc/modules (loads on boot)${DEVTOOLS_RESET}"
    else
      echo -e "${DEVTOOLS_YELLOW}  drivetemp already in /etc/modules${DEVTOOLS_RESET}"
    fi
  else
    echo -e "${DEVTOOLS_YELLOW}⚠ Could not load drivetemp module (may not be supported)${DEVTOOLS_RESET}"
  fi

  echo ""

  # Detect sensors
  if _devtools_command_exists sensors-detect; then
    echo -e "${DEVTOOLS_BLUE}Running sensors detection...${DEVTOOLS_RESET}"
    echo -e "${DEVTOOLS_YELLOW}Note: This will ask questions. Press ENTER to accept defaults.${DEVTOOLS_RESET}"
    echo ""
    sudo sensors-detect
  fi

  echo ""
  echo -e "${DEVTOOLS_GREEN}✓ Configuration complete${DEVTOOLS_RESET}"
}

# Show installation status of all tools
devtools_status() {
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_BLUE}  Developer Tools Status${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo ""

  # Essential Tools
  echo -e "${DEVTOOLS_YELLOW}Essential Development Tools:${DEVTOOLS_RESET}"
  _devtools_print_status "git"
  _devtools_print_status "tmux"
  _devtools_print_status "vim"
  _devtools_print_status "ssh"
  _devtools_print_status "curl"
  _devtools_print_status "wget"
  _devtools_print_status "tree"
  _devtools_print_status "unzip"
  echo ""

  # System Tools
  echo -e "${DEVTOOLS_YELLOW}System Monitoring Tools:${DEVTOOLS_RESET}"
  _devtools_print_status "htop"
  _devtools_print_status "nvtop"
  _devtools_print_status "neofetch"
  _devtools_print_status "sensors"
  _devtools_print_status "cpufreq-info"
  echo ""

  # Shell Tools
  echo -e "${DEVTOOLS_YELLOW}Shell Enhancement Tools:${DEVTOOLS_RESET}"
  _devtools_print_status "zsh"
  _devtools_print_status "powerline"
  echo ""

  # Modern CLI Tools
  echo -e "${DEVTOOLS_YELLOW}Modern CLI Tools:${DEVTOOLS_RESET}"
  _devtools_print_status "lsd" "snap"
  _devtools_print_status "fdfind"  # fd-find is installed as fdfind
  echo ""

  # Network Tools
  echo -e "${DEVTOOLS_YELLOW}Network Utilities:${DEVTOOLS_RESET}"
  _devtools_print_status "speedtest"
  _devtools_print_status "ifconfig"
  echo ""

  # Configuration Status
  echo -e "${DEVTOOLS_YELLOW}Configuration Status:${DEVTOOLS_RESET}"

  # Check if drivetemp module is loaded
  if lsmod | grep -q "^drivetemp"; then
    echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} drivetemp module (loaded)"
  else
    echo -e "  ${DEVTOOLS_RED}✗${DEVTOOLS_RESET} drivetemp module (not loaded)"
  fi

  # Check if drivetemp is in /etc/modules
  if grep -q "^drivetemp$" /etc/modules 2>/dev/null; then
    echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} drivetemp in /etc/modules (auto-load on boot)"
  else
    echo -e "  ${DEVTOOLS_RED}✗${DEVTOOLS_RESET} drivetemp in /etc/modules (won't auto-load)"
  fi

  echo ""
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo ""
  echo -e "${DEVTOOLS_YELLOW}Quick actions:${DEVTOOLS_RESET}"
  echo -e "  Install missing tools: ${DEVTOOLS_BLUE}devtools_install_all${DEVTOOLS_RESET}"
  echo -e "  Run configuration:     ${DEVTOOLS_BLUE}devtools_configure${DEVTOOLS_RESET}"
  echo -e "  Update all tools:      ${DEVTOOLS_BLUE}devtools_update${DEVTOOLS_RESET}"
  echo ""
}

# Useful aliases
alias dev-install-essentials='devtools_install_essentials'
alias dev-install-system='devtools_install_system'
alias dev-install-shell='devtools_install_shell'
alias dev-install-modern='devtools_install_modern'
alias dev-install-network='devtools_install_network'
alias dev-install-all='devtools_install_all'
alias dev-update='devtools_update'
alias dev-configure='devtools_configure'
alias dev-status='devtools_status'
