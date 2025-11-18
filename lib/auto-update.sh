#!/usr/bin/env bash
# Auto-update functionality for Oh My Dev

# Configuration
OMD_UPDATE_CHECK_INTERVAL="${OMD_UPDATE_CHECK_INTERVAL:-86400}" # Default: 24 hours
OMD_UPDATE_FILE="$OMD_DIR/.last_update_check"

# Check if it's time to check for updates
omd_should_check_updates() {
  if [[ ! -f "$OMD_UPDATE_FILE" ]]; then
    return 0
  fi

  local last_check
  last_check=$(cat "$OMD_UPDATE_FILE" 2>/dev/null || echo 0)
  local current_time
  current_time=$(omd_timestamp)
  local time_diff=$((current_time - last_check))

  [[ $time_diff -ge $OMD_UPDATE_CHECK_INTERVAL ]]
}

# Update the last check timestamp
omd_update_check_timestamp() {
  omd_timestamp > "$OMD_UPDATE_FILE"
}

# Check for updates from git
omd_check_for_updates() {
  # Only check if we should (based on interval)
  if ! omd_should_check_updates; then
    return 0
  fi

  # Only proceed if git is available
  if ! omd_command_exists git; then
    return 1
  fi

  # Change to Oh My Dev directory
  cd "$OMD_DIR" || return 1

  # Check if this is a git repository
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    return 1
  fi

  # Fetch latest changes
  git fetch origin >/dev/null 2>&1

  # Check if there are updates
  local local_commit
  local_commit=$(git rev-parse HEAD)
  local remote_commit
  remote_commit=$(git rev-parse origin/main 2>/dev/null || git rev-parse origin/master 2>/dev/null)

  if [[ "$local_commit" != "$remote_commit" ]]; then
    omd_perform_update
  fi

  # Update timestamp
  omd_update_check_timestamp
}

# Perform the actual update
omd_perform_update() {
  omd_info "Updates available! Updating Oh My Dev..."

  cd "$OMD_DIR" || return 1

  # Stash any local changes
  git stash push -m "oh-my-dev auto-update $(date)" >/dev/null 2>&1

  # Pull latest changes
  if git pull --rebase origin main >/dev/null 2>&1 || git pull --rebase origin master >/dev/null 2>&1; then
    omd_success "Oh My Dev updated successfully! Restart your terminal to apply changes."
  else
    omd_error "Update failed. Please run 'cd $OMD_DIR && git pull' manually."
  fi
}

# Manual update command
omd_update() {
  omd_info "Checking for updates..."

  cd "$OMD_DIR" || return 1

  if ! omd_command_exists git; then
    omd_error "Git is not installed. Cannot update."
    return 1
  fi

  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    omd_error "Oh My Dev directory is not a git repository."
    return 1
  fi

  git fetch origin

  local local_commit
  local_commit=$(git rev-parse HEAD)
  local remote_commit
  remote_commit=$(git rev-parse origin/main 2>/dev/null || git rev-parse origin/master 2>/dev/null)

  if [[ "$local_commit" == "$remote_commit" ]]; then
    omd_success "Oh My Dev is already up to date!"
  else
    omd_perform_update
  fi
}
