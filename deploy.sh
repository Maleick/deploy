#!/bin/bash

# Author: Maleick
# Version: 1.31
# Update: 10/5/20
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
apt install at bloodhound golang mingw-w64 openjdk-11-jdk python-pip python3-pip seclists -y
apt remove metasploit-framework -y 
apt autoremove -y

# Install real metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
rm msfinstall

# Pip install
pip install configobj mitm6 pycrypto pyparsing
pip3 install pypykatz

# Clone all the things
git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket; cd /opt/impacket; pip install .
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git /opt/Egress-Assess; sh /opt/Egress-Assess/setup/setup.sh
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit
git clone https://github.com/fox-it/BloodHound.py.git /opt/BloodHound.py; cd /opt/BloodHound.py; pip install .
git clone https://github.com/s0lst1c3/eaphammer.git /opt/eaphammer
git clone https://github.com/josephkingstone/cobalt_strike_extension_kit.git /opt/cobalt_strike_extension_kit
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
cp /opt/dotfiles/tmux/.tmux.conf ~/.tmux.conf
cp /opt/dotfiles/vim/.vimrc ~/.vimrc

sudo reboot
