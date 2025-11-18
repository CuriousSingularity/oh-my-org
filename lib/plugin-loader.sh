#!/usr/bin/env bash
# Plugin loader for Oh My Dev

# Load all enabled plugins
omd_load_plugins() {
  local plugin

  for plugin in "${OMD_PLUGINS[@]}"; do
    omd_load_plugin "$plugin"
  done
}

# Load a single plugin
omd_load_plugin() {
  local plugin="$1"
  local plugin_path

  # Check in custom plugins directory first
  if [[ -f "$OMD_DIR/custom/plugins/$plugin/$plugin.plugin.sh" ]]; then
    plugin_path="$OMD_DIR/custom/plugins/$plugin/$plugin.plugin.sh"
  # Then check in default plugins directory
  elif [[ -f "$OMD_DIR/plugins/$plugin/$plugin.plugin.sh" ]]; then
    plugin_path="$OMD_DIR/plugins/$plugin/$plugin.plugin.sh"
  else
    omd_warning "Plugin '$plugin' not found"
    return 1
  fi

  # shellcheck disable=SC1090
  source "$plugin_path"
}

# List available plugins
omd_list_plugins() {
  echo "Available plugins:"
  echo ""

  # List default plugins
  if [[ -d "$OMD_DIR/plugins" ]]; then
    echo "Default plugins:"
    for plugin_dir in "$OMD_DIR/plugins"/*; do
      if [[ -d "$plugin_dir" ]]; then
        echo "  - $(basename "$plugin_dir")"
      fi
    done
  fi

  # List custom plugins
  if [[ -d "$OMD_DIR/custom/plugins" ]]; then
    echo ""
    echo "Custom plugins:"
    for plugin_dir in "$OMD_DIR/custom/plugins"/*; do
      if [[ -d "$plugin_dir" ]]; then
        echo "  - $(basename "$plugin_dir")"
      fi
    done
  fi
}
