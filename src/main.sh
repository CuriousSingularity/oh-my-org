#!/usr/bin/env bash

# Path to the repository
REPO_DIR="$HOME/.oh-my-org"

# Function to check for updates
check_for_updates() {
    if [ -d "$REPO_DIR/.git" ]; then
        cd "$REPO_DIR" || exit
        git fetch origin &>/dev/null
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse @{u})

        if [ "$LOCAL" != "$REMOTE" ]; then
            echo "Updating oh-my-org..."
            git pull origin main
            clear
        else
            echo "oh-my-org is up to date."
        fi
        cd - > /dev/null  # Return to the original directory
    else
        echo "Repository not found. Please install oh-my-org first."
    fi
}

# Run the update check
check_for_updates

# Source all the scripts in the src/utils/ directory
for script in "$REPO_DIR"/src/utils/*.sh; do
    if [ -f "$script" ]; then
        source "$script"
    fi
done

# Check if bin directory exists, create it if not
if [ ! -d "$REPO_DIR/bin" ]; then
    mkdir -p "$REPO_DIR/bin"
fi

# Run all the scripts in the src/tools/bins/ directory
for bin_script in "$REPO_DIR"/src/tools/bins/*.sh; do
    if [ -f "$bin_script" ]; then
        bash "$bin_script" "$REPO_DIR/bin"
    fi
done

# Update PATH to include the bin directory
export PATH="$PATH:$REPO_DIR/bin"

# Run the weather widget with default parameters
bash "$REPO_DIR/src/tools/widgets/weather.sh" Traunreut 1
