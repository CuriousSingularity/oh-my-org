#!/usr/bin/env bash
# Theme loader for Oh My Dev

# Load a theme
omd_load_theme() {
  local theme="$1"
  local theme_path

  # Check in custom themes directory first
  if [[ -f "$OMD_DIR/custom/themes/$theme.theme.sh" ]]; then
    theme_path="$OMD_DIR/custom/themes/$theme.theme.sh"
  # Then check in default themes directory
  elif [[ -f "$OMD_DIR/themes/$theme.theme.sh" ]]; then
    theme_path="$OMD_DIR/themes/$theme.theme.sh"
  else
    omd_warning "Theme '$theme' not found, using default"
    return 1
  fi

  # shellcheck disable=SC1090
  source "$theme_path"
}

# List available themes
omd_list_themes() {
  echo "Available themes:"
  echo ""

  # List default themes
  if [[ -d "$OMD_DIR/themes" ]]; then
    echo "Default themes:"
    for theme_file in "$OMD_DIR/themes"/*.theme.sh; do
      if [[ -f "$theme_file" ]]; then
        echo "  - $(basename "$theme_file" .theme.sh)"
      fi
    done
  fi

  # List custom themes
  if [[ -d "$OMD_DIR/custom/themes" ]]; then
    echo ""
    echo "Custom themes:"
    for theme_file in "$OMD_DIR/custom/themes"/*.theme.sh; do
      if [[ -f "$theme_file" ]]; then
        echo "  - $(basename "$theme_file" .theme.sh)"
      fi
    done
  fi
}
