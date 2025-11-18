# Oh My Org

A delightful terminal organization framework inspired by oh-my-zsh, with automatic git updates, plugin system, and theme support for bash and zsh.

## Features

- **Auto-Update**: Automatically checks for and pulls the latest updates from git every time you open your terminal
- **Plugin System**: Extend functionality with a modular plugin architecture
- **Theme Support**: Customize your terminal prompt with themes
- **Cross-Shell**: Works with both bash and zsh
- **Lightweight**: Minimal overhead on shell startup
- **Extensible**: Easy to create custom plugins and themes

## Installation

### Quick Install

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/curioussingularity/oh-my-org/main/tools/install.sh)"
```

Or with wget:

```bash
bash -c "$(wget -qO- https://raw.githubusercontent.com/curioussingularity/oh-my-org/main/tools/install.sh)"
```

### Manual Installation

1. Clone the repository:
```bash
git clone https://github.com/curioussingularity/oh-my-org.git ~/.oh-my-org
```

2. Add to your shell configuration (`~/.zshrc` or `~/.bashrc`):
```bash
# Oh My Org Configuration
export OMO_DIR="$HOME/.oh-my-org"
export OMO_AUTO_UPDATE=true
export OMO_UPDATE_CHECK_INTERVAL=86400  # 24 hours

# Optional: Set theme
# export OMO_THEME="default"

# Optional: Enable plugins
# export OMO_PLUGINS=(git docker)

# Source Oh My Org
source "$OMO_DIR/oh-my-org.sh"
```

3. Restart your terminal or run:
```bash
source ~/.zshrc  # or ~/.bashrc
```

## Configuration

### Auto-Update Settings

Oh My Org automatically checks for updates every time you open a new terminal session. You can configure this behavior:

```bash
# Disable auto-update
export OMO_AUTO_UPDATE=false

# Change update check interval (in seconds)
export OMO_UPDATE_CHECK_INTERVAL=43200  # 12 hours
```

### Manual Update

You can manually trigger an update at any time:

```bash
omo_update
```

### Plugins

Enable plugins by adding them to the `OMO_PLUGINS` array in your shell configuration:

```bash
export OMO_PLUGINS=(git docker kubectl)
```

#### Available Plugins

- **git**: Git aliases and functions
  - Aliases: `g`, `ga`, `gc`, `gco`, `gst`, `glog`, etc.
  - Functions: `gclean`, `gbranch`, `gremote`

- **docker**: Docker and Docker Compose aliases
  - Aliases: `d`, `dc`, `dps`, `di`, `dexec`, etc.
  - Functions: `dcleanup`, `dstopall`, `drmall`

#### Creating Custom Plugins

1. Create a plugin directory in `~/.oh-my-org/custom/plugins/`:
```bash
mkdir -p ~/.oh-my-org/custom/plugins/myplugin
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
export OMO_PLUGINS=(myplugin)
```

### Themes

Set your theme by exporting the `OMO_THEME` variable:

```bash
export OMO_THEME="default"
```

#### Available Themes

- **default**: Clean and simple prompt with git branch display

#### Creating Custom Themes

1. Create a theme file in `~/.oh-my-org/custom/themes/`:
```bash
touch ~/.oh-my-org/custom/themes/mytheme.theme.sh
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
export OMO_THEME="mytheme"
```

### Custom Configurations

Add your custom shell configurations in `~/.oh-my-org/custom/custom.sh`. This file is sourced after all plugins and themes, allowing you to override or extend functionality.

## Commands

- `omo_update` - Manually check for and install updates
- `omo_list_plugins` - List all available plugins
- `omo_list_themes` - List all available themes

## Uninstallation

Run the uninstall script:

```bash
bash ~/.oh-my-org/tools/uninstall.sh
```

This will remove Oh My Org and clean up your shell configuration.

## How Auto-Update Works

1. Every time you open a new terminal, Oh My Org checks if it's time to check for updates (based on `OMO_UPDATE_CHECK_INTERVAL`)
2. If it's time, it runs `git fetch` in the background to check for new commits
3. If updates are available, it automatically pulls the latest changes
4. The update process runs asynchronously to avoid slowing down terminal startup
5. A timestamp is stored in `~/.oh-my-org/.last_update_check` to track the last check time

## Directory Structure

```
~/.oh-my-org/
├── oh-my-org.sh          # Main initialization script
├── lib/                  # Core library
│   ├── utils.sh          # Utility functions
│   ├── auto-update.sh    # Auto-update functionality
│   ├── plugin-loader.sh  # Plugin loading system
│   └── theme-loader.sh   # Theme loading system
├── plugins/              # Default plugins
│   ├── git/
│   └── docker/
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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Inspired by [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- Thanks to all contributors who help improve this project

## Support

If you encounter any issues or have questions, please [open an issue](https://github.com/curioussingularity/oh-my-org/issues) on GitHub.
