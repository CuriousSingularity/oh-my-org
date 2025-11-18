# Contributing to Oh My Dev

Thank you for your interest in contributing to Oh My Dev! This document provides guidelines and instructions for contributing.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- A clear, descriptive title
- Steps to reproduce the bug
- Expected behavior
- Actual behavior
- Your environment (OS, shell version, etc.)

### Suggesting Features

Feature suggestions are welcome! Please open an issue with:
- A clear description of the feature
- Use cases for the feature
- Any implementation ideas you have

### Contributing Code

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes with both bash and zsh
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to your branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Guidelines

### Code Style

- Use `#!/usr/bin/env bash` shebang for all scripts
- Prefix all Oh My Dev functions with `omd_`
- Use lowercase with underscores for variable names
- Quote variables to handle spaces: `"$VAR"`
- Use double brackets `[[ ]]` for conditionals
- Add comments for non-obvious logic

### Plugin Development

When creating plugins:
- Create a directory under `plugins/{plugin-name}/`
- Create the plugin file: `{plugin-name}.plugin.sh`
- Follow the naming convention for functions and variables
- Test with both bash and zsh
- Document usage in plugin comments

### Theme Development

When creating themes:
- Create a theme file: `themes/{theme-name}.theme.sh`
- Support both bash and zsh prompts
- Use ANSI escape codes for colors
- Test in various terminal emulators
- Keep themes performant (avoid slow operations)

### Testing

Before submitting a PR:
- Test with both bash and zsh
- Test installation on a clean system
- Test with git available and unavailable
- Verify auto-update functionality works
- Check that plugins load correctly

## Questions?

If you have questions, feel free to open an issue or start a discussion.
