# Deploy

Tired of setting up new Kali images (or Ubuntu systems) from scratch? This repository contains a deploy script that automates the installation and configuration of essential tools for penetration testing, Red Team operations, and infrastructure security. Save time and get your machine ready for action with a single command.

## Features

- **System Updates & Upgrades:**  
  Automatically updates package lists, installs security updates, upgrades all packages, and removes obsolete packages.

- **Core Package Installation:**  
  Installs key packages such as:
  - `at`, `bc`
  - `bloodhound`
  - `build-essential`
  - `chromium`
  - `gss-ntlmssp`
  - `mingw-w64`
  - `openjdk-11-jdk`
  - `powershell`
  - `python3-pip`
  - `seclists`

- **Python Tools:**  
  Installs useful Python packages including:
  - `mitm6`
  - `pypykatz`

- **Repository Cloning & Installation:**  
  Clones and sets up several repositories, such as:
  - [Impacket](https://github.com/SecureAuthCorp/impacket) – for network protocol interactions.
  - [Egress-Assess](https://github.com/FortyNorthSecurity/Egress-Assess) – for outbound data flow analysis.
  - [Privilege Escalation Awesome Scripts Suite](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite) – for Windows post-exploitation.
  - [Malleable C2](https://github.com/threatexpress/malleable-c2) – for custom C2 profiles.
  - [Random C2 Profile](https://github.com/threatexpress/random_c2_profile) – for additional C2 configurations.
  - [Responder](https://github.com/lgandx/Responder) – for network authentication analysis.
  - [PowerSploit](https://github.com/PowerShellMafia/PowerSploit) – for PowerShell exploitation techniques.
  - [Enumerate](https://github.com/Maleick/Enumerate) – a personal repository for enumeration scripts.
  - [Dotfiles](https://github.com/Maleick/dotfiles) – for custom configurations.

- **Additional Tools:**  
  - Installs the Ruby gem `evil-winrm` for Windows exploitation.
  - Configures SSH by regenerating host keys and reconfiguring the OpenSSH server.

- **Automatic Reboot:**  
  Once the deployment is complete, the script reboots the system to apply all changes.

## Requirements

- A fresh installation of Ubuntu or Kali Linux.
- Sudo privileges.
- A stable internet connection during installation.

## Usage

To deploy the script, simply run the command below in your terminal:

```bash
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/Maleick/deploy/master/deploy.sh)"
