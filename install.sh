#!/bin/bash

# Define the installation directory
INSTALL_DIR="$HOME/.oh-my-org"

# Create the installation directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
fi

# Clone the repository into the installation directory
if [ ! -d "$INSTALL_DIR/.git" ]; then
    # Clone the repository if it doesn't already exist
    git clone https://github.com/CuriousSingularity/oh-my-org.git "$INSTALL_DIR"
else
    # Pull the latest changes if the repository already exists
    echo "Repository already exists in $INSTALL_DIR. Pulling latest changes..."
    cd "$INSTALL_DIR" && git pull
    cd - > /dev/null  # Return to the original directory
fi

# Determine the appropriate shell configuration file
if [[ "$SHELL" == *"zsh" ]]; then
    SHELL_RC="$HOME/.zshrc"
else
    SHELL_RC="$HOME/.bashrc"
fi

# Add the main script to the shell configuration file for automatic execution on terminal startup
if ! grep -q "source $INSTALL_DIR/src/main.sh" "$SHELL_RC"; then
    echo "source $INSTALL_DIR/src/main.sh" >> "$SHELL_RC"
    echo "Added source command to $SHELL_RC"
fi

# Notify the user that installation is complete
echo "Installation complete. Please restart your terminal."