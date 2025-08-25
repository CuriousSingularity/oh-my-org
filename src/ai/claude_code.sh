#!/usr/bin/env bash

# Reference: 
#   https://docs.anthropic.com/en/docs/claude-code/setup
#   https://github.com/Njengah/claude-code-cheat-sheet
#   https://github.com/disler/claude-code-hooks-mastery

# Export the following environment variables to enable Claude CLI
# Enable Vertex AI integration (replace with your actual values)
export GOOGLE_APPLICATION_CREDENTIALS="path/to/your/service-account-key.json"
export CLAUDE_CODE_USE_VERTEX=1
export CLOUD_ML_REGION="europe-west1"
export ANTHROPIC_VERTEX_PROJECT_ID="your-project-id"

curl -fsSL https://claude.ai/install.sh | bash
