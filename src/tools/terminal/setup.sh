#!/usr/bin/env bash

# Run once with sudo to install essential tools and set up the environment
sudo bash $(dirname "$0")/install_tools.sh

# Run once without sudo to install user-specific tools and configurations
bash $(dirname "$0")/install_tools.sh