#!/bin/bash

# Author: Maleick
# Version: 1.11
# Update: 7/30/20
# Purpose: Kali Minimal Install Script

cat << "EOF"
██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗   ██╗   ███████╗██╗  ██╗
██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝   ██╔════╝██║  ██║
██║  ██║█████╗  ██████╔╝██║     ██║   ██║ ╚████╔╝    ███████╗███████║
██║  ██║██╔══╝  ██╔═══╝ ██║     ██║   ██║  ╚██╔╝     ╚════██║██╔══██║
██████╔╝███████╗██║     ███████╗╚██████╔╝   ██║   ██╗███████║██║  ██║
╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝  ╚═╝
EOF

# Updates
sudo apt update && sudo apt upgrade -y
sudo apt install base64 bloodhound build-essential chromium fish git metasploit-framework mingw-w64 nmap openjdk-11-jdk python3-pip seclists vim wifite wireless-tools wireshark

# Install Repos
sudo git clone https://github.com/rbsec/dnscan.git /opt/dnscan
sudo git clone https://github.com/chinarulezzz/spoofcheck /opt/spoofcheck; cd /opt/spoofcheck; sudo pip3 install -r requirements.txt
sudo git clone https://gist.github.com/superkojiman/11076951 /opt/namemash; sudo chmod +x /opt/namemash/namemash.py
sudo git clone https://github.com/byt3bl33d3r/SprayingToolkit.git /opt/SprayingToolkit; cd /opt/SprayingToolkit; sudo pip3 install -r requirements.txt
sudo git clone https://github.com/FortyNorthSecurity/Egress-Assess.git /opt/Egress-Assess
sudo gem install evil-winrm


git clone https://github.com/fox-it/mitm6.git

git clone https://github.com/rsmudge/ElevateKit
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit; cd /opt/PowerSploit; git checkout dev


git clone https://github.com/trustedsec/cve-2019-19781.git
git clone https://github.com/dirkjanm/privexchange/
git clone https://github.com/fox-it/mitm6.git
git clone https://github.com/SecureAuthCorp/impacket.git

git clone https://github.com/D35m0nd142/LFISuite.git

git clone https://github.com/mdsecactivebreach/SharpShooter
git clone https://github.com/n00py/bhg.git
git clone https://github.com/n00py/WPForce.git
git clone https://github.com/nccgroup/demiguise.git
git clone https://github.com/nccgroup/redsnarf.git
git clone https://github.com/Ne0nd0g/merlin.git
git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git
git clone https://github.com/rebootuser/LinEnum.git
git clone https://github.com/RenwaX23/XSS-Payloads.git
git clone https://github.com/s0md3v/AwesomeXSS.git
git clone https://github.com/s0md3v/Photon.git
git clone https://github.com/Coalfire-Research/DeathMetal.git
git clone https://github.com/Raikia/UhOh365.git
git clone https://github.com/EnableSecurity/wafw00f
git clone https://github.com/dxa4481/truffleHog.git
git clone https://github.com/NinjaStyle82/bhg.git
git clone https://github.com/s0md3v/Corsy.git
git clone https://github.com/zeroSteiner/crimson-forge
git clone --recursive https://github.com/eteran/edb-debugger.git


sudo gem install evil-winrm
# Dotfiles
git clone https://github.com/Maleick/dotfiles /opt/dotfiles
cp /opt/dotfiles/zsh/.zshrc ~
cp /opt/dotfiles/tmux/.tmux.conf ~
cp /opt/dotfiles/vim/.vimrc ~

sudo systemctl enable ssh.service

sudo reboot
