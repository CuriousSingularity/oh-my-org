# oh-my-org (Organize)

<p align="center">
    <img src="./docs/logo.png" alt="alt text" width="350" height="auto">
</p>

oh-my-org is a terminal integration tool with helpful scripts that automatically checks for updates from a specified Git repository whenever a terminal session is initiated. This project aims to enhance the terminal experience by ensuring that you always have the latest version of your scripts and configurations.

## Features

- Automatically pulls the latest changes from the Git repository on terminal startup.
- Simple installation process.
- Utility functions for managing updates and handling merge conflicts.

## Installation

To install oh-my-org, run the following command in your terminal:

```bash
bash <(curl -s https://raw.githubusercontent.com/CuriousSingularity/oh-my-org/main/install.sh)
```

This command will:

1. Create the necessary directory under `~/.oh-my-org`.
2. Set up the main script to run on terminal startup.

## Usage

Once installed, oh-my-org will automatically check for updates every time you open a new terminal session. You can customize the behavior by modifying the `src/main.sh` script.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.