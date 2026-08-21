# ⚡ Custom Bash Scripts Suite

A personal collection of modern, lightweight, and cross-distribution terminal utilities designed to streamline system management, development workflows, and server operations. Built with ANSI styling and automatic dependency management.

---

## 🛠️ Included Tools

| Command                                                  | Description                                                                                          |
| :------------------------------------------------------- | :--------------------------------------------------------------------------------------------------- | --- |
| [`myssh`](#1-myssh-ssh-connection-manager)               | Interactive SSH connection manager powered by a local JSON config.                                   |
| [`sysup`](#2-sysup-system-upgrade--maintenance)          | Cross-distribution system upgrade and cleanup tool (Arch/CachyOS, Debian, Fedora, openSUSE, Alpine). |
| [`portkill`](#3-portkill-port-terminator)                | Quick utility to find and safely terminate processes blocking specific ports.                        |
| [`dtop`](#4-dtop-docker-dashboard)                       | Interactive Docker container dashboard and management menu.                                          |
| [`git-resign`](#5-git-resign-git-history-re-sign)        | Retroactively validates GPG configurations, re-signs, and updates author history for all commits.    |
| [`git-undo`](#6-git-undo-git-rollback-helper)            | Interactive helper menu to safely unstage, amend, or roll back recent Git commits.                   |
| [`json-lint`](#7-json-lint-json-syntax-validator)        | Validates JSON syntax and outputs detailed error messages for malformed data.                        |
| [`json-fmt`](#8-json-fmt-json-formatter--writer)         | Pretty-prints JSON data with optional in-file saving support.                                        |
| [`license-gen`](#9-license-gen-license-generator)        | Generates standard open-source licenses interactively based on your Git config.                      |
| [`netspeed`](#10-netspeed-network-speed-tester)          | Measures download/upload speeds in Mbit/s and MB/s with ISP & server info.                           |
| [`dns-flush`](#11-dns-flush-dns-cache-flusher)           | Automatically detects Linux network resolvers and flushes local DNS caches.                          |
| [`alias-gen`](#12-alias-gen-terminal-shortcut-builder)   | Interactively creates and saves custom shell aliases for Bash, Zsh, or Fish.                         |
| [`port-inspect`](#14-port-inspect-active-port-inspector) | Scans and lists all active listening ports mapped to their protocol, PID, and process.               |     |

---

## 🚀 Installation & Updates

This repository comes with automated installer and updater scripts that handle global symlinking and Git sync.

### Initial Installation

Clone the repository and run the install script (requires `sudo` for global `/usr/local/bin` installation):

```bash
git clone https://github.com/sanguine6660/bash-scripts.git
cd bash-scripts
./install.sh

```

### Updating Scripts

To pull the latest changes from your remote repository and automatically re-apply global links, simply run:

```bash
./update.sh

```

---

## 📖 Tool Breakdown & Usage

### 1. `myssh` (SSH Connection Manager)

- **What it does:** Reads from a local configuration file (`~/.ssh/connections.json`) and presents an interactive menu to select and connect to your remote servers.
- **Features:** Automatically installs `jq` if missing across various package managers.
- **Usage:**

```bash
myssh

```

### 2. `sysup` (System Upgrade & Maintenance)

- **What it does:** Detects your Linux distribution and executes the correct package manager upgrades (`pacman`/`yay`/`paru`, `apt`, `dnf`, `zypper`, `apk`).
- **Features:** Handles system package updates, optional AUR helper integration, package cache cleanup, and orphaned package removal.
- **Usage:**

```bash
sysup

```

### 3. `portkill` (Port Terminator)

- **What it does:** Accepts a port number as an argument, finds the process ID utilizing it, displays details, and prompts to terminate it.
- **Features:** Automatically checks for and installs `lsof` if needed.
- **Usage:**

```bash
portkill 3000

```

### 4. `dtop` (Docker Dashboard)

- **What it does:** Provides an interactive menu of all running and stopped Docker containers.
- **Features:** Allows you to stream live logs (`tail`), open an interactive shell (`exec`), restart, stop, or start containers on the fly.
- **Usage:**

```bash
dtop

```

### 5. `git-resign` (Git History Re-Sign)

- **What it does:** Validates your local Git email, GPG configuration, and secret key ring before rewriting and cryptographically re-signing your entire commit history from the root.
- **Features:** Automated safety checks, interactive prompt confirmations, fixes author metadata across past commits, and handles seamless force-pushing to your remote branch.
- **Usage:**

```bash
git-resign

```

### 6. `git-undo` (Git Rollback Helper)

- **What it does:** Presents an interactive menu allowing you to quickly select common rollback actions like unstaging files, amending the last commit, performing a soft reset, or running a guarded hard reset.
- **Features:** Built-in repository safety checks, colored warning prompts, and clear status feedback.
- **Usage:**

```bash
git-undo

```

### 7. `json-lint` (JSON Syntax Validator)

- **What it does:** Accepts file paths or piped standard input to check JSON documents for syntax compliance and print descriptive error traces if malformed.
- **Features:** Automatic `jq` installer fallback, robust input checking, and color-coded status reports.
- **Usage:**

```bash
json-lint config.json
cat config.json | json-lint

```

### 8. `json-fmt` (JSON Formatter & Writer)

- **What it does:** Formats and pretty-prints messy or minified JSON inputs from files or pipes using `jq`.
- **Features:** Includes an interactive prompt to safely save and overwrite changes directly back to your target file in place.
- **Usage:**

```bash
json-fmt messy.json
cat messy.json | json-fmt

```

### 9. `license-gen` (License Generator)

- **What it does:** Interactively generates standard open-source license files (MIT, Apache-2.0, GPL-3.0, BSD-3-Clause) in the current directory.
- **Features:** Automatically defaults to your active Git username and current year, with safety prompts before overwriting existing files.
- **Usage:**

```bash
license-gen

```

### 10. `netspeed` (Network Speed Tester)

- **What it does:** Measures your current network download and upload speeds using accurate `speedtest-cli` metrics, displaying both Mbit/s and MB/s alongside connection metadata.
- **Features:** Automatically detects and installs missing dependencies (`speedtest-cli` and `jq`), handles local formatting dynamically, and displays a clean ANSI summary box including ISP, server location, and ping.
- **Usage:**

```bash
netspeed

```

### 11. `dns-flush` (DNS Cache Flusher)

- **What it does:** Automatically detects active Linux network resolvers/caching daemons and flushes or reloads their DNS cache.
- **Features:** Supports `resolvectl`, `systemd-resolve`, NetworkManager (`dns-rc`), `nscd`, and `dnsmasq` with automatic fallback.
- **Usage:**

```bash
dns-flush

```

### 12. `alias-gen` (Terminal Shortcut Builder)

- **What it does:** Interactively guides you through creating custom terminal shortcuts and safely appends them to your active shell configuration.
- **Features:** Supports Bash (`~/.bashrc`), Zsh (`~/.zshrc`), and Fish (`~/.config/fish/config.fish`) with syntax formatting and reload instructions.
- **Usage:**

```bash
alias-gen

```

### 13. `port-inspect` (Active Port Inspector)

- **What it does:** Scans system network sockets to display all active listening ports, protocols, associated PIDs, and process/user ownership in a clean, aligned table.
- **Features:** Automatically utilizes `ss` with fallback user/process resolution via `ps`, acting as an ideal companion utility to `portkill`.
- **Usage:**

```bash
port-inspect

```

---

## 💻 Requirements

- A Unix-like environment (Linux / macOS)
- Bash (v4+ recommended)
- Standard core utilities (`curl`, `awk`, `git`, `gpg`, etc.)

---

## License

This project is licensed under the [MIT License](LICENSE).

```

```
