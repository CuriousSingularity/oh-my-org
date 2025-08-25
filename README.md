# oh-my-org (Organize)

<p align="center">
    <img src="./docs/logo.png" alt="alt text" width="350" height="auto">
</p>

oh-my-org is a terminal integration tool that automatically checks for updates from a Git repository whenever a terminal session is initiated. It provides useful aliases, helper functions, and widgets to enhance your terminal experience while ensuring you always have the latest version of scripts and configurations.

## Features

- **Auto-update**: Automatically pulls the latest changes from the Git repository on terminal startup
- **Shell Integration**: Seamless integration with bash and zsh shells
- **Utility Functions**: Helpful functions for directory navigation, calculations, and file operations
- **Git Aliases**: Convenient shortcuts for common Git operations
- **Docker Shortcuts**: Quick aliases for Docker container and image management
- **Python Environment Management**: Easy virtual environment creation and management with uv
- **Weather Widget**: Terminal-based weather information display
- **Tool Installation Scripts**: Automated setup for development tools and CLI utilities

## Installation

To install oh-my-org, run the following command in your terminal:

```bash
bash <(curl -s https://raw.githubusercontent.com/CuriousSingularity/oh-my-org/main/install.sh)
```

This command will:

1. Create the necessary directory under `~/.oh-my-org`.
2. Set up the main script to run on terminal startup.

## Usage

### Automatic Features
Once installed, oh-my-org will automatically:
- Check for updates every time you open a new terminal session
- Load all utility functions and aliases
- Display weather information for your configured location

### Available Commands

#### Git Shortcuts
```bash
gita    # git add .
gitb    # git branch
gitc    # git commit -m
gitco   # git checkout
gitd    # git diff
gitl    # git log --oneline --graph --decorate
gitp    # git pull
gits    # git status
gitr    # git remote -v
```

#### Python Environment Management
```bash
uvc [version] [dir]  # Create and activate virtual environment
uvu                  # Install dependencies
uvk [dir]           # Install IPython kernel
uvf [version] [dir] # Full setup (create, install, kernel)
uva [dir]           # Activate environment
uvd                 # Deactivate environment
uvr [dir]           # Remove environment
```

#### Utility Functions
```bash
up [levels]              # Navigate up directory levels
percentage <old> <new>   # Calculate percentage change
mul <num1> <num2>       # Multiply numbers
div <num1> <num2>       # Divide numbers
run <times> <command>   # Run command multiple times
swap <file1> <file2>    # Swap two files
wttr [city] [level]     # Get weather information
```

### Configuration
You can customize the behavior by modifying scripts in the `src/` directory:
- `src/main.sh` - Main entry point and update logic
- `src/utils/aliases.sh` - Command aliases
- `src/utils/helpers.sh` - Utility functions
- `src/utils/env.sh` - Environment management

## Security

For security considerations and reporting vulnerabilities, please see our [Security Policy](SECURITY.md).

## Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) for details on how to submit pull requests, report issues, and contribute to the project.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.