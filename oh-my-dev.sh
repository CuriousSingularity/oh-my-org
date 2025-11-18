#!/usr/bin/env bash
# Oh My Dev - Developer Productivity Framework
# Main initialization script

# Set Oh My Dev installation directory
export OMD_DIR="${OMD_DIR:-$HOME/.oh-my-dev}"

# Source utility functions
source "$OMD_DIR/lib/utils.sh"

# Auto-update check (runs in background to not slow down shell startup)
if [[ "$OMD_AUTO_UPDATE" != "false" ]]; then
  source "$OMD_DIR/lib/auto-update.sh"
  # Run in background (works for both bash and zsh)
  ( omd_check_for_updates & )
fi

# Load theme
if [[ -n "$OMD_THEME" ]]; then
  source "$OMD_DIR/lib/theme-loader.sh"
  omd_load_theme "$OMD_THEME"
fi

# Load plugins
if [[ ${#OMD_PLUGINS[@]} -gt 0 ]]; then
  source "$OMD_DIR/lib/plugin-loader.sh"
  omd_load_plugins
fi

# Custom user configurations
if [[ -f "$OMD_DIR/custom/custom.sh" ]]; then
  source "$OMD_DIR/custom/custom.sh"
fi
