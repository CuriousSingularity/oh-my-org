#!/bin/bash

set -e

cd $HOME

# Define the installation directory
INSTALL_DIR="$HOME/zsh_install"
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

# OPTIONAL: zsh will not install without ncurses. IF your machine doesn't have ncurses, you need to install it first.
export CXXFLAGS=" -fPIC" CFLAGS=" -fPIC" CPPFLAGS="-I${INSTALL_DIR}/include" LDFLAGS="-L${INSTALL_DIR}/lib"
wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.2.tar.gz
tar -xzvf ncurses-6.2.tar.gz
cd ncurses-6.2
./configure --prefix="$INSTALL_DIR" --enable-shared
make
make install
cd .. && rm ncurses-6.2.tar.gz && rm -r ncurses-6.2

# Install zsh itself
wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
mkdir zsh && unxz zsh.tar.xz && tar -xvf zsh.tar -C zsh --strip-components 1
cd zsh
./configure --prefix="$INSTALL_DIR"
make
make install
cd .. && rm zsh.tar && rm -r zsh

# Update shell configuration
echo -e "export PATH=$INSTALL_DIR/bin:\$PATH\nexport SHELL=$INSTALL_DIR/bin/zsh\nexec $INSTALL_DIR/bin/zsh -l" >> ~/.bashrc

# Return to the directory where the script was run
cd -