#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Author: Maleick
# Version: 3.4
# Update: 2025-02-20
# Deploy Ubuntu/Kali system setup with updated snap installations

cat << "EOF"
██████╗ ███████╗██████╗ ██╗      ██████╗ ██╗   ██╗   ███████╗██╗  ██╗
██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗╚██╗ ██╔╝   ██╔════╝██║  ██║
██║  ██║█████╗  ██████╔╝██║     ██║   ██║ ╚████╔╝    ███████╗███████║
██║  ██║██╔══╝  ██╔═══╝ ██║     ██║   ██║  ╚██╔╝     ╚════██║██╔══██║
██████╔╝███████╗██║     ███████╗╚██████╔╝   ██║   ██╗███████║██║  ██║
╚═════╝ ╚══════╝╚═╝     ╚══════╝ ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝  ╚═╝
EOF

# Colors for output
blue=$'\e[0;94m'
green=$'\e[1;92m'
red=$'\e[0;91m'
white=$'\e[0m'

# Update package lists and upgrade system
echo "${green}Updating system packages...${white}"
apt update
apt full-upgrade -y
apt autoremove -y

# Install essential packages via apt
echo "${green}Installing essential packages...${white}"
apt install -y git curl at bc build-essential chromium-browser gss-ntlmssp mingw-w64 openjdk-11-jdk python3-pip ruby-full

# Install PowerShell via snap with classic confinement
echo "${green}Installing PowerShell via snap...${white}"
snap install powershell --classic

# Install SecLists via snap
echo "${green}Installing SecLists via snap...${white}"
snap install seclists

# Deploy Python tools using pip3
echo "${green}Installing Python tools...${white}"
pip3 install mitm6 pypykatz

# Clone repositories and install tools
echo "${green}Cloning and setting up repositories...${white}"

# Fortra Impacket
echo "${green}Cloning Fortra Impacket...${white}"
git clone https://github.com/fortra/impacket.git /opt/impacket
cd /opt/impacket
pip3 install .
cd -

# Egress-Assess
echo "${green}Cloning Egress-Assess...${white}"
git clone https://github.com/FortyNorthSecurity/Egress-Assess.git /opt/Egress-Assess

# WinPEAS (Privilege Escalation Awesome Scripts Suite)
echo "${green}Cloning WinPEAS...${white}"
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/winPEAS

# Responder
echo "${green}Cloning Responder...${white}"
git clone https://github.com/lgandx/Responder.git /opt/Responder

# PowerSploit
echo "${green}Cloning PowerSploit...${white}"
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit

# NetExec
echo "${green}Cloning NetExec...${white}"
git clone https://github.com/Pennyw0rth/NetExec.git /opt/netexec
cd /opt/netexec
# Additional installation steps for NetExec can be added here if required.
cd -

# Evil-WinRM (via Ruby gem)
echo "${green}Installing Evil-WinRM Ruby gem...${white}"
gem install evil-winrm

# Enumerate: Clone repository and run its installer
echo "${green}Setting up Enumerate scripts...${white}"
git clone https://github.com/Maleick/Enumerate.git /opt/Enumerate
sh /opt/Enumerate/install.sh

# Dotfiles: Deploy by cloning and running the install script
echo "${green}Deploying Dotfiles...${white}"
git clone https://github.com/Maleick/dotfiles.git /opt/dotfiles
sh /opt/dotfiles/install.sh

# Final message and reboot countdown
echo "${red}Rebooting in 10 seconds...${white}"
sleep 10s
reboot
