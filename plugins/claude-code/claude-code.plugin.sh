#!/usr/bin/env bash
# Claude Code plugin for Oh My Dev
# Provides setup and configuration for Claude CLI with Vertex AI
#
# References:
#   https://docs.anthropic.com/en/docs/claude-code/setup
#   https://github.com/Njengah/claude-code-cheat-sheet
#   https://github.com/disler/claude-code-hooks-mastery
#
# USAGE EXAMPLES:
#
# 1. Check Claude Code installation and configuration status:
#    $ claude_status
#    or
#    $ claude-status
#
# 2. Setup Vertex AI configuration:
#    $ claude_setup_vertex ~/path/to/service-account.json my-project-id europe-west1
#    or
#    $ claude-config ~/path/to/service-account.json my-project-id
#
# 3. Install Claude CLI:
#    $ claude_install
#
# 4. Quick setup workflow:
#    $ claude_install                                    # Install Claude CLI
#    $ claude_setup_vertex ~/creds.json my-project-id    # Configure Vertex AI
#    $ claude_status                                      # Verify everything is set up
#
# 5. Save configuration in your ~/.zshrc or ~/.bashrc for persistence:
#    export GOOGLE_APPLICATION_CREDENTIALS="$HOME/service-account.json"
#    export CLAUDE_CODE_USE_VERTEX=1
#    export CLOUD_ML_REGION="europe-west1"
#    export ANTHROPIC_VERTEX_PROJECT_ID="your-project-id"
#    export OMD_PLUGINS=(git docker uv utils claude-code)

# Check if Claude Code is installed
claude_code_installed() {
  command -v claude >/dev/null 2>&1
}

# Check if Vertex AI is configured
claude_code_configured() {
  [[ -n "$GOOGLE_APPLICATION_CREDENTIALS" ]] && \
  [[ -n "$CLAUDE_CODE_USE_VERTEX" ]] && \
  [[ -n "$CLOUD_ML_REGION" ]] && \
  [[ -n "$ANTHROPIC_VERTEX_PROJECT_ID" ]]
}

# Setup Vertex AI environment variables
# Usage: claude_setup_vertex <credentials-path> <project-id> [region]
#
# Arguments:
#   credentials-path: Path to your Google Cloud service account JSON key file
#   project-id:       Your Google Cloud project ID
#   region:           Google Cloud region (default: europe-west1)
#
# Example:
#   claude_setup_vertex ~/service-account.json my-project-id
#   claude_setup_vertex ~/service-account.json my-project-id us-central1
claude_setup_vertex() {
  local creds_path=$1
  local project_id=$2
  local region=${3:-europe-west1}

  if [[ -z "$creds_path" ]] || [[ -z "$project_id" ]]; then
    echo "Error: Missing required arguments" >&2
    echo "" >&2
    echo "Usage: claude_setup_vertex <credentials-path> <project-id> [region]" >&2
    echo "" >&2
    echo "Arguments:" >&2
    echo "  credentials-path  Path to Google Cloud service account JSON key" >&2
    echo "  project-id        Google Cloud project ID" >&2
    echo "  region            Google Cloud region (default: europe-west1)" >&2
    echo "" >&2
    echo "Example:" >&2
    echo "  claude_setup_vertex ~/service-account.json my-project-id" >&2
    return 1
  fi

  if [[ ! -f "$creds_path" ]]; then
    echo "Error: Credentials file not found: $creds_path" >&2
    return 1
  fi

  export GOOGLE_APPLICATION_CREDENTIALS="$creds_path"
  export CLAUDE_CODE_USE_VERTEX=1
  export CLOUD_ML_REGION="$region"
  export ANTHROPIC_VERTEX_PROJECT_ID="$project_id"

  echo "✓ Claude Code Vertex AI configured:"
  echo "  Credentials: $GOOGLE_APPLICATION_CREDENTIALS"
  echo "  Project ID:  $ANTHROPIC_VERTEX_PROJECT_ID"
  echo "  Region:      $CLOUD_ML_REGION"
  echo ""
  echo "Note: Add these to your ~/.zshrc or ~/.bashrc to make them permanent:"
  echo "  export GOOGLE_APPLICATION_CREDENTIALS=\"$GOOGLE_APPLICATION_CREDENTIALS\""
  echo "  export CLAUDE_CODE_USE_VERTEX=1"
  echo "  export CLOUD_ML_REGION=\"$CLOUD_ML_REGION\""
  echo "  export ANTHROPIC_VERTEX_PROJECT_ID=\"$ANTHROPIC_VERTEX_PROJECT_ID\""
}

# Install Claude CLI
# Usage: claude_install
#
# Example:
#   claude_install
claude_install() {
  echo "Installing Claude Code CLI..."
  if curl -fsSL https://claude.ai/install.sh | bash; then
    echo "✓ Claude Code CLI installed successfully"
    echo ""
    echo "You may need to restart your terminal or run:"
    echo "  source ~/.zshrc  # or ~/.bashrc"
  else
    echo "✗ Failed to install Claude Code CLI" >&2
    return 1
  fi
}

# Show Claude Code status
# Usage: claude_status
#
# Example:
#   claude_status
claude_status() {
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Claude Code Status"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""

  # Check CLI installation
  if claude_code_installed; then
    echo "✓ Claude CLI installed"
    local version
    version=$(claude --version 2>/dev/null || echo "unknown")
    echo "  Version: $version"
  else
    echo "✗ Claude CLI not installed"
    echo "  Run: claude_install"
  fi

  echo ""

  # Check Vertex AI configuration
  if claude_code_configured; then
    echo "✓ Vertex AI configured"
    echo "  Project:     $ANTHROPIC_VERTEX_PROJECT_ID"
    echo "  Region:      $CLOUD_ML_REGION"
    echo "  Credentials: $GOOGLE_APPLICATION_CREDENTIALS"

    # Verify credentials file exists
    if [[ -f "$GOOGLE_APPLICATION_CREDENTIALS" ]]; then
      echo "  Creds File:  ✓ exists"
    else
      echo "  Creds File:  ✗ not found"
    fi
  else
    echo "✗ Vertex AI not configured"
    echo ""
    echo "  Missing environment variables:"
    [[ -z "$GOOGLE_APPLICATION_CREDENTIALS" ]] && echo "    - GOOGLE_APPLICATION_CREDENTIALS"
    [[ -z "$CLAUDE_CODE_USE_VERTEX" ]] && echo "    - CLAUDE_CODE_USE_VERTEX"
    [[ -z "$CLOUD_ML_REGION" ]] && echo "    - CLOUD_ML_REGION"
    [[ -z "$ANTHROPIC_VERTEX_PROJECT_ID" ]] && echo "    - ANTHROPIC_VERTEX_PROJECT_ID"
    echo ""
    echo "  Setup with:"
    echo "    claude_setup_vertex <creds-path> <project-id> [region]"
  fi

  echo ""
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Useful aliases
alias claude-status='claude_status'
alias claude-config='claude_setup_vertex'
alias claude-install='claude_install'
