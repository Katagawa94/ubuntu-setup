#!/bin/bash

# Zsh + Oh My Zsh + Powerlevel10k Setup Script
# Based on: https://medium.com/@satriajanaka09/setup-zsh-oh-my-zsh-powerlevel10k-on-ubuntu-20-04-c4a4052508fd

set -e # Exit immediately if a command exits with a non-zero status

echo "================================================="
echo "  ZSH + OH MY ZSH + POWERLEVEL10K SETUP SCRIPT  "
echo "================================================="
echo ""

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

# Check if running on Ubuntu/Debian - Fixed version
if [ ! -f /etc/os-release ]; then
    print_error "Cannot determine operating system. This script is designed for Ubuntu/Debian systems."
    exit 1
fi

# Check if it's Ubuntu/Debian based system
if ! grep -qi "ubuntu\|debian" /etc/os-release; then
    print_error "This script is designed for Ubuntu/Debian systems with apt package manager."
    print_error "Detected OS: $(grep PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')"
    exit 1
fi

print_status "Detected OS: $(grep PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')"

# Update system packages first
print_header "Updating system packages..."
sudo apt update

# Step 1: Install Zsh
print_header "Step 1: Installing Zsh..."
if ! command -v zsh &> /dev/null; then
    print_status "Installing Zsh..."
    sudo apt install -y zsh
else
    print_status "Zsh is already installed, checking for updates..."
    sudo apt install -y zsh
fi

# Check Zsh version
print_status "Zsh installation completed. Version:"
zsh --version

# Check if Zsh is in valid shells
print_status "Checking available shells:"
cat /etc/shells

# Step 2: Set Zsh as default shell
print_header "Step 2: Checking current shell and setting Zsh as default if needed..."

# Check current default shell
CURRENT_SHELL=$(getent passwd $USER | cut -d: -f7)
print_status "Current default shell: $CURRENT_SHELL"

if [ "$CURRENT_SHELL" = "/usr/bin/zsh" ] || [ "$CURRENT_SHELL" = "/bin/zsh" ]; then
    print_status "Zsh is already set as your default shell. Skipping shell change."
else
    print_status "Setting Zsh as default shell..."
    print_warning "You may be prompted for your password to change the default shell."
    chsh -s /usr/bin/zsh
    print_status "Default shell changed to Zsh. Changes will take effect after logout/login."
fi

# Step 3: Install dependencies
print_header "Step 3: Installing dependencies..."

# Install fonts-powerline for proper symbol rendering
print_status "Installing Powerline fonts..."
sudo apt install -y fonts-powerline

# Install dconf-cli for terminal customization
print_status "Installing dconf-cli for terminal customization..."
sudo apt install -y dconf-cli

# Install git if not already installed
print_status "Ensuring git is installed..."
sudo apt install -y git curl

# Step 4: Install Oh My Zsh
print_header "Step 4: Installing Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
    print_warning "Oh My Zsh already installed. Skipping installation."
else
    print_status "Downloading and installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Step 5: Install Powerlevel10k theme
print_header "Step 5: Installing Powerlevel10k theme..."
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    print_warning "Powerlevel10k already installed. Updating..."
    cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git pull
    cd ~
else
    print_status "Cloning Powerlevel10k repository..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Step 6: Install Zsh plugins
print_header "Step 6: Installing Zsh plugins..."

# Install zsh-autosuggestions plugin
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    print_warning "zsh-autosuggestions already installed. Updating..."
    cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git pull
    cd ~
else
    print_status "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin
if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    print_warning "zsh-syntax-highlighting already installed. Updating..."
    cd ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git pull
    cd ~
else
    print_status "Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Step 7: Configure .zshrc
print_header "Step 7: Configuring .zshrc..."

# Backup existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    print_status "Backing up existing .zshrc to .zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    cp $HOME/.zshrc $HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
fi

# Create new .zshrc configuration
print_status "Creating new .zshrc configuration..."
cat > $HOME/.zshrc << 'EOF'
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications.
# For more details, see 'man strftime' or https://en.wikipedia.org/wiki/Strftime
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# NVM configuration (if NVM is installed)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF

# Step 8: Install Dracula theme for GNOME terminal
print_header "Step 8: Installing Dracula theme for GNOME terminal..."

# Check if GNOME terminal is available
if command -v gnome-terminal &> /dev/null; then
    print_status "GNOME terminal detected. Installing Dracula theme..."

    # Clone Dracula theme repository
    cd /tmp
    if [ -d "gnome-terminal" ]; then
        rm -rf gnome-terminal
    fi
    git clone https://github.com/dracula/gnome-terminal
    cd gnome-terminal

    print_status "Dracula theme downloaded. You can install it by running the install script."
    print_warning "To complete Dracula theme installation:"
    print_warning "1. cd /tmp/gnome-terminal"
    print_warning "2. ./install.sh"
    print_warning "3. Follow the prompts to select your profile"
    print_warning "4. Set the Dracula profile as default in terminal preferences"

    cd ~
else
    print_warning "GNOME terminal not detected. Skipping Dracula theme installation."
    print_status "If you're using a different terminal, you can find themes at:"
    print_status "https://draculatheme.com/"
fi

# Final steps and instructions
echo ""
echo "================================================="
print_status "Zsh + Oh My Zsh + Powerlevel10k setup completed successfully!"
echo "================================================="
echo ""

print_warning "IMPORTANT NEXT STEPS:"
echo ""
print_warning "1. RESTART YOUR TERMINAL OR LOG OUT/IN"
print_warning "   - Zsh needs to be set as your default shell"
print_warning "   - Current shell: $SHELL"
print_warning "   - After restart it should be: /usr/bin/zsh"
echo ""

print_warning "2. POWERLEVEL10K CONFIGURATION"
print_warning "   - When you open a new terminal, the configuration wizard will start"
print_warning "   - If it doesn't start automatically, run: p10k configure"
print_warning "   - You can reconfigure anytime with the same command"
echo ""

print_warning "3. FONT RECOMMENDATIONS"
print_warning "   - For best experience, install a Nerd Font in your terminal"
print_warning "   - Recommended: MesloLGS NF (will be suggested by p10k configure)"
print_warning "   - Download from: https://github.com/ryanoasis/nerd-fonts"
echo ""

print_warning "4. DRACULA THEME (OPTIONAL)"
print_warning "   - Complete the Dracula theme installation by running:"
print_warning "   - cd /tmp/gnome-terminal && ./install.sh"
echo ""

print_status "Features enabled:"
print_status "✓ Zsh shell with Oh My Zsh framework"
print_status "✓ Powerlevel10k theme for beautiful prompts"
print_status "✓ Auto-suggestions (type and see suggestions in gray)"
print_status "✓ Syntax highlighting (commands turn green when valid)"
print_status "✓ Git integration and many other Oh My Zsh features"
echo ""

print_status "Enjoy your enhanced terminal experience! 🚀"
echo ""
