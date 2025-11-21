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
# 4. Install user-space tools (no sudo required):
#    $ devtools_install_zsh_userspace  # Install zsh from source (no sudo)
#    $ devtools_install_uv             # UV Python package manager
#    $ devtools_install_fonts          # Nerd Fonts (Meslo)
#    $ devtools_install_ohmyzsh        # Oh My Zsh with powerlevel10k
#    $ devtools_install_fzf            # Fuzzy finder
#    $ devtools_configure_vim          # Vim configuration
#    $ devtools_configure_p10k         # Powerlevel10k theme configuration
#    $ devtools_setup_shell            # Complete shell setup (all user tools)
#
# 5. Update all installed tools:
#    $ devtools_update
#    or
#    $ dev-update
#
# 6. Run post-install configuration:
#    $ devtools_configure
#
# 7. Quick setup workflow:
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

  # Check if sudo is available
  if ! _devtools_command_exists sudo; then
    echo -e "${DEVTOOLS_YELLOW}⚠ sudo not available${DEVTOOLS_RESET}"
    echo ""
    echo -e "${DEVTOOLS_YELLOW}Consider user-level zsh installation instead:${DEVTOOLS_RESET}"
    echo -e "  ${DEVTOOLS_BLUE}devtools_install_zsh_userspace${DEVTOOLS_RESET}"
    echo ""
    return 1
  fi

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

# ============================================================================
# User-space Installation Functions (no sudo required)
# ============================================================================

# Install zsh from source (user-level, no sudo required)
# Useful when system doesn't have zsh or you need a newer version without sudo
devtools_install_zsh_userspace() {
  echo -e "${DEVTOOLS_BLUE}Installing zsh from source (user-level)...${DEVTOOLS_RESET}"

  local install_dir="$HOME/.local/zsh"
  local temp_dir="/tmp/zsh_build_$$"

  # Check if system zsh already exists
  if _devtools_command_exists zsh; then
    local system_zsh
    local zsh_version
    system_zsh=$(command -v zsh)
    zsh_version=$(zsh --version 2>/dev/null | awk '{print $2}')
    echo -e "${DEVTOOLS_YELLOW}System zsh already installed: $system_zsh (version $zsh_version)${DEVTOOLS_RESET}"
    read -r -p "Install user-level zsh anyway? (y/N) " -n 1
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "Skipping user-level zsh installation"
      return 0
    fi
  fi

  # Check if already installed
  if [[ -d "$install_dir" ]] && [[ -x "$install_dir/bin/zsh" ]]; then
    echo -e "${DEVTOOLS_YELLOW}User-level zsh already installed at $install_dir${DEVTOOLS_RESET}"
    read -r -p "Reinstall? (y/N) " -n 1
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "Skipping reinstallation"
      return 0
    fi
    rm -rf "$install_dir"
  fi

  mkdir -p "$install_dir"
  mkdir -p "$temp_dir"
  cd "$temp_dir" || return 1

  # Install ncurses
  echo -e "${DEVTOOLS_BLUE}Installing ncurses...${DEVTOOLS_RESET}"
  export CXXFLAGS=" -fPIC" CFLAGS=" -fPIC"
  export CPPFLAGS="-I${install_dir}/include"
  export LDFLAGS="-L${install_dir}/lib"

  if ! wget -q --show-progress https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.2.tar.gz; then
    echo -e "${DEVTOOLS_RED}✗ Failed to download ncurses${DEVTOOLS_RESET}" >&2
    cd - >/dev/null || true
    rm -rf "$temp_dir"
    return 1
  fi

  tar -xzf ncurses-6.2.tar.gz
  cd ncurses-6.2 || return 1

  if ! ./configure --prefix="$install_dir" --enable-shared >/dev/null 2>&1; then
    echo -e "${DEVTOOLS_RED}✗ Failed to configure ncurses${DEVTOOLS_RESET}" >&2
    cd - >/dev/null || true
    rm -rf "$temp_dir"
    return 1
  fi

  if ! (make -j"$(nproc 2>/dev/null || echo 2)" >/dev/null 2>&1 && make install >/dev/null 2>&1); then
    echo -e "${DEVTOOLS_RED}✗ Failed to build ncurses${DEVTOOLS_RESET}" >&2
    cd - >/dev/null || true
    rm -rf "$temp_dir"
    return 1
  fi

  echo -e "${DEVTOOLS_GREEN}✓ ncurses installed${DEVTOOLS_RESET}"
  cd "$temp_dir" || return 1

  # Install zsh
  echo -e "${DEVTOOLS_BLUE}Installing zsh...${DEVTOOLS_RESET}"
  if ! wget -q --show-progress -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download; then
    echo -e "${DEVTOOLS_RED}✗ Failed to download zsh${DEVTOOLS_RESET}" >&2
    cd - >/dev/null || true
    rm -rf "$temp_dir"
    return 1
  fi

  mkdir zsh
  unxz zsh.tar.xz
  tar -xf zsh.tar -C zsh --strip-components 1
  cd zsh || return 1

  if ! ./configure --prefix="$install_dir" >/dev/null 2>&1; then
    echo -e "${DEVTOOLS_RED}✗ Failed to configure zsh${DEVTOOLS_RESET}" >&2
    cd - >/dev/null || true
    rm -rf "$temp_dir"
    return 1
  fi

  if ! (make -j"$(nproc 2>/dev/null || echo 2)" >/dev/null 2>&1 && make install >/dev/null 2>&1); then
    echo -e "${DEVTOOLS_RED}✗ Failed to build zsh${DEVTOOLS_RESET}" >&2
    cd - >/dev/null || true
    rm -rf "$temp_dir"
    return 1
  fi

  echo -e "${DEVTOOLS_GREEN}✓ zsh installed${DEVTOOLS_RESET}"

  # Cleanup
  cd - >/dev/null || true
  rm -rf "$temp_dir"

  # Update shell configuration
  local shell_rc=""
  if [[ -f "$HOME/.zshrc" ]]; then
    shell_rc="$HOME/.zshrc"
  else
    shell_rc="$HOME/.bashrc"
  fi

  # Check if PATH already configured
  if ! grep -q "$install_dir/bin" "$shell_rc" 2>/dev/null; then
    echo "" >> "$shell_rc"
    echo "# User-level zsh installation" >> "$shell_rc"
    echo "export PATH=$install_dir/bin:\$PATH" >> "$shell_rc"
    echo -e "${DEVTOOLS_GREEN}✓ Updated $shell_rc${DEVTOOLS_RESET}"
  fi

  # Add to /etc/shells if writable (for chsh)
  if [[ -w /etc/shells ]]; then
    if ! grep -q "$install_dir/bin/zsh" /etc/shells 2>/dev/null; then
      echo "$install_dir/bin/zsh" | sudo tee -a /etc/shells >/dev/null
      echo -e "${DEVTOOLS_GREEN}✓ Added to /etc/shells${DEVTOOLS_RESET}"
    fi
  fi

  echo ""
  echo -e "${DEVTOOLS_GREEN}✓ User-level zsh installation complete${DEVTOOLS_RESET}"
  echo ""
  echo -e "${DEVTOOLS_YELLOW}To use your new zsh:${DEVTOOLS_RESET}"
  echo -e "  1. Restart your terminal or run: ${DEVTOOLS_BLUE}source $shell_rc${DEVTOOLS_RESET}"
  echo -e "  2. Verify installation: ${DEVTOOLS_BLUE}$install_dir/bin/zsh --version${DEVTOOLS_RESET}"
  echo -e "  3. Set as default shell: ${DEVTOOLS_BLUE}chsh -s $install_dir/bin/zsh${DEVTOOLS_RESET}"
}

# Install UV Python package manager
# UV: An extremely fast Python package installer and resolver
devtools_install_uv() {
  echo -e "${DEVTOOLS_BLUE}Installing UV Python package manager...${DEVTOOLS_RESET}"

  if _devtools_command_exists uv; then
    echo -e "${DEVTOOLS_YELLOW}UV is already installed${DEVTOOLS_RESET}"
    return 0
  fi

  if curl -LsSf https://astral.sh/uv/install.sh | sh; then
    echo -e "${DEVTOOLS_GREEN}✓ UV installed successfully${DEVTOOLS_RESET}"
    echo ""
    echo -e "${DEVTOOLS_YELLOW}Note: You may need to restart your terminal or run:${DEVTOOLS_RESET}"
    echo -e "  ${DEVTOOLS_BLUE}source \$HOME/.cargo/env${DEVTOOLS_RESET}"
  else
    echo -e "${DEVTOOLS_RED}✗ Failed to install UV${DEVTOOLS_RESET}" >&2
    return 1
  fi
}

# Install Nerd Fonts (Meslo)
# Nerd Fonts: Iconic font aggregator, collection, and patcher
devtools_install_fonts() {
  echo -e "${DEVTOOLS_BLUE}Installing Nerd Fonts (Meslo)...${DEVTOOLS_RESET}"

  local fonts_dir="$HOME/.local/share/fonts"
  local font_installed=false

  # Check if fonts already exist
  if [[ -d "$fonts_dir" ]] && ls "$fonts_dir"/MesloLGS* >/dev/null 2>&1; then
    echo -e "${DEVTOOLS_YELLOW}Meslo Nerd Fonts already installed${DEVTOOLS_RESET}"
    return 0
  fi

  mkdir -p "$fonts_dir"
  cd "$fonts_dir" || return 1

  echo "Downloading Meslo Nerd Fonts..."
  local base_url="https://github.com/romkatv/powerlevel10k-media/raw/master"
  local fonts=(
    "MesloLGS NF Regular.ttf"
    "MesloLGS NF Bold.ttf"
    "MesloLGS NF Italic.ttf"
    "MesloLGS NF Bold Italic.ttf"
  )

  for font in "${fonts[@]}"; do
    if curl -fLo "$font" "$base_url/$font"; then
      font_installed=true
    else
      echo -e "${DEVTOOLS_RED}✗ Failed to download $font${DEVTOOLS_RESET}" >&2
    fi
  done

  if [[ "$font_installed" == "true" ]]; then
    fc-cache -f -v >/dev/null 2>&1
    echo -e "${DEVTOOLS_GREEN}✓ Meslo Nerd Fonts installed${DEVTOOLS_RESET}"
    echo ""
    echo -e "${DEVTOOLS_YELLOW}Note: Set your terminal font to 'MesloLGS NF'${DEVTOOLS_RESET}"
  else
    echo -e "${DEVTOOLS_RED}✗ Failed to install fonts${DEVTOOLS_RESET}" >&2
    return 1
  fi

  cd - >/dev/null || return 0
}

# Install Oh My Zsh with powerlevel10k theme and plugins
# Oh My Zsh: Delightful framework for managing your Zsh configuration
devtools_install_ohmyzsh() {
  echo -e "${DEVTOOLS_BLUE}Installing Oh My Zsh with powerlevel10k...${DEVTOOLS_RESET}"

  # Check if zsh is installed
  if ! _devtools_command_exists zsh; then
    echo -e "${DEVTOOLS_RED}✗ zsh is not installed${DEVTOOLS_RESET}" >&2
    echo -e "  Run: ${DEVTOOLS_BLUE}devtools_install_shell${DEVTOOLS_RESET}" >&2
    return 1
  fi

  # Install Oh My Zsh
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo -e "${DEVTOOLS_YELLOW}Oh My Zsh already installed${DEVTOOLS_RESET}"
  else
    echo "Installing Oh My Zsh..."
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
      echo -e "${DEVTOOLS_RED}✗ Failed to install Oh My Zsh${DEVTOOLS_RESET}" >&2
      return 1
    }
    echo -e "${DEVTOOLS_GREEN}✓ Oh My Zsh installed${DEVTOOLS_RESET}"
  fi

  # Install powerlevel10k theme
  local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  if [[ -d "$p10k_dir" ]]; then
    echo -e "${DEVTOOLS_YELLOW}powerlevel10k already installed${DEVTOOLS_RESET}"
  else
    echo "Installing powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir" || {
      echo -e "${DEVTOOLS_RED}✗ Failed to install powerlevel10k${DEVTOOLS_RESET}" >&2
      return 1
    }
    echo -e "${DEVTOOLS_GREEN}✓ powerlevel10k installed${DEVTOOLS_RESET}"
  fi

  # Install zsh-syntax-highlighting
  local syntax_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
  if [[ -d "$syntax_dir" ]]; then
    echo -e "${DEVTOOLS_YELLOW}zsh-syntax-highlighting already installed${DEVTOOLS_RESET}"
  else
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_dir" || {
      echo -e "${DEVTOOLS_RED}✗ Failed to install zsh-syntax-highlighting${DEVTOOLS_RESET}" >&2
      return 1
    }
    echo -e "${DEVTOOLS_GREEN}✓ zsh-syntax-highlighting installed${DEVTOOLS_RESET}"
  fi

  # Install zsh-autosuggestions
  local autosugg_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  if [[ -d "$autosugg_dir" ]]; then
    echo -e "${DEVTOOLS_YELLOW}zsh-autosuggestions already installed${DEVTOOLS_RESET}"
  else
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$autosugg_dir" || {
      echo -e "${DEVTOOLS_RED}✗ Failed to install zsh-autosuggestions${DEVTOOLS_RESET}" >&2
      return 1
    }
    echo -e "${DEVTOOLS_GREEN}✓ zsh-autosuggestions installed${DEVTOOLS_RESET}"
  fi

  echo ""
  echo -e "${DEVTOOLS_GREEN}✓ Oh My Zsh setup complete${DEVTOOLS_RESET}"
  echo ""
  echo -e "${DEVTOOLS_YELLOW}Next steps:${DEVTOOLS_RESET}"
  echo -e "  1. Update ~/.zshrc to use powerlevel10k theme:"
  echo -e "     ${DEVTOOLS_BLUE}ZSH_THEME=\"powerlevel10k/powerlevel10k\"${DEVTOOLS_RESET}"
  echo -e "  2. Enable plugins in ~/.zshrc:"
  echo -e "     ${DEVTOOLS_BLUE}plugins=(git zsh-syntax-highlighting zsh-autosuggestions)${DEVTOOLS_RESET}"
  echo -e "  3. Restart your terminal and run: ${DEVTOOLS_BLUE}p10k configure${DEVTOOLS_RESET}"
}

# Install fzf fuzzy finder
# fzf: Command-line fuzzy finder
devtools_install_fzf() {
  echo -e "${DEVTOOLS_BLUE}Installing fzf fuzzy finder...${DEVTOOLS_RESET}"

  if [[ -d "$HOME/.fzf" ]]; then
    echo -e "${DEVTOOLS_YELLOW}fzf already installed${DEVTOOLS_RESET}"
    return 0
  fi

  echo "Cloning fzf repository..."
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" || {
    echo -e "${DEVTOOLS_RED}✗ Failed to clone fzf${DEVTOOLS_RESET}" >&2
    return 1
  }

  echo "Installing fzf..."
  "$HOME/.fzf/install" --all || {
    echo -e "${DEVTOOLS_RED}✗ Failed to install fzf${DEVTOOLS_RESET}" >&2
    return 1
  }

  echo -e "${DEVTOOLS_GREEN}✓ fzf installed successfully${DEVTOOLS_RESET}"
  echo ""
  echo -e "${DEVTOOLS_YELLOW}Note: Restart your terminal to use fzf${DEVTOOLS_RESET}"
}

# Configure Vim with sensible defaults
# Sets up a basic .vimrc with useful settings
devtools_configure_vim() {
  echo -e "${DEVTOOLS_BLUE}Configuring Vim...${DEVTOOLS_RESET}"

  local vimrc="$HOME/.vimrc"
  local vimrc_template="${OMD_DIR:-$HOME/.oh-my-dev}/configs/vimrc"

  if [[ ! -f "$vimrc_template" ]]; then
    echo -e "${DEVTOOLS_RED}✗ Vim configuration template not found at $vimrc_template${DEVTOOLS_RESET}" >&2
    return 1
  fi

  if [[ -f "$vimrc" ]]; then
    echo -e "${DEVTOOLS_YELLOW}~/.vimrc already exists${DEVTOOLS_RESET}"
    read -r -p "Overwrite existing .vimrc? (y/N) " -n 1
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "Skipping vim configuration"
      return 0
    fi
  fi

  if cp "$vimrc_template" "$vimrc"; then
    mkdir -p "$HOME/.vim/undodir"
    echo -e "${DEVTOOLS_GREEN}✓ Vim configured successfully${DEVTOOLS_RESET}"
    echo -e "  Configuration saved to: ${DEVTOOLS_BLUE}$vimrc${DEVTOOLS_RESET}"
  else
    echo -e "${DEVTOOLS_RED}✗ Failed to configure Vim${DEVTOOLS_RESET}" >&2
    return 1
  fi
}

# Configure Powerlevel10k theme
# Copies p10k configuration file to user's home directory
devtools_configure_p10k() {
  echo -e "${DEVTOOLS_BLUE}Configuring Powerlevel10k theme...${DEVTOOLS_RESET}"

  local p10k_config="$HOME/.p10k.zsh"
  local p10k_template="${OMD_DIR:-$HOME/.oh-my-dev}/configs/p10k.zsh"

  if [[ ! -f "$p10k_template" ]]; then
    echo -e "${DEVTOOLS_RED}✗ Powerlevel10k configuration template not found at $p10k_template${DEVTOOLS_RESET}" >&2
    return 1
  fi

  if [[ -f "$p10k_config" ]]; then
    echo -e "${DEVTOOLS_YELLOW}~/.p10k.zsh already exists${DEVTOOLS_RESET}"
    read -r -p "Overwrite existing .p10k.zsh? (y/N) " -n 1
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "Skipping p10k configuration"
      return 0
    fi
  fi

  if cp "$p10k_template" "$p10k_config"; then
    echo -e "${DEVTOOLS_GREEN}✓ Powerlevel10k configured successfully${DEVTOOLS_RESET}"
    echo -e "  Configuration saved to: ${DEVTOOLS_BLUE}$p10k_config${DEVTOOLS_RESET}"
    echo ""
    echo -e "${DEVTOOLS_YELLOW}Note: To customize your p10k theme:${DEVTOOLS_RESET}"
    echo -e "  1. Run: ${DEVTOOLS_BLUE}p10k configure${DEVTOOLS_RESET}"
    echo -e "  2. Or edit: ${DEVTOOLS_BLUE}~/.p10k.zsh${DEVTOOLS_RESET}"
    echo -e "  3. To preserve custom config: ${DEVTOOLS_BLUE}cp ~/.p10k.zsh ${OMD_DIR:-$HOME/.oh-my-dev}/configs/p10k.zsh${DEVTOOLS_RESET}"
  else
    echo -e "${DEVTOOLS_RED}✗ Failed to configure Powerlevel10k${DEVTOOLS_RESET}" >&2
    return 1
  fi
}

# Complete shell setup - install all user-space tools
# This runs all user-space installation functions in sequence
devtools_setup_shell() {
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_BLUE}  Complete Shell Setup${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo ""

  devtools_install_uv
  echo ""
  devtools_install_fonts
  echo ""
  devtools_install_ohmyzsh
  echo ""
  devtools_install_fzf
  echo ""
  devtools_configure_vim
  echo ""
  devtools_configure_p10k

  echo ""
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_GREEN}✓ Shell setup complete${DEVTOOLS_RESET}"
  echo -e "${DEVTOOLS_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${DEVTOOLS_RESET}"
  echo ""
  echo -e "${DEVTOOLS_YELLOW}Final steps:${DEVTOOLS_RESET}"
  echo -e "  1. Set zsh as default shell: ${DEVTOOLS_BLUE}chsh -s \$(which zsh)${DEVTOOLS_RESET}"
  echo -e "  2. Restart your terminal"
  echo -e "  3. Your p10k theme is configured and ready to use!"
  echo ""
}

# ============================================================================
# System-wide Installation (requires sudo)
# ============================================================================

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

  # User-space Tools
  echo -e "${DEVTOOLS_YELLOW}User-space Tools:${DEVTOOLS_RESET}"

  # Check for user-level zsh installation
  if [[ -x "$HOME/.local/zsh/bin/zsh" ]]; then
    local zsh_version
    zsh_version=$("$HOME/.local/zsh/bin/zsh" --version 2>/dev/null | awk '{print $2}')
    echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} User-level zsh (version $zsh_version)"
  else
    echo -e "  ${DEVTOOLS_RED}✗${DEVTOOLS_RESET} User-level zsh"
  fi

  _devtools_print_status "uv"
  _devtools_print_status "fzf"

  # Check for Meslo Nerd Fonts
  if [[ -d "$HOME/.local/share/fonts" ]] && ls "$HOME/.local/share/fonts"/MesloLGS* >/dev/null 2>&1; then
    echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} Meslo Nerd Fonts"
  else
    echo -e "  ${DEVTOOLS_RED}✗${DEVTOOLS_RESET} Meslo Nerd Fonts"
  fi

  # Check for Oh My Zsh
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} Oh My Zsh"
  else
    echo -e "  ${DEVTOOLS_RED}✗${DEVTOOLS_RESET} Oh My Zsh"
  fi

  # Check for powerlevel10k
  if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]]; then
    echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} powerlevel10k"
  else
    echo -e "  ${DEVTOOLS_RED}✗${DEVTOOLS_RESET} powerlevel10k"
  fi

  # Check for Vim configuration
  if [[ -f "$HOME/.vimrc" ]]; then
    echo -e "  ${DEVTOOLS_GREEN}✓${DEVTOOLS_RESET} Vim configured"
  else
    echo -e "  ${DEVTOOLS_RED}✗${DEVTOOLS_RESET} Vim configured"
  fi
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
  echo -e "  Install system tools:  ${DEVTOOLS_BLUE}devtools_install_all${DEVTOOLS_RESET}"
  echo -e "  Setup user shell:      ${DEVTOOLS_BLUE}devtools_setup_shell${DEVTOOLS_RESET}"
  echo -e "  Run configuration:     ${DEVTOOLS_BLUE}devtools_configure${DEVTOOLS_RESET}"
  echo -e "  Update all tools:      ${DEVTOOLS_BLUE}devtools_update${DEVTOOLS_RESET}"
  echo ""
}

# Useful aliases - System installation
alias dev-install-essentials='devtools_install_essentials'
alias dev-install-system='devtools_install_system'
alias dev-install-shell='devtools_install_shell'
alias dev-install-modern='devtools_install_modern'
alias dev-install-network='devtools_install_network'
alias dev-install-all='devtools_install_all'

# Useful aliases - User-space installation
alias dev-install-zsh='devtools_install_zsh_userspace'
alias dev-install-uv='devtools_install_uv'
alias dev-install-fonts='devtools_install_fonts'
alias dev-install-ohmyzsh='devtools_install_ohmyzsh'
alias dev-install-fzf='devtools_install_fzf'
alias dev-configure-vim='devtools_configure_vim'
alias dev-configure-p10k='devtools_configure_p10k'
alias dev-setup-shell='devtools_setup_shell'

# Useful aliases - Management
alias dev-update='devtools_update'
alias dev-configure='devtools_configure'
alias dev-status='devtools_status'
