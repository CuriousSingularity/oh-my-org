# !/usr/bin/env bash

# Reference: https://github.com/google-gemini/gemini-cli
# Export the following environment variable to enable Gemini CLI

# Gemini API Key - Get your key from https://aistudio.google.com/apikey
export GEMINI_API_KEY="YOUR_API_KEY"

# # Get your key from Google Cloud Console
export GOOGLE_API_KEY="YOUR_API_KEY"
export GOOGLE_GENAI_USE_VERTEXAI=true

npm install -g @google/gemini-cli

