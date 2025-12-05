#!/bin/sh

# Check if 'yay' is installed and executable
if command -v yay >/dev/null 2>&1; then
    echo "yay is already installed."
else
    echo "yay is not installed. Installing it now..."
    # Steps to install yay from AUR manually if not found
    # You might want to add error handling here
    git https://aur.archlinux.org/yay.git /tmp/yay_install
    cd /tmp/yay_install
    makepkg -si --noconfirm
    echo "yay has been installed."
fi
