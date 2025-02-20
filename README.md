# Deploy

Tired of manually setting up new Kali or Ubuntu systems for penetration testing and Red Team operations? This repository provides a deploy script that automates the installation and configuration of essential tools, updates, and custom repositories with smart cloning/updating logic.

## Features

- **Automated System Updates & Upgrades:**  
  The script updates package lists, performs full system upgrades, and removes obsolete packages.

- **Essential Package Installation:**  
  Installs a variety of packages required for development and security testing, including:
  - `git`, `curl`, `at`, `bc`, `build-essential`
  - `chromium-browser`
  - `gss-ntlmssp`
  - `mingw-w64`
  - `openjdk-11-jdk`
  - `python3-pip`
  - `ruby-full`

- **Snap-Based Installations:**  
  Uses snap to install:
  - [PowerShell](https://snapcraft.io/powershell) (with classic confinement)
  - [SecLists](https://snapcraft.io/seclists)

- **Python Tool Deployment:**  
  Installs Python tools (with `--break-system-packages` for Ubuntu):
  - `mitm6`
  - `pypykatz`

- **Repository Cloning & Auto-Update:**  
  Automatically clones or updates several repositories, including:
  - **Fortra Impacket:** (installed via pip after cloning)
  - **Egress-Assess:** for outbound data flow analysis.
  - **WinPEAS:** a collection of Windows privilege escalation scripts.
  - **Responder:** for network authentication and protocol analysis.
  - **PowerSploit:** for PowerShell exploitation.
  - **NetExec:** for network execution tools.
  - **Enumerate:** (custom enumeration scripts) – the script checks for an installer before running.
  - **Dotfiles:** custom configurations deployed by running its install script.

- **Ruby Gem Installation:**  
  Installs [Evil-WinRM](https://github.com/HarmJ0y/evil-winrm) via Ruby gem.

- **Repository Update Logic:**  
  Each repository is managed by a helper function that checks if the destination directory already exists. If it does, the script performs a `git pull` to update the repository instead of cloning it again.

- **Automatic Reboot:**  
  Once deployment is complete, the system will reboot after a short countdown.

## Requirements

- A fresh installation of Ubuntu or Kali Linux.
- Sudo privileges.
- A stable internet connection during installation.

## Usage

To deploy the script, run the command below in your terminal:

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/Maleick/deploy/master/deploy.sh)"
