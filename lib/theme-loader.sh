#!/usr/bin/env bash
# Theme loader for Oh My Org

# Load a theme
omo_load_theme() {
  local theme="$1"
  local theme_path

  # Check in custom themes directory first
  if [[ -f "$OMO_DIR/custom/themes/$theme.theme.sh" ]]; then
    theme_path="$OMO_DIR/custom/themes/$theme.theme.sh"
  # Then check in default themes directory
  elif [[ -f "$OMO_DIR/themes/$theme.theme.sh" ]]; then
    theme_path="$OMO_DIR/themes/$theme.theme.sh"
  else
    omo_warning "Theme '$theme' not found, using default"
    return 1
  fi

  source "$theme_path"
}

# List available themes
omo_list_themes() {
  echo "Available themes:"
  echo ""

  # List default themes
  if [[ -d "$OMO_DIR/themes" ]]; then
    echo "Default themes:"
    for theme_file in "$OMO_DIR/themes"/*.theme.sh; do
      if [[ -f "$theme_file" ]]; then
        echo "  - $(basename "$theme_file" .theme.sh)"
      fi
    done
  fi

  # List custom themes
  if [[ -d "$OMO_DIR/custom/themes" ]]; then
    echo ""
    echo "Custom themes:"
    for theme_file in "$OMO_DIR/custom/themes"/*.theme.sh; do
      if [[ -f "$theme_file" ]]; then
        echo "  - $(basename "$theme_file" .theme.sh)"
      fi
    done
  fi
}
