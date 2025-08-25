#!/usr/bin/env bash

DEFAULT_PYTHON_VERSION=3.8

# Create and activate a Python virtual environment with a specified version (default is 3.8)
uvc() {
    local ver_py=${1:-$DEFAULT_PYTHON_VERSION}
    local venv_dir=${2:-.venv}
    uv venv -p "$ver_py" "$venv_dir" && source "$venv_dir/bin/activate"
}

# Install and activate dependencies in the current virtual environment
uvu() {
    uv pip install --upgrade pip && uv pip install -e .
}

# Install the IPython kernel for the current virtual environment
# Usage: uvk [venv_dir]
# If no venv_dir is provided, defaults to '.venv'
uvk() {
    local venv_dir=${1:-.venv}
    uv pip install ipykernel
    uv run ipython kernel install --user --name="$(basename "$venv_dir")"
}

# Full installation and setup of the environment
uvf() {
    local ver_py=${1:-$DEFAULT_PYTHON_VERSION}
    local venv_dir=${2:-.venv}
    uvc "$ver_py" "$venv_dir" && uvu && uvk "$venv_dir"
}

# Remove the virtual environment
uvr() {
    local venv_dir=${1:-.venv}
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    fi
    rm -rf "$venv_dir"
}

# Activate the virtual environment
uva() {
    local venv_dir=${1:-.venv}
    source "$venv_dir/bin/activate"
}

# Deactivate the current virtual environment
uvd() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    fi
}