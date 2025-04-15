#!/usr/bin/env bash

# Functions for sudo and non-sudo tasks
sudo_tasks() {
    # Update and install essential tools
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y \
        git \
        tmux \
        vim \
        ssh \
        speedtest-cli \
        htop \
        cpufrequtils \
        lm-sensors \
        fontconfig \
        zsh \
        powerline \
        fonts-powerline \
        unzip \
        fd-find \
        net-tools \
        tree \
        curl \
        wget \
        neofetch \
        nvtop

    # Load and configure kernel modules
    sudo modprobe drivetemp
    echo drivetemp | sudo tee -a /etc/modules

    # Install lsd and uv
    sudo snap install lsd

    # Set Zsh as default shell
    echo -e "[ -f /usr/bin/zsh ] && exec /usr/bin/zsh" >> ~/.bashrc
}

non_sudo_tasks() {
    # Install uv package manager
    curl -LsSf https://astral.sh/uv/install.sh | sh

    # Install Nerd Fonts
    FONT_DIR="$HOME/.local/share/fonts"
    FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.0-RC/Meslo.zip"
    rm -rf "$FONT_DIR"
    mkdir -p "$FONT_DIR"
    wget -q "$FONT_URL" -O Meslo.zip
    unzip -q Meslo.zip -d "$FONT_DIR"
    rm Meslo.zip
    find "$FONT_DIR" -name "*Windows*" -delete
    fc-cache -fv

    # Install zsh
    bash "$(dirname "$0")/install_zsh.sh"

    # Install and configure Oh My Zsh
    rm -rf ~/.oh-my-zsh
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting --depth 1
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions --depth 1

    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    sed -i '0,/ZSH_THEME/{/ZSH_THEME/d}' ~/.zshrc

    cat ~/.zshrc > .tmp
    rm ~/.zshrc

tee -a ~/.zshrc << END
# custom
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
END

    cat .tmp >> ~/.zshrc
    rm .tmp

tee -a ~/.zshrc << END
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
END

    # Configure p10k
    echo -e "[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh" >> ~/.zshrc
    cp $(dirname "$0")/.p10k.zsh $HOME/

    # Install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all

    # Configure Vim
rm ~/.vimrc
tee -a ~/.vimrc << END
"set showcmd            " Show (partial) command in status line.
set showmatch          " Show matching brackets.
set ignorecase         " Do case insensitive matching
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a            " Enable mouse usage (all modes)
set number             " Show line numbers
set hlsearch           " Highlight search results
END

    echo -e "source $HOME/oh-my-org/src/main.sh" >> ~/.zshrc
}

# Main script execution
if [ "$EUID" -ne 0 ]; then
    echo "Running non-sudo tasks..."
    non_sudo_tasks
    echo "To complete the setup, please run the script with sudo for the remaining tasks."
else
    echo "Running sudo tasks..."
    sudo_tasks
fi
