# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Oh My Org is a terminal organization framework inspired by oh-my-zsh. It provides:
- Automatic git-based updates on terminal startup
- Plugin system for extending functionality
- Theme system for customizing the terminal prompt
- Cross-shell support (bash and zsh)

## Architecture

### Core Components

1. **oh-my-org.sh** - Main entry point
   - Sets up environment variables
   - Sources library components
   - Triggers auto-update check (in background)
   - Loads themes and plugins
   - Sources custom user configurations

2. **lib/** - Core library functions
   - `utils.sh`: Utility functions (logging, colors, helpers)
   - `auto-update.sh`: Git-based auto-update system
   - `plugin-loader.sh`: Plugin discovery and loading
   - `theme-loader.sh`: Theme discovery and loading

3. **plugins/** - Default plugins (git, docker)
   - Each plugin is in its own directory
   - Plugin files named `{name}.plugin.sh`
   - Custom plugins go in `custom/plugins/`

4. **themes/** - Theme files
   - Theme files named `{name}.theme.sh`
   - Custom themes go in `custom/themes/`

5. **tools/** - Installation and management scripts
   - `install.sh`: Installation script
   - `uninstall.sh`: Uninstallation script

### Auto-Update System

The auto-update mechanism is a core feature:

1. Runs on every shell initialization (if enabled)
2. Checks timestamp in `.last_update_check` against `OMO_UPDATE_CHECK_INTERVAL`
3. If interval has passed:
   - Runs `git fetch origin` to check for updates
   - Compares local and remote HEAD commits
   - If different, runs `git pull --rebase` to update
4. Runs in background (`&!`) to avoid blocking shell startup
5. Users can disable via `OMO_AUTO_UPDATE=false`
6. Manual updates available via `omo_update` command

### Plugin System

Plugins are bash/zsh scripts that extend functionality:

- Loaded via `omo_load_plugins()` in plugin-loader.sh
- Searches custom plugins first, then default plugins
- Plugin file must be named `{plugin-name}.plugin.sh`
- Enabled via `OMO_PLUGINS` array in user's shell RC file

### Theme System

Themes customize the terminal prompt:

- Loaded via `omo_load_theme()` in theme-loader.sh
- Searches custom themes first, then default themes
- Theme file must be named `{theme-name}.theme.sh`
- Themes set `PS1` (bash) or `PROMPT` (zsh)
- Should handle both bash and zsh syntax

## Development Commands

### Testing Changes

Since this is a shell framework, testing requires sourcing scripts:

```bash
# Test main script
source ./oh-my-org.sh

# Test specific library
source ./lib/auto-update.sh

# Test plugin
source ./plugins/git/git.plugin.sh
```

### Creating New Plugins

1. Create directory: `mkdir -p plugins/{plugin-name}`
2. Create plugin file: `plugins/{plugin-name}/{plugin-name}.plugin.sh`
3. Add aliases, functions, or configurations
4. Test by adding to `OMO_PLUGINS` array

### Creating New Themes

1. Create theme file: `themes/{theme-name}.theme.sh`
2. Define prompt for both bash and zsh
3. Use escape sequences for colors
4. Test with `export OMO_THEME="{theme-name}"`

### File Permissions

Installation and tool scripts must be executable:
```bash
chmod +x tools/*.sh
```

## Key Design Decisions

1. **Background Updates**: Auto-update runs in background (`&!`) to prevent shell startup delay
2. **Interval-Based Checking**: Uses timestamp file to avoid checking on every shell start
3. **Graceful Degradation**: Features fail silently if git is not available
4. **Custom Directory**: All user customizations in `custom/` to avoid git conflicts
5. **Shell Detection**: Runtime detection of bash vs zsh for compatibility
6. **Stash Before Update**: Automatically stashes local changes before git pull

## Common Patterns

### Adding Utility Functions

Add to `lib/utils.sh`:
```bash
omo_new_function() {
  # Use omo_ prefix for all functions
  # Use omo_info, omo_success, omo_warning, omo_error for logging
}
```

### Color Usage

Use defined color variables from `lib/utils.sh`:
- `OMO_COLOR_GREEN` - Success messages
- `OMO_COLOR_YELLOW` - Warnings
- `OMO_COLOR_RED` - Errors
- `OMO_COLOR_BLUE` - Info messages
- `OMO_COLOR_RESET` - Reset to default

### Environment Variables

All Oh My Org environment variables use `OMO_` prefix:
- `OMO_DIR` - Installation directory
- `OMO_AUTO_UPDATE` - Enable/disable auto-update
- `OMO_UPDATE_CHECK_INTERVAL` - Update check interval in seconds
- `OMO_THEME` - Current theme name
- `OMO_PLUGINS` - Array of enabled plugins

## Testing Considerations

- Test with both bash and zsh
- Test with git available and unavailable
- Test with network available and unavailable
- Test installation on clean system
- Test upgrade path from previous versions
- Verify auto-update doesn't block shell startup

## Code Style

- Use `#!/usr/bin/env bash` shebang
- Use `set -e` in installation scripts for safety
- Prefix all functions with `omo_`
- Use lowercase with underscores for variables
- Add comments for non-obvious logic
- Use double brackets `[[ ]]` for conditionals
- Quote variables to handle spaces: `"$VAR"`
