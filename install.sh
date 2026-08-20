#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

INSTALL_DIR="/usr/local/bin"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin"

echo -e "\033[1;34m==> Installing custom scripts to $INSTALL_DIR...\033[0m"

# Ensure the install directory exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Creating $INSTALL_DIR..."
    sudo mkdir -p "$INSTALL_DIR"
fi

# Loop through all files in the bin directory
for script in "$SCRIPT_DIR"/*; do
    if [ -f "$script" ]; then
        script_name=$(basename "$script")
        target_path="$INSTALL_DIR/$script_name"
        
        # Check if the script already exists in the destination
        if [ -f "$target_path" ]; then
            echo -e "\n\033[1;33mWarning:\033[0m Command '\033[1m$script_name\033[0m' already exists in $INSTALL_DIR."
            read -p "Do you want to overwrite it? [y/N/all]: " choice
            
            # Handle user choices
            case "$choice" in
                y|Y )
                    echo -e "Overwriting: \033[1;32m$script_name\033[0m"
                    ;;
                a|A )
                    echo -e "Overwriting all remaining conflicts."
                    # We can set a flag or just let it fall through, but for safety let's treat 'a' as overwrite rest
                    CHOICE_ALL=true
                    ;;
                * )
                    if [ "$CHOICE_ALL" != true ]; then
                        echo -e "Skipping: \033[1;36m$script_name\033[0m"
                        continue
                    fi
                    ;;
            esac
        fi
        
        echo -e "Installing: \033[1;32m$script_name\033[0m"
        
        # Copy to /usr/local/bin (requires sudo)
        sudo cp "$script" "$target_path"
        
        # Make it executable
        sudo chmod +x "$target_path"
    fi
done

echo -e "\n\033[1;32m==> Installation complete! You can now run your scripts from anywhere.\033[0m"
