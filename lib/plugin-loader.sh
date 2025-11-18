#!/usr/bin/env bash
# Plugin loader for Oh My Org

# Load all enabled plugins
omo_load_plugins() {
  local plugin

  for plugin in "${OMO_PLUGINS[@]}"; do
    omo_load_plugin "$plugin"
  done
}

# Load a single plugin
omo_load_plugin() {
  local plugin="$1"
  local plugin_path

  # Check in custom plugins directory first
  if [[ -f "$OMO_DIR/custom/plugins/$plugin/$plugin.plugin.sh" ]]; then
    plugin_path="$OMO_DIR/custom/plugins/$plugin/$plugin.plugin.sh"
  # Then check in default plugins directory
  elif [[ -f "$OMO_DIR/plugins/$plugin/$plugin.plugin.sh" ]]; then
    plugin_path="$OMO_DIR/plugins/$plugin/$plugin.plugin.sh"
  else
    omo_warning "Plugin '$plugin' not found"
    return 1
  fi

  # shellcheck disable=SC1090
  source "$plugin_path"
}

# List available plugins
omo_list_plugins() {
  echo "Available plugins:"
  echo ""

  # List default plugins
  if [[ -d "$OMO_DIR/plugins" ]]; then
    echo "Default plugins:"
    for plugin_dir in "$OMO_DIR/plugins"/*; do
      if [[ -d "$plugin_dir" ]]; then
        echo "  - $(basename "$plugin_dir")"
      fi
    done
  fi

  # List custom plugins
  if [[ -d "$OMO_DIR/custom/plugins" ]]; then
    echo ""
    echo "Custom plugins:"
    for plugin_dir in "$OMO_DIR/custom/plugins"/*; do
      if [[ -d "$plugin_dir" ]]; then
        echo "  - $(basename "$plugin_dir")"
      fi
    done
  fi
}
