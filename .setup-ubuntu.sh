#!/bin/bash

# Ubuntu System Setup - Main Installation Script
# This script calls individual installation modules

set -e # Exit immediately if a command exits with a non-zero status

echo "Starting Ubuntu System Setup..."
echo "================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

print_header() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Function to run a script module
run_module() {
    local script_name="$1"
    local description="$2"

    if [ -f "$script_name" ]; then
        print_header "Running $description..."
        chmod +x "$script_name"
        if ./"$script_name"; then
            print_status "$description completed successfully"
        else
            print_error "$description failed with exit code $?"
            print_warning "Continuing with next module..."
        fi
        echo ""
    else
        print_error "Script $script_name not found!"
        exit 1
    fi
}

# Core installation modules
run_module "./modules/system-setup.sh" "System Setup"
run_module "./modules/browsers.sh" "Browser Installation"
run_module "./modules/development-tools.sh" "Development Tools"
run_module "./modules/nodejs-setup.sh" "Node.js Environment"
run_module "./modules/utilities.sh" "System Utilities"
run_module "./modules/zsh-setup.sh" "Zsh and Oh My Zsh Setup"

print_status "Core software installation completed!"
echo ""
echo "================================"
echo "ADDITIONAL RECOMMENDED SOFTWARE"
echo "================================"
echo ""

# Ask user about additional software installation
read -p "Do you want to install additional recommended software? (y/n): " install_additional

if [ "$install_additional" = "y" ] || [ "$install_additional" = "Y" ]; then
    run_module "additional-software.sh" "Additional Software"
fi

# System cleanup
run_module "cleanup.sh" "System Cleanup"

print_status "Ubuntu System Setup completed successfully!"
echo ""
echo "================================"
print_status "INSTALLATION SUMMARY"
echo "================================"
echo ""
print_status "✓ System packages updated and essential tools installed"
print_status "✓ Web browsers: Brave Browser and Google Chrome"
print_status "✓ Development tools: Visual Studio Code"
print_status "✓ Node.js environment with NVM and pnpm"
print_status "✓ System utilities: KeePassXC"
print_status "✓ Zsh and Oh My Zsh configured"
if [ "$install_additional" = "y" ] || [ "$install_additional" = "Y" ]; then
    print_status "✓ Additional software: Developer tools, Flatpak, Timeshift, Krita, Discord"
fi
print_status "✓ System cleanup completed"
echo ""
print_status "Your Ubuntu system is now ready for development!"
print_status "You may need to restart your terminal or log out/in for some changes to take effect."
