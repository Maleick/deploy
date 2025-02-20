# Deploy

Tired of setting up new Kali images (or Ubuntu systems) from scratch? This repository contains a deploy script that automates the installation and configuration of essential tools for penetration testing, Red Team operations, and infrastructure security. Save time and get your machine ready for action with a single command.

## Features

- **System Updates & Upgrades:**  
  Automatically updates package lists, upgrades the system, and removes obsolete packages.

- **Core Package Installation:**  
  Installs essential packages such as:
  - `at`, `bc`
  - `bloodhound`
  - `build-essential`
  - `chromium-browser`
  - `gss-ntlmssp`
  - `mingw-w64`
  - `openjdk-11-jdk`
  - `powershell`
  - `python3-pip`
  - `seclists`
  - `ruby-full`

- **Python Tools:**  
  Installs useful Python packages including:
  - `mitm6`
  - `pypykatz`

- **Repository Cloning & Installation:**  
  Clones and sets up several repositories:
  - [Fortra Impacket](https://github.com/fortra/impacket) – for network protocol interactions.
  - [Egress-Assess](https://github.com/FortyNorthSecurity/Egress-Assess) – for outbound data flow analysis.
  - [WinPEAS](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite) – for Windows privilege escalation.
  - [Responder](https://github.com/lgandx/Responder) – for network authentication analysis.
  - [PowerSploit](https://github.com/PowerShellMafia/PowerSploit) – for PowerShell exploitation techniques.
  - [NetExec](https://github.com/Pennyw0rth/NetExec) – for network execution.
  - [Enumerate](https://github.com/Maleick/Enumerate) – personal enumeration scripts.
  - [Dotfiles](https://github.com/Maleick/dotfiles) – custom configurations deployed via its install script.

- **Additional Tools:**  
  - Installs the Ruby gem `evil-winrm` for Windows exploitation.

## Requirements

- A fresh installation of Ubuntu or Kali Linux.
- Sudo privileges.
- A stable internet connection during installation.

## Usage

To deploy the script, simply run the command below in your terminal:

```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/Maleick/deploy/master/deploy.sh)"
