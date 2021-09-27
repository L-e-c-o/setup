#!/bin/bash

# Update and remove unnecessary packages
#apt update && apt upgrade -y && apt autoremove -y

# Install necessary packages
apt install tmux trash-cli neovim xclip zsh golang gobuster ftp tree -y

# Install oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Fetch configuration files
git clone https://github.com/L-e-c-o/setup.git
cd setup
cp .zshrc $HOME/.zshrc
cp -r nvim $HOME/.config/
cp .tmux.conf $HOME/.tmux.conf
cp .tmux.conf.local $HOME/.tmux.conf.local

# Autosuggestions & syntax-highlighting
zsh -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
zsh -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /root/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

# Make zsh default shell
chsh -s /bin/zsh
source $HOME/.zshrc

# Install neovim plugins
vim +'PlugInstall --sync' +qa

# Remove banner
touch ~/.hushlogin

# Cleanup
cd .. 
rm -rf setup
