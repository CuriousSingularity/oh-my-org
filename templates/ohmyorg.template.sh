#!/usr/bin/env bash
# Oh My Org Configuration Template
# Copy this to your ~/.zshrc or ~/.bashrc

# Oh My Org installation directory
export OMO_DIR="$HOME/.oh-my-org"

# Enable auto-update (set to false to disable)
export OMO_AUTO_UPDATE=true

# Update check interval in seconds (default: 86400 = 24 hours)
# 43200 = 12 hours, 3600 = 1 hour
export OMO_UPDATE_CHECK_INTERVAL=86400

# Theme (optional)
# Available themes: default
# Custom themes can be placed in $OMO_DIR/custom/themes/
export OMO_THEME="default"

# Plugins to load (optional)
# Available plugins: git, docker, uv, utils
# Custom plugins can be placed in $OMO_DIR/custom/plugins/
export OMO_PLUGINS=(git docker uv utils)

# Source Oh My Org
if [[ -f "$OMO_DIR/oh-my-org.sh" ]]; then
  source "$OMO_DIR/oh-my-org.sh"
else
  echo "Oh My Org not found at $OMO_DIR"
fi
