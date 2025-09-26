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

# Function to check if NVM is installed
is_nvm_installed() {
    [ -s "$HOME/.nvm/nvm.sh" ]
}

# Function to check if Node.js is installed
is_node_installed() {
    command -v node >/dev/null 2>&1
}

# Function to check if pnpm is installed
is_pnpm_installed() {
    command -v pnpm >/dev/null 2>&1
}

# Node.js development environment
echo "=================================================="
echo "NODE.JS DEVELOPMENT ENVIRONMENT"
echo "=================================================="

# Install NVM (Node Version Manager)
if is_nvm_installed; then
    print_status "NVM is already installed, skipping..."
else
    print_status "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

# Source NVM to make it available immediately
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install latest LTS Node.js using NVM
if is_node_installed; then
    print_status "Node.js is already installed, skipping..."
else
    print_status "Installing Node.js (LTS)..."
    nvm install --lts
    nvm use --lts
fi

# Install pnpm
if is_pnpm_installed; then
    print_status "pnpm is already installed, skipping..."
else
    print_status "Installing pnpm..."
    npm install -g pnpm
fi

print_status "Node.js development environment completed!"
