#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Author: Maleick
# Version: 3.8
# Update: 2025-02-20
# Deploy Ubuntu/Kali system setup with repository clone/update checks

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

# Helper function to clone or update a git repository
clone_or_update() {
    local repo_url="$1"
    local dest_dir="$2"
    if [ -d "$dest_dir" ]; then
        echo "${green}Directory $dest_dir exists. Updating...${white}"
        cd "$dest_dir"
        git pull || echo "${red}Failed to update $dest_dir${white}"
        cd - > /dev/null
    else
        echo "${green}Cloning $repo_url into $dest_dir...${white}"
        git clone "$repo_url" "$dest_dir"
    fi
}

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

# Deploy Python tools using pip3 with the break-system-packages flag
echo "${green}Installing Python tools...${white}"
pip3 install --break-system-packages mitm6 pypykatz

# Clone/update repositories and install tools

# Fortra Impacket (requires pip installation)
clone_or_update "https://github.com/fortra/impacket.git" "/opt/impacket"
echo "${green}Installing Fortra Impacket...${white}"
cd /opt/impacket
pip3 install --break-system-packages --ignore-installed .
cd - > /dev/null

# Egress-Assess
clone_or_update "https://github.com/FortyNorthSecurity/Egress-Assess.git" "/opt/Egress-Assess"

# WinPEAS (Privilege Escalation Awesome Scripts Suite)
clone_or_update "https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git" "/opt/winPEAS"

# Responder
clone_or_update "https://github.com/lgandx/Responder.git" "/opt/Responder"

# PowerSploit
clone_or_update "https://github.com/PowerShellMafia/PowerSploit.git" "/opt/PowerSploit"

# NetExec
clone_or_update "https://github.com/Pennyw0rth/NetExec.git" "/opt/netexec"
cd /opt/netexec
# Additional installation steps for NetExec can be added here if required.
cd - > /dev/null

# Evil-WinRM (via Ruby gem)
echo "${green}Installing Evil-WinRM Ruby gem...${white}"
gem install evil-winrm

# Enumerate: Clone repository and run its installer if available
clone_or_update "https://github.com/Maleick/Enumerate.git" "/opt/Enumerate"
if [ -f /opt/Enumerate/install.sh ]; then
    sh /opt/Enumerate/install.sh
else
    echo "${red}Warning: /opt/Enumerate/install.sh not found. Skipping Enumerate installation.${white}"
fi

# Dotfiles: Deploy by cloning and running the install script
clone_or_update "https://github.com/Maleick/dotfiles.git" "/opt/dotfiles"
sh /opt/dotfiles/install.sh

# Final message and reboot countdown
echo "${red}Rebooting in 10 seconds...${white}"
sleep 10s
reboot
