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

# Additional recommended software
echo "=================================================="
echo "ADDITIONAL RECOMMENDED SOFTWARE"
echo "=================================================="

# Developer tools
print_status "Installing developer tools..."
sudo apt install -y \
    zip \
    jq \
    python3-pip \
    nodejs

# Install Flatpak for additional software sources
print_status "Installing Flatpak..."
sudo apt install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# System utilities
print_status "Installing system utilities..."
sudo apt install -y timeshift

# Media tools
print_status "Installing media tools..."
sudo apt install -y krita

# Communication tools
print_status "Installing communication tools..."
sudo snap install discord

print_status "Additional recommended software completed!"
