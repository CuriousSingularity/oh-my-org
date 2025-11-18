#!/usr/bin/env bash
# Gemini plugin for Oh My Dev
# Provides setup and configuration for Google Gemini CLI
#
# Reference:
#   https://github.com/google-gemini/gemini-cli
#   https://aistudio.google.com/apikey
#
# USAGE EXAMPLES:
#
# 1. Check Gemini CLI installation and configuration status:
#    $ gemini_status
#    or
#    $ gemini-status
#
# 2. Setup Gemini API key (for AI Studio):
#    $ gemini_setup_api "your-gemini-api-key-here"
#    or
#    $ gemini-config-api "your-gemini-api-key-here"
#
# 3. Setup Google API key for Vertex AI:
#    $ gemini_setup_vertex "your-google-api-key-here"
#    or
#    $ gemini-config-vertex "your-google-api-key-here"
#
# 4. Install Gemini CLI:
#    $ gemini_install
#
# 5. Quick setup workflow (AI Studio):
#    $ gemini_install                           # Install Gemini CLI
#    $ gemini_setup_api "your-api-key"         # Configure API key
#    $ gemini_status                            # Verify setup
#
# 6. Quick setup workflow (Vertex AI):
#    $ gemini_install                           # Install Gemini CLI
#    $ gemini_setup_vertex "your-google-key"   # Configure for Vertex AI
#    $ gemini_status                            # Verify setup
#
# 7. Save configuration in your ~/.zshrc or ~/.bashrc for persistence:
#    # For AI Studio:
#    export GEMINI_API_KEY="your-gemini-api-key-here"
#
#    # For Vertex AI:
#    export GOOGLE_API_KEY="your-google-api-key-here"
#    export GOOGLE_GENAI_USE_VERTEXAI=true
#
#    export OMD_PLUGINS=(git docker uv utils claude-code gemini)

# Check if Gemini CLI is installed
gemini_installed() {
  command -v gemini >/dev/null 2>&1
}

# Check if npm is installed
npm_installed() {
  command -v npm >/dev/null 2>&1
}

# Check if Gemini API is configured (AI Studio)
gemini_api_configured() {
  [[ -n "$GEMINI_API_KEY" ]]
}

# Check if Vertex AI is configured
gemini_vertex_configured() {
  [[ -n "$GOOGLE_API_KEY" ]] && [[ "$GOOGLE_GENAI_USE_VERTEXAI" == "true" ]]
}

# Setup Gemini API key for AI Studio
# Usage: gemini_setup_api <api-key>
#
# Arguments:
#   api-key: Your Gemini API key from https://aistudio.google.com/apikey
#
# Example:
#   gemini_setup_api "AIzaSyC..."
gemini_setup_api() {
  local api_key=$1

  if [[ -z "$api_key" ]]; then
    echo "Error: API key is required" >&2
    echo "" >&2
    echo "Usage: gemini_setup_api <api-key>" >&2
    echo "" >&2
    echo "Get your API key from: https://aistudio.google.com/apikey" >&2
    echo "" >&2
    echo "Example:" >&2
    echo "  gemini_setup_api \"AIzaSyC...\"" >&2
    return 1
  fi

  export GEMINI_API_KEY="$api_key"

  echo "✓ Gemini API configured (AI Studio mode)"
  echo "  API Key: ${GEMINI_API_KEY:0:20}..."
  echo ""
  echo "Note: Add this to your ~/.zshrc or ~/.bashrc to make it permanent:"
  echo "  export GEMINI_API_KEY=\"$GEMINI_API_KEY\""
}

# Setup Google API key for Vertex AI
# Usage: gemini_setup_vertex <google-api-key>
#
# Arguments:
#   google-api-key: Your Google API key from Google Cloud Console
#
# Example:
#   gemini_setup_vertex "AIzaSyD..."
gemini_setup_vertex() {
  local api_key=$1

  if [[ -z "$api_key" ]]; then
    echo "Error: Google API key is required" >&2
    echo "" >&2
    echo "Usage: gemini_setup_vertex <google-api-key>" >&2
    echo "" >&2
    echo "Get your API key from Google Cloud Console" >&2
    echo "" >&2
    echo "Example:" >&2
    echo "  gemini_setup_vertex \"AIzaSyD...\"" >&2
    return 1
  fi

  export GOOGLE_API_KEY="$api_key"
  export GOOGLE_GENAI_USE_VERTEXAI=true

  echo "✓ Gemini configured for Vertex AI"
  echo "  Google API Key: ${GOOGLE_API_KEY:0:20}..."
  echo "  Vertex AI Mode: enabled"
  echo ""
  echo "Note: Add these to your ~/.zshrc or ~/.bashrc to make them permanent:"
  echo "  export GOOGLE_API_KEY=\"$GOOGLE_API_KEY\""
  echo "  export GOOGLE_GENAI_USE_VERTEXAI=true"
}

# Install Gemini CLI via npm
# Usage: gemini_install
#
# Example:
#   gemini_install
gemini_install() {
  if ! npm_installed; then
    echo "✗ npm is not installed" >&2
    echo "  Please install Node.js and npm first" >&2
    echo "  Visit: https://nodejs.org/" >&2
    return 1
  fi

  echo "Installing Gemini CLI via npm..."
  if npm install -g @google/gemini-cli; then
    echo "✓ Gemini CLI installed successfully"
    echo ""
    echo "You may need to restart your terminal or run:"
    echo "  source ~/.zshrc  # or ~/.bashrc"
  else
    echo "✗ Failed to install Gemini CLI" >&2
    return 1
  fi
}

# Show Gemini CLI status
# Usage: gemini_status
#
# Example:
#   gemini_status
gemini_status() {
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Gemini CLI Status"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check npm installation
  if npm_installed; then
    echo "✓ npm installed"
    local npm_version
    npm_version=$(npm --version 2>/dev/null || echo "unknown")
    echo "  Version: $npm_version"
  else
    echo "✗ npm not installed"
    echo "  Please install Node.js and npm first"
    echo "  Visit: https://nodejs.org/"
  fi

  echo ""

  # Check Gemini CLI installation
  if gemini_installed; then
    echo "✓ Gemini CLI installed"
    local gemini_version
    gemini_version=$(gemini --version 2>/dev/null || echo "unknown")
    echo "  Version: $gemini_version"
  else
    echo "✗ Gemini CLI not installed"
    echo "  Run: gemini_install"
  fi

  echo ""

  # Check API configuration
  local configured=false

  if gemini_api_configured; then
    echo "✓ Gemini API configured (AI Studio mode)"
    echo "  API Key: ${GEMINI_API_KEY:0:20}..."
    configured=true
  fi

  if gemini_vertex_configured; then
    echo "✓ Vertex AI configured"
    echo "  Google API Key: ${GOOGLE_API_KEY:0:20}..."
    echo "  Vertex AI Mode: enabled"
    configured=true
  fi

  if [[ "$configured" == "false" ]]; then
    echo "✗ No API configuration found"
    echo ""
    echo "  Configure for AI Studio:"
    echo "    gemini_setup_api <api-key>"
    echo "    Get key: https://aistudio.google.com/apikey"
    echo ""
    echo "  Or configure for Vertex AI:"
    echo "    gemini_setup_vertex <google-api-key>"
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Useful aliases
alias gemini-status='gemini_status'
alias gemini-config-api='gemini_setup_api'
alias gemini-config-vertex='gemini_setup_vertex'
alias gemini-install='gemini_install'
