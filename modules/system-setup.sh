#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

set -e # Exit immediately if a command exits with a non-zero status

# System packages and essential tools setup
echo "=================================================="
echo "SYSTEM PACKAGES, SETTINGS AND ESSENTIAL TOOLS SETUP"
echo "=================================================="

print_status "Updating system settings..."
# Center dock icons
gsettings set org.gnome.shell.extensions.dash-to-dock always-center-icons true
# Configure system settings
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
# Move Show Apps to top
gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true
# set dock transparency
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.2



# Update system packages
print_status "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install essential system packages
print_status "Installing essential system packages..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    wget \
    gpg \
    lsb-release

# Install curl
print_status "Installing curl..."
sudo apt install -y curl

# Install git
print_status "Installing git..."
sudo apt install -y git

print_status "System packages and essential tools setup completed!"
