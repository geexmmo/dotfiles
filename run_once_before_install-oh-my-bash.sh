#!/bin/sh
OMB_DIR="$HOME/.oh-my-bash"

# Check if the Oh My Bash directory exists and contains the main script
if [ ! -f "$OMB_DIR/oh-my-bash.sh" ]; then
    echo "Oh My Bash directory not found or incomplete. Running installation script..."
    
    # Run the official install script unattended
    # OSH variable is set automatically by the install script if not exported beforehand
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

    echo "Oh My Bash installation script run."
else
    echo "Oh My Bash already installed in $OMB_DIR. Skipping installation script."
fi

# Ensure the .bashrc managed by chezmoi is sourced in the current session if needed
if [ -f "$HOME/.bashrc" ] && [[ $- != *i* ]]; then
    source "$HOME/.bashrc"
fi
