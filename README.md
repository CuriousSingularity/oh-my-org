# 🎯 Oh My Dev

```
  ██████╗  ██╗  ██╗
 ██╔═══██╗ ██║  ██║
 ██║   ██║ ███████║
 ██║   ██║ ██╔══██║
 ╚██████╔╝ ██║  ██║
  ╚═════╝  ╚═╝  ╚═╝

 ███╗   ███╗ ██╗   ██╗
 ████╗ ████║ ╚██╗ ██╔╝
 ██╔████╔██║  ╚████╔╝
 ██║╚██╔╝██║   ╚██╔╝
 ██║ ╚═╝ ██║    ██║
 ╚═╝     ╚═╝    ╚═╝

 ██████╗  ███████╗ ██╗   ██╗
 ██╔══██╗ ██╔════╝ ██║   ██║
 ██║  ██║ █████╗   ██║   ██║
 ██║  ██║ ██╔══╝   ╚██╗ ██╔╝
 ██████╔╝ ███████╗  ╚████╔╝
 ╚═════╝  ╚══════╝   ╚═══╝
```

[![CI](https://github.com/curioussingularity/oh-my-dev/workflows/CI/badge.svg)](https://github.com/curioussingularity/oh-my-dev/actions/workflows/ci.yml)
[![Release](https://github.com/curioussingularity/oh-my-dev/workflows/Release/badge.svg)](https://github.com/curioussingularity/oh-my-dev/actions/workflows/release.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**A powerful developer productivity framework for your terminal.** Inspired by oh-my-zsh, Oh My Dev supercharges your development workflow with automatic git updates, a rich plugin ecosystem, and customizable themes for bash and zsh. Built by developers, for developers.

## ✨ Features

- **🔄 Auto-Update**: Automatically checks for and pulls the latest updates from git every time you open your terminal
- **🔌 Plugin System**: Extend functionality with a modular plugin architecture
- **🎨 Theme Support**: Customize your terminal prompt with themes
- **🐚 Cross-Shell**: Works with both bash and zsh
- **⚡ Lightweight**: Minimal overhead on shell startup
- **🔧 Extensible**: Easy to create custom plugins and themes

## 📦 Installation

### ⚡ Quick Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/curioussingularity/oh-my-dev/main/tools/install.sh)"
```

Or with wget:

```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/curioussingularity/oh-my-dev/main/tools/install.sh)"
```

### 🔨 Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/curioussingularity/oh-my-dev.git ~/.oh-my-dev
```

2. Add to your shell configuration (`~/.zshrc` or `~/.bashrc`):
```bash
# Oh My Dev Configuration
export OMD_DIR="$HOME/.oh-my-dev"
export OMD_AUTO_UPDATE=true
export OMD_UPDATE_CHECK_INTERVAL=86400  # 24 hours

# Optional: Set theme
# export OMD_THEME="default"

# Optional: Enable plugins
# export OMD_PLUGINS=(git docker uv utils claude-code gemini devtools)

# Source Oh My Dev
source "$OMD_DIR/oh-my-dev.sh"
```

3. Restart your terminal or run:
```bash
source ~/.zshrc  # or ~/.bashrc
```

## ⚙️ Configuration

### 🔄 Auto-Update Settings

Oh My Dev automatically checks for updates every time you open a new terminal session. You can configure this behavior:

```bash
# Disable auto-update
export OMD_AUTO_UPDATE=false

# Change update check interval (in seconds)
export OMD_UPDATE_CHECK_INTERVAL=43200  # 12 hours
```

### 🔄 Manual Update

You can manually trigger an update at any time:

```bash
omd_update
```

### 🔌 Plugins

Enable plugins by adding them to the `OMD_PLUGINS` array in your shell configuration:

```bash
export OMD_PLUGINS=(git docker uv utils claude-code gemini devtools)
```

#### 📚 Available Plugins

- **📂 git**: Git aliases and functions
  - Aliases: `g`, `ga`, `gc`, `gco`, `gst`, `glog`, etc.
  - Functions: `gclean`, `gbranch`, `gremote`

- **🐳 docker**: Docker and Docker Compose aliases
  - Aliases: `d`, `dc`, `dps`, `di`, `dexec`, etc.
  - Functions: `dcleanup`, `dstopall`, `drmall`

- **🐍 uv**: Python virtual environment management with UV
  - `uvc [python_version] [venv_dir]` - Create and activate venv (default: 3.8, .venv)
  - `uvu` - Install/upgrade dependencies from current project
  - `uvk [venv_dir]` - Install IPython kernel for Jupyter
  - `uvf [python_version] [venv_dir]` - Full setup (create + install + kernel)
  - `uvr [venv_dir]` - Remove virtual environment
  - `uva [venv_dir]` - Activate virtual environment
  - `uvd` - Deactivate current virtual environment
  - `uve <extra_name>` - Install dependencies with extras (e.g., `uve dev`)

- **🛠️ utils**: General-purpose shell utilities for productivity
  - **Navigation:**
    - `up [levels]` - Go up N directory levels (default: 1)
    - `cd <path>` - Enhanced cd that handles files (goes to parent directory)
  - **Math:**
    - `percentage <original> <new>` - Calculate percentage change
    - `percentage_value <number> <percent>` - Apply percentage change
    - `mul <num1> <num2>` - Multiply two numbers
    - `div <dividend> <divisor>` - Divide two numbers
  - **File Operations:**
    - `swap <file1> <file2>` - Swap names of two files/directories
    - `replace <search> <replace> [ext] [-i]` - Find and replace in files
    - `pack <files...>` - Create tar archive
    - `packz <files...>` - Create compressed tar.gz archive
    - `unpack <archive>` - Extract tar archives (.tar, .tar.gz, .tar.bz2)
  - **Productivity:**
    - `run <times> <command> [args]` - Run command N times
    - `tmuxn <session_name>` - Create or attach to tmux session

- **🤖 claude-code**: Claude CLI setup and Vertex AI configuration
  - `claude_install` - Install Claude CLI
  - `claude_setup_vertex <creds-path> <project-id> [region]` - Configure Vertex AI
  - `claude_status` - Show installation and configuration status
  - Aliases: `claude-install`, `claude-config`, `claude-status`
  - References: [Claude Code Setup](https://docs.anthropic.com/en/docs/claude-code/setup)

- **✨ gemini**: Google Gemini CLI setup and configuration
  - `gemini_install` - Install Gemini CLI via npm
  - `gemini_setup_api <api-key>` - Configure API key for AI Studio
  - `gemini_setup_vertex <google-api-key>` - Configure for Vertex AI
  - `gemini_status` - Show installation and configuration status
  - Aliases: `gemini-install`, `gemini-config-api`, `gemini-config-vertex`, `gemini-status`
  - References: [Gemini CLI](https://github.com/google-gemini/gemini-cli) | [Get API Key](https://aistudio.google.com/apikey)

- **🔧 devtools**: Developer tools installation and management
  - **System Tools (require sudo):**
    - `devtools_install_essentials` - Core dev tools (git, vim, tmux, curl, wget, tree, unzip)
    - `devtools_install_system` - System monitoring (htop, nvtop, neofetch, sensors, cpufrequtils)
    - `devtools_install_shell` - Shell enhancements (zsh, powerline, fonts)
    - `devtools_install_modern` - Modern CLI tools (lsd, fd-find)
    - `devtools_install_network` - Network utilities (speedtest-cli, net-tools)
    - `devtools_install_all` - Install all system tools at once
  - **User-space Tools (no sudo required):**
    - `devtools_install_uv` - UV Python package manager
    - `devtools_install_fonts` - Nerd Fonts (Meslo) for terminal
    - `devtools_install_ohmyzsh` - Oh My Zsh with powerlevel10k theme and plugins
    - `devtools_install_fzf` - Fuzzy finder for command line
    - `devtools_configure_vim` - Vim configuration with sensible defaults
    - `devtools_setup_shell` - Complete shell setup (all user tools)
  - **Management:**
    - `devtools_update` - Update all installed tools
    - `devtools_configure` - Post-install configuration (kernel modules, sensors)
    - `devtools_status` - Show installation status of all tools
  - **Aliases:** `dev-install-all`, `dev-setup-shell`, `dev-status`, `dev-update`, `dev-configure`

#### ✍️ Creating Custom Plugins

1. Create a plugin directory in `~/.oh-my-dev/custom/plugins/`:
```bash
mkdir -p ~/.oh-my-dev/custom/plugins/myplugin
```

2. Create the plugin file `myplugin.plugin.sh`:
```bash
#!/usr/bin/env bash
# My custom plugin

alias myalias="echo 'Hello from my plugin'"

my_function() {
  echo "Custom function"
}
```

3. Enable the plugin in your shell configuration:
```bash
export OMD_PLUGINS=(myplugin)
```

### 🎨 Themes

Set your theme by exporting the `OMD_THEME` variable:

```bash
export OMD_THEME="default"
```

#### 🎭 Available Themes

- **default**: Clean and simple prompt with git branch display

#### ✨ Creating Custom Themes

1. Create a theme file in `~/.oh-my-dev/custom/themes/`:
```bash
touch ~/.oh-my-dev/custom/themes/mytheme.theme.sh
```

2. Define your prompt in the theme file:
```bash
#!/usr/bin/env bash
# My custom theme

if [[ -n "$ZSH_VERSION" ]]; then
  PROMPT='%n@%m:%~ $ '
elif [[ -n "$BASH_VERSION" ]]; then
  PS1='\u@\h:\w $ '
fi
```

3. Enable the theme:
```bash
export OMD_THEME="mytheme"
```

### 🛠️ Custom Configurations

Add your custom shell configurations in `~/.oh-my-dev/custom/custom.sh`. This file is sourced after all plugins and themes, allowing you to override or extend functionality.

## 💻 Commands

- `omd_update` - Manually check for and install updates
- `omd_list_plugins` - List all available plugins
- `omd_list_themes` - List all available themes

## 🗑️ Uninstallation

Run the uninstall script:

```bash
bash ~/.oh-my-dev/tools/uninstall.sh
```

This will remove Oh My Dev and clean up your shell configuration.

## 🔍 How Auto-Update Works

1. Every time you open a new terminal, Oh My Dev checks if it's time to check for updates (based on `OMD_UPDATE_CHECK_INTERVAL`)
2. If it's time, it runs `git fetch` in the background to check for new commits
3. If updates are available, it automatically pulls the latest changes
4. The update process runs asynchronously to avoid slowing down terminal startup
5. A timestamp is stored in `~/.oh-my-dev/.last_update_check` to track the last check time

## 📁 Directory Structure

```
~/.oh-my-dev/
├── oh-my-dev.sh          # Main initialization script
├── lib/                  # Core library
│   ├── utils.sh          # Utility functions
│   ├── auto-update.sh    # Auto-update functionality
│   ├── plugin-loader.sh  # Plugin loading system
│   └── theme-loader.sh   # Theme loading system
├── plugins/              # Default plugins
│   ├── git/
│   ├── docker/
│   ├── uv/
│   ├── utils/
│   ├── claude-code/
│   ├── gemini/
│   └── devtools/
├── themes/               # Default themes
│   └── default.theme.sh
├── tools/                # Installation and management scripts
│   ├── install.sh
│   └── uninstall.sh
└── custom/               # User customizations
    ├── custom.sh
    ├── plugins/
    └── themes/
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Inspired by [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- Thanks to all contributors who help improve this project

## 💬 Support

If you encounter any issues or have questions, please [open an issue](https://github.com/curioussingularity/oh-my-dev/issues) on GitHub.
