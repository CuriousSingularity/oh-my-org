# ollama-model-direct-download
# https://github.com/amirrezaDev1378/ollama-model-direct-download


#!/usr/bin/env bash

INSTALL_DIR="$1"

# Detect OS
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Detect architecture
ARCH=$(uname -m)

# Normalize architecture names
case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  i386|i686) ARCH="386" ;;
  armv7l) ARCH="arm" ;;
  aarch64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Construct filename
FILENAME="omdd-${OS}-${ARCH}"

# Check if binary already exists in install directory
if [ -n "$INSTALL_DIR" ] && [ -f "$INSTALL_DIR/omdd" ]; then
    exit 0
fi

# GitHub release URL (replace with actual version if needed)
VERSION="v2.1.1"
BASE_URL="https://github.com/amirrezaDev1378/ollama-model-direct-download/releases/download/${VERSION}"

# Download
echo "Downloading $FILENAME..."
curl -L -o "$FILENAME" "${BASE_URL}/${FILENAME}"

# Make executable
chmod +x "$FILENAME"

# Move to the specified install directory
if [ -n "$INSTALL_DIR" ]; then
    echo "Moving $FILENAME to $INSTALL_DIR/omdd"
    mkdir -p "$INSTALL_DIR"
    mv "$FILENAME" "$INSTALL_DIR/omdd"
    echo "Installation complete. Run '$INSTALL_DIR/omdd --help' to verify."
else
    echo "No install directory specified. Cleaning up..."
    rm "$FILENAME"
fi
