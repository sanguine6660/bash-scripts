#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# ANSI Color Codes
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"

echo -e "${BLUE}==> Checking for updates via Git...${RESET}"

# Ensure we are inside a git repository
if [ ! -d ".git" ]; then
    echo -e "${RED}Error:${RESET} This directory is not a Git repository. Cannot update."
    exit 1
fi

# Check if there are local uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}Warning:${RESET} You have uncommitted changes in your local repository."
    read -p "Do you want to stash them and proceed with the update? [y/N]: " stash_choice
    if [[ "$stash_choice" =~ ^[Yy]$ ]]; then
        echo -e "Stashing local changes..."
        git stash
        STASHED=true
    else
        echo -e "${RED}Aborted:${RESET} Please commit or stash your changes before updating."
        exit 1
    fi
fi

# Pull the latest changes from the remote repository
echo -e "Pulling latest changes from remote..."
git pull

# Restore stashed changes if any were made
if [ "$STASHED" = true ]; then
    echo -e "Restoring your stashed changes..."
    git stash pop || echo -e "${YELLOW}Notice:${RESET} Conflict detected while popping stash. Please resolve manually."
fi

# Run the installer script if it exists
if [ -f "./install.sh" ]; then
    echo -e "\n${BLUE}==> Running installer to apply updates...${RESET}"
    ./install.sh
else
    echo -e "${RED}Error:${RESET} install.sh not found in this directory."
    exit 1
fi

echo -e "\n${GREEN}==> Update and installation completed successfully!${RESET}"
