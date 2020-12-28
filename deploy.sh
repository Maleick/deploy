#!/bin/bash

# Author: Maleick
# Version: 1.0
# Update: 12/27/20
# Deploy Digital Ocean setup

cat << "EOF"
██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗   ██╗   ███████╗██╗  ██╗
██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝   ██╔════╝██║  ██║
██║  ██║█████╗  ██████╔╝██║     ██║   ██║ ╚████╔╝    ███████╗███████║
██║  ██║██╔══╝  ██╔═══╝ ██║     ██║   ██║  ╚██╔╝     ╚════██║██╔══██║
██████╔╝███████╗██║     ███████╗╚██████╔╝   ██║   ██╗███████║██║  ██║
╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝  ╚═╝
EOF

# Colors
blue=$'\e[0;94m'
green=$'\e[1;92m'
red=$'\e[0;91m'
white=$'\e[0m'

# Updates
echo "$green Deploying Updates $white"
apt update
apt install at bc build-essential mingw-w64 nmap openjdk-11-jdk wine zsh zsh-autosuggestions zsh-syntax-highlighting -y
apt full-upgrade -y
apt autoremove

# Clone all the things
echo "$green Deploy the Clones $white"
git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket; cd /opt/impacket; pip install .
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit
git clone https://github.com/lgandx/Responder.git /opt/Responder
gem install evil-winrm

# Dotfiles
echo "$green Deploy Dotfiles $white"
git clone https://github.com/Maleick/dotfiles /opt/dotfiles
cp /opt/dotfiles/tmux/.tmux.conf ~
cp /opt/dotfiles/vim/.vimrc ~
cp /opt/dotfiles/zsh/.zshrc ~

