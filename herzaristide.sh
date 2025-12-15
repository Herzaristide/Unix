#!/bin/bash

#############################################################################
# herzaristide.sh - Automated Zsh, Oh My Zsh, and Git Setup Script
#############################################################################
# This script installs and configures:
# - Git
# - Zsh
# - Oh My Zsh
# - Custom Zsh configuration
#
# Usage:
#   bash herzaristide.sh
#   or via curl:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/Herzaristide/Unix/main/herzaristide.sh)"
#############################################################################

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
        else
            OS="linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        OS="unknown"
    fi
    print_info "Detected OS: $OS"
}

# Install Git
install_git() {
    print_header "Installing Git"
    
    if command -v git &> /dev/null; then
        print_success "Git is already installed ($(git --version))"
        return 0
    fi
    
    print_info "Installing Git..."
    
    case $OS in
        ubuntu|debian)
            sudo apt update
            sudo apt install -y git
            ;;
        fedora|rhel|centos)
            sudo dnf install -y git || sudo yum install -y git
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm git
            ;;
        macos)
            if command -v brew &> /dev/null; then
                brew install git
            else
                print_error "Homebrew not found. Please install Homebrew first."
                exit 1
            fi
            ;;
        *)
            print_error "Unsupported OS for automatic Git installation"
            exit 1
            ;;
    esac
    
    if command -v git &> /dev/null; then
        print_success "Git installed successfully ($(git --version))"
    else
        print_error "Git installation failed"
        exit 1
    fi
}

# Install Zsh
install_zsh() {
    print_header "Installing Zsh"
    
    if command -v zsh &> /dev/null; then
        print_success "Zsh is already installed ($(zsh --version))"
        return 0
    fi
    
    print_info "Installing Zsh..."
    
    case $OS in
        ubuntu|debian)
            sudo apt update
            sudo apt install -y zsh
            ;;
        fedora|rhel|centos)
            sudo dnf install -y zsh || sudo yum install -y zsh
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm zsh
            ;;
        macos)
            if command -v brew &> /dev/null; then
                brew install zsh
            else
                print_warning "Homebrew not found. Zsh might already be installed on macOS."
            fi
            ;;
        *)
            print_error "Unsupported OS for automatic Zsh installation"
            exit 1
            ;;
    esac
    
    if command -v zsh &> /dev/null; then
        print_success "Zsh installed successfully ($(zsh --version))"
    else
        print_error "Zsh installation failed"
        exit 1
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    print_header "Installing Oh My Zsh"
    
    if [ -d "$HOME/.oh-my-zsh" ]; then
        print_warning "Oh My Zsh is already installed"
        read -p "Do you want to reinstall? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return 0
        fi
        print_info "Removing existing Oh My Zsh installation..."
        rm -rf "$HOME/.oh-my-zsh"
    fi
    
    print_info "Installing Oh My Zsh..."
    
    # Install Oh My Zsh without running zsh at the end
    # Note: This downloads and executes the official Oh My Zsh installation script
    # For enhanced security, you can review the script at:
    # https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    if RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
        if [ -d "$HOME/.oh-my-zsh" ]; then
            print_success "Oh My Zsh installed successfully"
        else
            print_error "Oh My Zsh installation failed - directory not created"
            exit 1
        fi
    else
        print_error "Oh My Zsh installation script failed"
        exit 1
    fi
}

# Install Zsh plugins
install_zsh_plugins() {
    print_header "Installing Zsh Plugins"
    
    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    
    # Install zsh-autosuggestions
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        print_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
        print_success "zsh-autosuggestions installed"
    else
        print_success "zsh-autosuggestions already installed"
    fi
    
    # Install zsh-syntax-highlighting
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        print_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
        print_success "zsh-syntax-highlighting installed"
    else
        print_success "zsh-syntax-highlighting already installed"
    fi
}

# Configure Zsh
configure_zsh() {
    print_header "Configuring Zsh"
    
    local ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    local SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    
    # Backup existing .zshrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
        print_info "Backing up existing .zshrc to .zshrc.backup"
        cp "$HOME/.zshrc" "$HOME/.zshrc.backup"
    fi
    
    # Copy .zshrc configuration
    if [ -f "$SCRIPT_DIR/zsh/.zshrc" ]; then
        print_info "Installing custom .zshrc configuration..."
        cp "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
        print_success ".zshrc configured"
    else
        # If running via curl, download the config files
        print_info "Downloading .zshrc configuration..."
        if curl -fsSL "https://raw.githubusercontent.com/Herzaristide/Unix/main/zsh/.zshrc" -o "$HOME/.zshrc"; then
            if [ -s "$HOME/.zshrc" ]; then
                print_success ".zshrc downloaded and configured"
            else
                print_error "Downloaded .zshrc is empty"
                exit 1
            fi
        else
            print_error "Failed to download .zshrc"
            exit 1
        fi
    fi
    
    # Copy custom aliases
    if [ -f "$SCRIPT_DIR/zsh/custom/my_aliases.zsh" ]; then
        print_info "Installing custom aliases..."
        cp "$SCRIPT_DIR/zsh/custom/my_aliases.zsh" "$ZSH_CUSTOM/my_aliases.zsh"
        print_success "Custom aliases configured"
    else
        # If running via curl, download the aliases file
        print_info "Downloading custom aliases..."
        if curl -fsSL "https://raw.githubusercontent.com/Herzaristide/Unix/main/zsh/custom/my_aliases.zsh" -o "$ZSH_CUSTOM/my_aliases.zsh"; then
            if [ -s "$ZSH_CUSTOM/my_aliases.zsh" ]; then
                print_success "Custom aliases downloaded and configured"
            else
                print_error "Downloaded my_aliases.zsh is empty"
                exit 1
            fi
        else
            print_error "Failed to download my_aliases.zsh"
            exit 1
        fi
    fi
}

# Change default shell to Zsh
change_shell() {
    print_header "Setting Zsh as Default Shell"
    
    local current_shell=$(basename "$SHELL")
    
    if [ "$current_shell" = "zsh" ]; then
        print_success "Zsh is already your default shell"
        return 0
    fi
    
    local zsh_path=$(which zsh)
    
    # Check if zsh is in /etc/shells
    if [ -f /etc/shells ]; then
        if ! grep -q "$zsh_path" /etc/shells; then
            print_info "Adding Zsh to /etc/shells..."
            echo "$zsh_path" | sudo tee -a /etc/shells > /dev/null
        fi
    fi
    
    print_info "Changing default shell to Zsh..."
    local chsh_error
    if chsh_error=$(chsh -s "$zsh_path" 2>&1); then
        print_success "Default shell changed to Zsh"
        print_warning "Please log out and log back in for the change to take effect"
    else
        print_warning "Could not change default shell automatically"
        if [[ -n "$chsh_error" ]]; then
            print_info "Error: $chsh_error"
        fi
        print_info "You can change it manually by running: chsh -s \"$(which zsh)\""
    fi
}

# Main installation flow
main() {
    clear
    
    echo -e "${GREEN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                                                           ║"
    echo "║       Herzaristide's Zsh Setup Script                    ║"
    echo "║       Installing Zsh, Oh My Zsh, and Git                 ║"
    echo "║                                                           ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo ""
    
    # Detect operating system
    detect_os
    
    # Install components
    install_git
    install_zsh
    install_oh_my_zsh
    install_zsh_plugins
    configure_zsh
    change_shell
    
    # Final message
    print_header "Installation Complete! 🎉"
    
    echo -e "${GREEN}"
    echo "All components have been installed successfully!"
    echo ""
    echo "Next steps:"
    echo "  1. Log out and log back in (or restart your terminal)"
    echo "  2. Your new Zsh shell with Oh My Zsh will be ready to use"
    echo "  3. Edit ~/.zshrc to customize your configuration"
    echo "  4. Edit ~/.oh-my-zsh/custom/my_aliases.zsh to add custom aliases"
    echo ""
    echo "To start using Zsh right now, run: zsh"
    echo -e "${NC}"
}

# Run main function
main
