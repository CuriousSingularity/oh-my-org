# !/usr/bin/env bash

# Reference: https://docs.anthropic.com/en/docs/claude-code/setup
# Export the following environment variable to enable Claude CLI

# Enable Vertex AI integration
export GOOGLE_APPLICATION_CREDENTIALS=""
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION="europe-west1"
export ANTHROPIC_VERTEX_PROJECT_ID=""

curl -fsSL https://claude.ai/install.sh | bash
