#!/bin/bash

# Author: Maleick
# Version: 1.37
# Update: 10/27/20
# Deploy Kali VMWare image setup

cat << "EOF"
██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗   ██╗   ███████╗██╗  ██╗
██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝   ██╔════╝██║  ██║
██║  ██║█████╗  ██████╔╝██║     ██║   ██║ ╚████╔╝    ███████╗███████║
██║  ██║██╔══╝  ██╔═══╝ ██║     ██║   ██║  ╚██╔╝     ╚════██║██╔══██║
██████╔╝███████╗██║     ███████╗╚██████╔╝   ██║   ██╗███████║██║  ██║
╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝  ╚═╝
EOF

# Import
. colors.sh

# Updates
echo "$green Deploying Updates $white"
apt update
apt install at bc bloodhound build-essential chromium dkms dnsmasq golang hostapd mingw-w64 openjdk-11-jdk seclists wine
apt full-upgrade
apt autoremove

# Fix pip install
echo "$green Deploying Python-pip $white"
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install configobj mitm6 pycrypto pyparsing
python3 get-pip.py
pip3 install pypykatz

# Clone all the things
echo "$green Deploy the Clones $white"
git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket; cd /opt/impacket; pip install .
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git /opt/Egress-Assess
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit
git clone https://github.com/fox-it/BloodHound.py.git /opt/BloodHound.py; cd /opt/BloodHound.py; pip install .
git clone https://github.com/s0lst1c3/eaphammer.git /opt/eaphammer
git clone https://github.com/josephkingstone/cobalt_strike_extension_kit.git /opt/cobalt_strike_extension_kit
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/winPEAS
git clone https://github.com/lgandx/Responder.git /opt/Responder
git clone --recursive https://github.com/eteran/edb-debugger.git /opt/edb-debugger
gem install evil-winrm

# Setup SSH
echo "$green Deploy SSH $white"
systemctl enable ssh.service
rm /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server

# Enumerate
echo "$green Deploy Enumerate $white"
git clone https://github.com/Maleick/Enumerate.git /opt/Enumerate; sh /opt/Enumerate/install.sh

# Dotfiles
echo "green Deploy Dotfiles $white"
git clone https://github.com/Maleick/dotfiles /opt/dotfiles
cp /opt/dotfiles/tmux/.tmux.conf ~/.tmux.conf
cp /opt/dotfiles/vim/.vimrc ~/.vimrc

pause

reboot
