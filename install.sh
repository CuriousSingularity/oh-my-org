#!/bin/bash

# Define repositories and their installation directories
REPOS=(
    "https://github.com/CuriousSingularity/oh-my-org.git|$HOME/.oh-my-org"
)

# Loop through each repository and handle installation
for REPO in "${REPOS[@]}"; do
    REPO_URL="${REPO%%|*}"
    INSTALL_DIR="${REPO##*|}"

    # Create the installation directory if it doesn't exist
    if [ ! -d "$INSTALL_DIR" ]; then
        mkdir -p "$INSTALL_DIR"
    fi

    # Skip cloning if the directory already exists
    if [ -d "$INSTALL_DIR/.git" ]; then
        continue
    fi

    # Clone the repository if it doesn't already exist
    git clone "$REPO_URL" "$INSTALL_DIR"

    # Determine the appropriate shell configuration file
    if [[ "$SHELL" == *"zsh" ]]; then
        SHELL_RC="$HOME/.zshrc"
    else
        SHELL_RC="$HOME/.bashrc"
    fi

    # Add the main script to the shell configuration file for automatic execution on terminal startup
    if ! grep -q "source $INSTALL_DIR/src/main.sh" "$SHELL_RC"; then
        echo "source $INSTALL_DIR/src/main.sh" >> "$SHELL_RC"
        echo "Added source command to $SHELL_RC for $INSTALL_DIR"
    fi
done

# Notify the user that installation is complete
echo "Installation complete for all repositories. Please restart your terminal."