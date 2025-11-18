#!/usr/bin/env bash
# Auto-update functionality for Oh My Org

# Configuration
OMO_UPDATE_CHECK_INTERVAL="${OMO_UPDATE_CHECK_INTERVAL:-86400}" # Default: 24 hours
OMO_UPDATE_FILE="$OMO_DIR/.last_update_check"

# Check if it's time to check for updates
omo_should_check_updates() {
  if [[ ! -f "$OMO_UPDATE_FILE" ]]; then
    return 0
  fi

  local last_check=$(cat "$OMO_UPDATE_FILE" 2>/dev/null || echo 0)
  local current_time=$(omo_timestamp)
  local time_diff=$((current_time - last_check))

  [[ $time_diff -ge $OMO_UPDATE_CHECK_INTERVAL ]]
}

# Update the last check timestamp
omo_update_check_timestamp() {
  omo_timestamp > "$OMO_UPDATE_FILE"
}

# Check for updates from git
omo_check_for_updates() {
  # Only check if we should (based on interval)
  if ! omo_should_check_updates; then
    return 0
  fi

  # Only proceed if git is available
  if ! omo_command_exists git; then
    return 1
  fi

  # Change to Oh My Org directory
  cd "$OMO_DIR" || return 1

  # Check if this is a git repository
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    return 1
  fi

  # Fetch latest changes
  git fetch origin >/dev/null 2>&1

  # Check if there are updates
  local local_commit=$(git rev-parse HEAD)
  local remote_commit=$(git rev-parse origin/main 2>/dev/null || git rev-parse origin/master 2>/dev/null)

  if [[ "$local_commit" != "$remote_commit" ]]; then
    omo_perform_update
  fi

  # Update timestamp
  omo_update_check_timestamp
}

# Perform the actual update
omo_perform_update() {
  omo_info "Updates available! Updating Oh My Org..."

  cd "$OMO_DIR" || return 1

  # Stash any local changes
  git stash push -m "oh-my-org auto-update $(date)" >/dev/null 2>&1

  # Pull latest changes
  if git pull --rebase origin main >/dev/null 2>&1 || git pull --rebase origin master >/dev/null 2>&1; then
    omo_success "Oh My Org updated successfully! Restart your terminal to apply changes."
  else
    omo_error "Update failed. Please run 'cd $OMO_DIR && git pull' manually."
  fi
}

# Manual update command
omo_update() {
  omo_info "Checking for updates..."

  cd "$OMO_DIR" || return 1

  if ! omo_command_exists git; then
    omo_error "Git is not installed. Cannot update."
    return 1
  fi

  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    omo_error "Oh My Org directory is not a git repository."
    return 1
  fi

  git fetch origin

  local local_commit=$(git rev-parse HEAD)
  local remote_commit=$(git rev-parse origin/main 2>/dev/null || git rev-parse origin/master 2>/dev/null)

  if [[ "$local_commit" == "$remote_commit" ]]; then
    omo_success "Oh My Org is already up to date!"
  else
    omo_perform_update
  fi
}
