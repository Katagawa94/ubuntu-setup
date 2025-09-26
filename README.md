# Ubuntu Setup Scripts

[![Semantic Release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A collection of automated setup scripts to quickly configure a fresh Ubuntu installation with essential tools, applications, and development environments.

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/ubuntu-setup.git
cd ubuntu-setup

# Make scripts executable
chmod +x *.sh modules/*.sh

# Run the main setup script
./setup.sh
```

## 📦 Available Modules

### System Utilities (`modules/utilities.sh`)
- **KeePassXC** - Secure password manager
- Automatically checks if packages are already installed

### Node.js Development Environment (`modules/nodejs-setup.sh`)
- **NVM** (Node Version Manager) - Manage multiple Node.js versions
- **Node.js LTS** - Latest Long Term Support version
- **pnpm** - Fast, disk space efficient package manager
- Smart installation checks to avoid reinstalling existing tools

## 🛠️ Usage

### Run Individual Modules
```bash
# Install system utilities only
./modules/utilities.sh

# Setup Node.js environment only
./modules/nodejs-setup.sh
```

### Run Full Setup
```bash
# Run all setup modules
./setup.sh
```

## 📁 Project Structure

```
ubuntu-setup/
├── modules/                 # Individual setup modules
├── .releaserc.json         # Semantic release configuration
├── CHANGELOG.md            # Auto-generated changelog
└── README.md              # This file
```

## ✨ Features

- **Smart Installation Checks** - Avoids reinstalling already present software
- **Colored Output** - Easy to read status messages with color coding
- **Error Handling** - Scripts exit on errors to prevent incomplete installations
- **Modular Design** - Run individual modules or complete setup
- **Automated Releases** - Semantic versioning with automated changelog generation

## 🔧 Customization

To add new software or modify existing installations:

1. Edit the relevant module in the `modules/` directory
2. Use the existing utility functions for consistent output:
   - `print_status()` - Green info messages
   - `print_warning()` - Yellow warning messages  
   - `print_error()` - Red error messages
3. Add installation checks using helper functions like `is_package_installed()`

