# Contributing to oh-my-org

Thank you for your interest in contributing to oh-my-org! We welcome contributions from the community.

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/your-username/oh-my-org.git
   cd oh-my-org
   ```
3. Create a new branch for your feature or bugfix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Guidelines

### Code Style
- Follow existing code conventions and formatting
- Add proper shebang (`#!/usr/bin/env bash`) to all shell scripts
- Use meaningful variable names and add comments for complex logic
- Test your changes thoroughly before submitting

### Shell Script Best Practices
- Use `set -euo pipefail` for error handling where appropriate
- Quote variables to prevent word splitting: `"$variable"`
- Use `local` for function variables
- Provide usage examples in script headers

### File Structure
- `src/main.sh` - Main entry point, auto-update logic
- `src/utils/` - Utility functions and aliases
- `src/tools/` - Installation scripts and widgets
- `src/ai/` - AI CLI setup scripts

## Testing

Before submitting your changes:
1. Test all modified scripts manually
2. Ensure no sensitive information (API keys, credentials) is committed
3. Verify scripts work in both bash and zsh environments
4. Test the installation process if you've modified `install.sh`

## Submitting Changes

1. Commit your changes with a descriptive message:
   ```bash
   git commit -m "Add feature: description of your changes"
   ```
2. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
3. Create a Pull Request on GitHub

### Pull Request Guidelines
- Provide a clear description of what your changes do
- Reference any related issues
- Include examples of how to test your changes
- Keep pull requests focused on a single feature or fix

## Reporting Issues

When reporting issues, please include:
- Your operating system and shell version
- Steps to reproduce the issue
- Expected vs actual behavior
- Any error messages

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help create a welcoming environment for all contributors

## Questions?

Feel free to open an issue for questions about contributing or using oh-my-org.