#!/usr/bin/env bash

# Bootstrap script for setting up a new machine
# Installs Homebrew, packages, and dotfiles

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}Dotfiles Bootstrap Script${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo -e "${BLUE}Adding Homebrew to PATH for Apple Silicon...${NC}"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo -e "${GREEN}Homebrew installed successfully!${NC}"
else
    echo -e "${GREEN}Homebrew is already installed.${NC}"
fi

# Update Homebrew
echo -e "${BLUE}Updating Homebrew...${NC}"
brew update

# Install packages from Brewfile
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo -e "${BLUE}Installing packages from Brewfile...${NC}"
    cd "$DOTFILES_DIR"
    brew bundle --verbose
    echo -e "${GREEN}Packages installed successfully!${NC}"
else
    echo -e "${YELLOW}Warning: Brewfile not found, skipping package installation.${NC}"
fi

# Install Oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${BLUE}Installing Oh-my-zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}Oh-my-zsh installed successfully!${NC}"
else
    echo -e "${GREEN}Oh-my-zsh is already installed.${NC}"
fi

# Install asdf plugins for tools in .tool-versions
if command -v asdf &> /dev/null && [ -f "$DOTFILES_DIR/asdf/.tool-versions" ]; then
    echo -e "${BLUE}Installing asdf plugins...${NC}"
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue

        # Extract plugin name (first word)
        plugin=$(echo "$line" | awk '{print $1}')

        # Check if plugin is already added
        if ! asdf plugin list | grep -q "^${plugin}$"; then
            echo -e "${YELLOW}Adding asdf plugin: $plugin${NC}"
            asdf plugin add "$plugin" || echo -e "${RED}Failed to add plugin: $plugin${NC}"
        else
            echo -e "${GREEN}asdf plugin already installed: $plugin${NC}"
        fi
    done < "$DOTFILES_DIR/asdf/.tool-versions"

    echo -e "${GREEN}asdf plugins installed!${NC}"
fi

# Run the main dotfiles installation script
echo ""
echo -e "${BLUE}Running dotfiles installation...${NC}"
"$DOTFILES_DIR/install.sh"

echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}Bootstrap complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Configure iTerm2 to use Nerd Font for icons:"
echo "     - Open iTerm2 Preferences (⌘,)"
echo "     - Go to Profiles → Text → Font"
echo "     - Select 'Hack Nerd Font Mono' (size 12-14pt)"
echo "     - Restart iTerm2 to see icons in eza/ls output"
echo ""
echo "  2. Restart your terminal to apply changes"
echo "  3. Install language versions with asdf:"
echo "     cd ~/code/joshfiles && asdf install"
echo "  4. Review and customize your dotfiles"
