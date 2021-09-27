#!/bin/bash

# Update and remove unnecessary packages
apt update && apt upgrade -y && apt autoremove -y

# Install necessary packages
apt install tmux trash-cli neovim xclip zsh golang gobuster ftp -y

# Install oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Autosuggestions & syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Fetch configuration files
https://github.com/L-e-c-o/setup.git
cd setup
cp .zshrf $HOME/.zshrc
cp -r nvim $HOME/.config/
cp tmux.conf $HOME/.tmux.conf

source $HOME/.zshrc

# Cleanup
cd .. 
rm -rf setup
