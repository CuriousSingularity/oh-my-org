#!/usr/bin/env bash
# Oh My Org - Terminal Organization Framework
# Main initialization script

# Set Oh My Org installation directory
export OMO_DIR="${OMO_DIR:-$HOME/.oh-my-org}"

# Source utility functions
source "$OMO_DIR/lib/utils.sh"

# Auto-update check (runs in background to not slow down shell startup)
if [[ "$OMO_AUTO_UPDATE" != "false" ]]; then
  source "$OMO_DIR/lib/auto-update.sh"
  omo_check_for_updates &!
fi

# Load theme
if [[ -n "$OMO_THEME" ]]; then
  source "$OMO_DIR/lib/theme-loader.sh"
  omo_load_theme "$OMO_THEME"
fi

# Load plugins
if [[ ${#OMO_PLUGINS[@]} -gt 0 ]]; then
  source "$OMO_DIR/lib/plugin-loader.sh"
  omo_load_plugins
fi

# Custom user configurations
if [[ -f "$OMO_DIR/custom/custom.sh" ]]; then
  source "$OMO_DIR/custom/custom.sh"
fi
