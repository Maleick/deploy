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
apt install at bc build-essential dirb firefox mingw-w64 net-tools nmap openjdk-11-jdk openvpn ruby-dev tightvncserver xfce4 xfce4-goodies xfonts-base x11-xserver-utils wine zsh zsh-autosuggestions zsh-syntax-highlighting -y
apt full-upgrade -y
apt autoremove
chsh -s $(which zsh)

# Install Metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall

# Setup VNC
cat << EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF
chmod +x ~/.vnc/xstartup

# Clone all the things
echo "$green Deploy the Clones $white"
git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket; cd /opt/impacket; pip install .
git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/PowerSploit
git clone https://github.com/lgandx/Responder.git /opt/Responder
git clone --recurse-submodules https://github.com/cobbr/Covenant /opt/Covenant
gem install evil-winrm

wait
sleep 5

# Dotfiles
echo "$green Deploy Dotfiles $white"
git clone https://github.com/Maleick/dotfiles /opt/dotfiles
cp /opt/dotfiles/tmux/.tmux.conf ~
cp /opt/dotfiles/vim/.vimrc ~
cp /opt/dotfiles/zsh/.zshrc ~

wait
sleep 5

# Dotnet
wget https://download.visualstudio.microsoft.com/download/pr/ec187f12-929e-4aa7-8abc-2f52e147af1d/56b0dbb5da1c191bff2c271fcd6e6394/dotnet-sdk-3.1.404-linux-x64.tar.gz
mkdir -p $HOME/dotnet && tar zxf dotnet-sdk-3.1.404-linux-x64.tar.gz -C $HOME/dotnet
echo 'export DOTNET_ROOT=$HOME/dotnet' >> .zshrc
echo 'export PATH=$PATH:$HOME/dotnet' >> .zshrc


