#!/usr/bin/env bash

# Main script execution
if [ "$EUID" -ne 0 ]; then
    echo "Running non-sudo tasks..."
    bash "$(dirname "$0")/install_non_sudo_tools.sh"
    echo "To complete the setup, please run the script with sudo for the remaining tasks."
else
    echo "Running sudo tasks..."
    bash "$(dirname "$0")/install_sudo_tools.sh"
fi
