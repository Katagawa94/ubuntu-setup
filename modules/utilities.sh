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

# System utilities and applications
echo "=================================================="
echo "SYSTEM UTILITIES AND APPLICATIONS"
echo "=================================================="

# Install KeePassXC
print_status "Installing KeePassXC..."
sudo apt install -y keepassxc

print_status "System utilities and applications completed!"
