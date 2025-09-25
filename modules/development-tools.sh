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

# Development tools and IDEs
echo "=================================================="
echo "DEVELOPMENT TOOLS AND IDES"
echo "=================================================="

# Install Git
if ! command -v git &> /dev/null; then
    print_status "Installing Git..."
    sudo apt update
    sudo apt install -y git
else
    print_status "Git is already installed, checking for updates..."
    sudo apt update
    sudo apt install -y git
fi

# Install curl
if ! command -v curl &> /dev/null; then
    print_status "Installing curl..."
    sudo apt install -y curl
else
    print_status "curl is already installed, checking for updates..."
    sudo apt install -y curl
fi

# Install Visual Studio Code
if ! command -v code &> /dev/null; then
    print_status "Installing Visual Studio Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
        https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update
    sudo apt install -y code
else
    print_status "Visual Studio Code is already installed, checking for updates..."
    sudo apt update
    sudo apt install -y code
fi

# Install build-essential
if ! dpkg -l | grep -q build-essential; then
    print_status "Installing build-essential..."
    sudo apt install -y build-essential
else
    print_status "build-essential is already installed, checking for updates..."
    sudo apt install -y build-essential
fi

# Install Docker
if ! command -v docker &> /dev/null; then
    print_status "Installing Docker..."
    sudo apt install -y apt-transport-https ca-certificates gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
else
    print_status "Docker is already installed, checking for updates..."
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
fi

# Install VS Code extensions
if command -v code &> /dev/null; then
    print_status "Installing Visual Studio Code extensions..."
    code --install-extension ms-vscode-remote.vscode-remote-extensionpack
else
    print_warning "VS Code not found, skipping extension installation"
fi

print_status "Development tools and IDEs completed!"
