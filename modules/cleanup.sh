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

# System cleanup operations
echo "=================================================="
echo "SYSTEM CLEANUP OPERATIONS"
echo "=================================================="

# System cleanup
print_status "Performing system cleanup..."
sudo apt autoremove -y
sudo apt autoclean
print_status "System cleanup completed!"

print_status "System cleanup operations completed!"
