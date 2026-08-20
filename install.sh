#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin"

# ANSI Color Codes & Styles
RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
BLUE="\033[34m"

echo -e "${CYAN}┌──────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}│${RESET}         ${BOLD}${GREEN}⚡ BASH SCRIPTS INSTALLER ⚡${RESET}        ${CYAN}│${RESET}"
echo -e "${CYAN}└──────────────────────────────────────────────┘${RESET}"

# Ensure the install directory exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "${DIM}Creating destination directory $INSTALL_DIR...${RESET}"
    sudo mkdir -p "$INSTALL_DIR"
fi

# Arrays to buffer scripts
NEW_SCRIPTS=()
EXISTING_SCRIPTS=()
ALL_SCRIPTS=()

# 1. Scan and categorize scripts
for script in "$SCRIPT_DIR"/*; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script")
        ALL_SCRIPTS+=("$script_name")
        if [ -f "$INSTALL_DIR/$script_name" ]; then
            EXISTING_SCRIPTS+=("$script_name")
        else
            NEW_SCRIPTS+=("$script_name")
        fi
    fi
done

if [ ${#ALL_SCRIPTS[@]} -eq 0 ]; then
    echo -e "${RED}Error:${RESET} No scripts found in $SCRIPT_DIR."
    exit 1
fi

# 2. Display Buffer Overview
echo -e "\n${BOLD}Scan Results:${RESET}"
echo -e "  • Total scripts found: ${CYAN}${#ALL_SCRIPTS[@]}${RESET}"
echo -e "  • New installations:   ${GREEN}${#NEW_SCRIPTS[@]}${RESET}"
echo -e "  • Already installed:   ${YELLOW}${#EXISTING_SCRIPTS[@]}${RESET}\n"

# If there are existing scripts, let the user choose which ones to overwrite
SCRIPTS_TO_OVERWRITE=()
if [ ${#EXISTING_SCRIPTS[@]} -gt 0 ]; then
    echo -e "${YELLOW}The following commands already exist in $INSTALL_DIR:${RESET}"
    for i in "${!EXISTING_SCRIPTS[@]}"; do
        echo -e "  ${BOLD}$((i+1)))${RESET} ${EXISTING_SCRIPTS[$i]}"
    done
    echo ""
    read -p "$(echo -e "${BLUE}❯${RESET} Select numbers to overwrite (e.g. ${BOLD}1,3${RESET}), type ${BOLD}all${RESET}, or press Enter to skip existing: ")" choice

    if [[ "${choice,,}" == "all" ]]; then
        SCRIPTS_TO_OVERWRITE=("${EXISTING_SCRIPTS[@]}")
        echo -e "${GREEN}==> Overwriting all existing scripts.${RESET}"
    elif [[ -n "$choice" ]]; then
        # Parse comma-separated numbers
        IFS=',' read -ra ADDR <<< "$choice"
        for idx in "${ADDR[@]}"; do
            # Trim whitespace
            idx=$(echo "$idx" | xargs)
            if [[ "$idx" =~ ^[0-9]+$ ]] && [ "$idx" -ge 1 ] && [ "$idx" -le "${#EXISTING_SCRIPTS[@]}" ]; then
                SCRIPTS_TO_OVERWRITE+=("${EXISTING_SCRIPTS[$((idx-1))]}")
            fi
        done
        echo -e "${GREEN}==> Selected scripts will be overwritten.${RESET}"
    else
        echo -e "${DIM}==> Skipping all existing scripts (keeping current versions).${RESET}"
    fi
fi

echo -e "\n${CYAN}==> Starting installation...${RESET}"

# 3. Perform installation based on buffers & choices
for script_name in "${ALL_SCRIPTS[@]}"; do
    source_path="$SCRIPT_DIR/$script_name"
    target_path="$INSTALL_DIR/$script_name"
    is_existing=false

    for ex in "${EXISTING_SCRIPTS[@]}"; do
        if [ "$ex" == "$script_name" ]; then
            is_existing=true
            break
        fi
    done

    if [ "$is_existing" = true ]; then
        # Check if user opted to overwrite this specific script
        should_overwrite=false
        for ow in "${SCRIPTS_TO_OVERWRITE[@]}"; do
            if [ "$ow" == "$script_name" ]; then
                should_overwrite=true
                break
            fi
        done

        if [ "$should_overwrite" = true ]; then
            echo -e "  Updating:   ${BOLD}${GREEN}$script_name${RESET}"
            sudo cp "$source_path" "$target_path"
            sudo chmod +x "$target_path"
        else
            echo -e "  Skipping:   ${DIM}$script_name (already exists)${RESET}"
        fi
    else
        echo -e "  Installing: ${BOLD}${GREEN}$script_name${RESET}"
        sudo cp "$source_path" "$target_path"
        sudo chmod +x "$target_path"
    fi
done

echo -e "\n${GREEN}${BOLD}==> Installation complete! You can now run your scripts from anywhere.${RESET}"