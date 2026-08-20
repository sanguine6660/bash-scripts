# ⚡ Custom Bash Scripts Suite

A personal collection of modern, lightweight, and cross-distribution terminal utilities designed to streamline system management, development workflows, and server operations. Built with ANSI styling and automatic dependency management.

---

## 🛠️ Included Tools

| Command                                         | Description                                                                                          |
| :---------------------------------------------- | :--------------------------------------------------------------------------------------------------- |
| [`myssh`](#1-myssh-ssh-connection-manager)      | Interactive SSH connection manager powered by a local JSON config.                                   |
| [`sysup`](#2-sysup-system-upgrade--maintenance) | Cross-distribution system upgrade and cleanup tool (Arch/CachyOS, Debian, Fedora, openSUSE, Alpine). |
| [`portkill`](#3-portkill-port-terminator)       | Quick utility to find and safely terminate processes blocking specific ports.                        |
| [`dtop`](#4-dtop-docker-dashboard)              | Interactive Docker container dashboard and management menu.                                          |

---

## 🚀 Installation & Updates

This repository comes with automated installer and updater scripts that handle global symlinking and Git sync.

### Initial Installation

Clone the repository and run the install script (requires `sudo` for global `/usr/local/bin` installation):

```bash
git clone https://github.com/sanguine6660/bash-scripts
cd bash-scripts
./install.sh
```

### Updating Scripts

To pull the latest changes from your remote repository and automatically re-apply global links, simply run:

```bash
./update.sh
```

---

## 📖 Tool Breakdown

### 1. `myssh` (SSH Connection Manager)

- **What it does:** Reads from a local configuration file (`~/.ssh/connections.json`) and presents an interactive menu to select and connect to your remote servers.
- **Features:** Automatically installs `jq` if missing across various package managers.

### 2. `sysup` (System Upgrade & Maintenance)

- **What it does:** Detects your Linux distribution and executes the correct package manager upgrades (`pacman`/`yay`/`paru`, `apt`, `dnf`, `zypper`, `apk`).
- **Features:** Handles system package updates, optional AUR helper integration, package cache cleanup, and orphaned package removal.

### 3. `portkill` (Port Terminator)

- **What it does:** Accepts a port number as an argument (e.g., `portkill 3000`), finds the process ID utilizing it, displays details, and prompts to terminate it.
- **Features:** Automatically checks for and installs `lsof` if needed.

### 4. `dtop` (Docker Dashboard)

- **What it does:** Provides an interactive menu of all running and stopped Docker containers.
- **Features:** Allows you to stream live logs (`tail`), open an interactive shell (`exec`), restart, stop, or start containers on the fly.

---

## 💻 Requirements

- A Unix-like environment (Linux / macOS)
- Bash (v4+ recommended)
- Standard core utilities (`curl`, `awk`, etc.)
