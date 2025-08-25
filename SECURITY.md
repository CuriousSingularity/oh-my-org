# Security Policy

## Supported Versions

We provide security updates for the latest version of oh-my-org. Please ensure you're running the most recent version.

## Security Considerations

### API Keys and Credentials
- Never commit API keys, passwords, or other sensitive information to the repository
- The AI CLI setup scripts (`src/ai/`) contain placeholder values that must be replaced with your actual credentials
- Store sensitive configuration in environment variables or secure credential stores

### Script Execution
- oh-my-org automatically executes scripts on terminal startup
- Only install from trusted sources
- Review scripts before installation, especially if modified

### Network Access
- The weather widget (`src/tools/widgets/weather.sh`) makes HTTP requests to `wttr.in`
- The main script fetches updates from the configured Git repository
- AI CLI installation scripts download and execute remote installation scripts

### File System Access
- Scripts have access to your home directory and can modify shell configuration files
- The installation process modifies `.bashrc` or `.zshrc`
- Virtual environment functions can create/delete directories

## Reporting Security Vulnerabilities

If you discover a security vulnerability, please report it by:

1. **DO NOT** open a public issue
2. Email the maintainers directly with:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

We will respond to security reports within 48 hours and work to address confirmed vulnerabilities promptly.

## Security Best Practices

### For Users
- Review scripts before installation
- Keep your installation up to date
- Use secure methods to store API keys and credentials
- Monitor what scripts are executed on terminal startup

### For Contributors
- Never commit sensitive information
- Use placeholder values for credentials in example configurations
- Follow secure coding practices for shell scripts
- Test scripts in isolated environments

## Responsible Disclosure

We follow responsible disclosure practices:
- Security issues will be addressed promptly
- We will coordinate with reporters on disclosure timing
- Credit will be given to reporters (unless they prefer to remain anonymous)
- Security fixes will be clearly documented in release notes