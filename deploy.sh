#!/bin/bash

# Author: Maleick
# Version: 1.12
# Update: 8/14/20
# Deploy Kali VMWare image setup

cat << "EOF"
██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗   ██╗   ███████╗██╗  ██╗
██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝   ██╔════╝██║  ██║
██║  ██║█████╗  ██████╔╝██║     ██║   ██║ ╚████╔╝    ███████╗███████║
██║  ██║██╔══╝  ██╔═══╝ ██║     ██║   ██║  ╚██╔╝     ╚════██║██╔══██║
██████╔╝███████╗██║     ███████╗╚██████╔╝   ██║   ██╗███████║██║  ██║
╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝  ╚═╝
EOF

# Updates
apt update
apt full-upgrade -y
apt autoremove -y
apt install at bloodhound fish mingw-w64 openjdk-11-jdk python-pip python3-pip seclists -y

# Pip install
pip install configobj pyparsing

# Clone all the things
git clone https://github.com/fox-it/mitm6.git /opt/mitm6; cd /opt/mitm6; pip install -r requirements.txt
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git /opt/Egress-Assess; sh /opt/Egress-Assess/setup/setup.sh
git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket; cd /opt/impacket; pip install .
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit; cd /opt/PowerSploit; git checkout dev
git clone https://github.com/byt3bl33d3r/SprayingToolkit.git /opt/SprayingToolkit; cd /opt/SprayingToolkit; sudo pip3 install -r requirements.txt
git clone https://github.com/EnableSecurity/wafw00f /opt/wafwoof; cd /opt/wafwoof; python setup.py install
git clone https://github.com/fox-it/BloodHound.py.git /opt/BloodHound.py; cd /opt/BloodHound.py; pip install .
git clone https://github.com/s0lst1c3/eaphammer.git /opt/eaphammer
git clone https://github.com/josephkingstone/cobalt_strike_extension_kit.git /opt/cobalt_strike_extension_kit
git clone https://github.com/D35m0nd142/LFISuite.git /opt/LFISuite
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/winPEAS
git clone https://github.com/lgandx/Responder.git /opt/Responder
git clone --recursive https://github.com/eteran/edb-debugger.git /opt/edb-debugger
gem install evil-winrm

# Setup SSH
systemctl enable ssh.service
rm /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server

# Forks and personal repos
git clone https://github.com/Maleick/Enumerate.git /opt/Enumerate; sh /opt/Enumerate/install.sh
git clone https://github.com/Maleick/awsmBloodhoundCustomQueries.git /opt/CustomQueries

# Dotfiles
git clone https://github.com/Maleick/dotfiles /opt/dotfiles
cp /opt/dotfiles/fish/config.fish ~/.config/fish
cp /opt/dotfiles/tmux/.tmux.conf ~
cp /opt/dotfiles/vim/.vimrc ~

chsh -s /usr/bin/fish

sudo reboot
