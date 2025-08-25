#!/usr/bin/env bash

# Function to perform tasks requiring sudo privileges
sudo_tasks() {
    echo "Running sudo tasks..."

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
}

# Execute the sudo tasks function
sudo_tasks