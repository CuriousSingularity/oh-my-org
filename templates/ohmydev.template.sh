#!/usr/bin/env bash
# Oh My Dev Configuration Template
# Copy this to your ~/.zshrc or ~/.bashrc

# Oh My Dev installation directory
export OMD_DIR="$HOME/.oh-my-dev"

# Enable auto-update (set to false to disable)
export OMD_AUTO_UPDATE=true

# Update check interval in seconds (default: 86400 = 24 hours)
# 43200 = 12 hours, 3600 = 1 hour
export OMD_UPDATE_CHECK_INTERVAL=86400

# Theme (optional)
# Available themes: default
# Custom themes can be placed in $OMD_DIR/custom/themes/
export OMD_THEME="default"

# Plugins to load (optional)
# Available plugins: git, docker, uv, utils, claude-code
# Custom plugins can be placed in $OMD_DIR/custom/plugins/
export OMD_PLUGINS=(git docker uv utils claude-code)

# Source Oh My Dev
if [[ -f "$OMD_DIR/oh-my-dev.sh" ]]; then
  source "$OMD_DIR/oh-my-dev.sh"
else
  echo "Oh My Dev not found at $OMD_DIR"
fi
