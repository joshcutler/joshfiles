#!/usr/bin/env bash

# Dotfiles Installation Script
# This script creates symlinks from the dotfiles repo to your home directory

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo -e "${BLUE}Starting dotfiles installation...${NC}"
echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}"

# Function to create a symlink
create_symlink() {
    local source=$1
    local target=$2

    # Create parent directory if it doesn't exist
    local target_dir=$(dirname "$target")
    if [ ! -d "$target_dir" ]; then
        echo -e "${YELLOW}Creating directory: $target_dir${NC}"
        mkdir -p "$target_dir"
    fi

    # If target exists and is not a symlink, back it up
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}Backing up existing file: $target${NC}"
        mkdir -p "$BACKUP_DIR"
        cp -r "$target" "$BACKUP_DIR/"
        rm -rf "$target"
    fi

    # If target is a symlink pointing to wrong location, remove it
    if [ -L "$target" ]; then
        local current_target=$(readlink "$target")
        if [ "$current_target" != "$source" ]; then
            echo -e "${YELLOW}Removing old symlink: $target${NC}"
            rm "$target"
        fi
    fi

    # Create the symlink if it doesn't exist
    if [ ! -e "$target" ]; then
        echo -e "${GREEN}Creating symlink: $target -> $source${NC}"
        ln -s "$source" "$target"
    else
        echo -e "${BLUE}Already linked: $target${NC}"
    fi
}

# Install Zsh configuration
if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
    create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
fi

if [ -f "$DOTFILES_DIR/zsh/.zshenv" ]; then
    create_symlink "$DOTFILES_DIR/zsh/.zshenv" "$HOME/.zshenv"
fi

if [ -f "$DOTFILES_DIR/zsh/.zprofile" ]; then
    create_symlink "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
fi

# Install oh-my-zsh custom configuration
if [ -d "$DOTFILES_DIR/zsh/oh-my-zsh-custom" ]; then
    if [ -d "$HOME/.oh-my-zsh" ]; then
        # Symlink custom themes, plugins, and scripts
        if [ -d "$DOTFILES_DIR/zsh/oh-my-zsh-custom/themes" ]; then
            for theme in "$DOTFILES_DIR/zsh/oh-my-zsh-custom/themes"/*.zsh-theme; do
                if [ -f "$theme" ]; then
                    create_symlink "$theme" "$HOME/.oh-my-zsh/custom/themes/$(basename "$theme")"
                fi
            done
        fi

        if [ -d "$DOTFILES_DIR/zsh/oh-my-zsh-custom/plugins" ]; then
            for plugin_dir in "$DOTFILES_DIR/zsh/oh-my-zsh-custom/plugins"/*/; do
                if [ -d "$plugin_dir" ]; then
                    create_symlink "$plugin_dir" "$HOME/.oh-my-zsh/custom/plugins/$(basename "$plugin_dir")"
                fi
            done
        fi

        # Symlink any custom .zsh files
        for zsh_file in "$DOTFILES_DIR/zsh/oh-my-zsh-custom"/*.zsh; do
            if [ -f "$zsh_file" ] && [ "$(basename "$zsh_file")" != "*.zsh" ]; then
                create_symlink "$zsh_file" "$HOME/.oh-my-zsh/custom/$(basename "$zsh_file")"
            fi
        done

        echo -e "${GREEN}Oh-my-zsh customizations linked${NC}"
    else
        echo -e "${YELLOW}Warning: Oh-my-zsh not installed. Skipping custom configurations.${NC}"
        echo -e "${YELLOW}Install with: sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\"${NC}"
    fi
fi

# Install Git configuration
if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
    create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
fi

if [ -f "$DOTFILES_DIR/git/.gitignore_global" ]; then
    create_symlink "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
fi

# Install SSH configuration
if [ -f "$DOTFILES_DIR/ssh/config" ]; then
    create_symlink "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
fi

# Install asdf configuration
if [ -f "$DOTFILES_DIR/asdf/.tool-versions" ]; then
    create_symlink "$DOTFILES_DIR/asdf/.tool-versions" "$HOME/.tool-versions"
fi

if [ -f "$DOTFILES_DIR/asdf/.asdfrc" ]; then
    create_symlink "$DOTFILES_DIR/asdf/.asdfrc" "$HOME/.asdfrc"
fi

# Install Claude configuration
if [ -d "$DOTFILES_DIR/claude" ]; then
    # Create .claude directory if it doesn't exist
    if [ ! -d "$HOME/.claude" ]; then
        mkdir -p "$HOME/.claude"
    fi

    # Symlink all files in claude directory
    for file in "$DOTFILES_DIR/claude"/*; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            create_symlink "$file" "$HOME/.claude/$filename"
        elif [ -d "$file" ]; then
            # Handle subdirectories (like commands/)
            dirname=$(basename "$file")
            if [ ! -d "$HOME/.claude/$dirname" ]; then
                mkdir -p "$HOME/.claude/$dirname"
            fi
            # Symlink all files in the subdirectory
            for subfile in "$file"/*; do
                if [ -f "$subfile" ]; then
                    subfilename=$(basename "$subfile")
                    create_symlink "$subfile" "$HOME/.claude/$dirname/$subfilename"
                fi
            done
        fi
    done
fi

echo ""
echo -e "${GREEN}Installation complete!${NC}"

if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Backups saved to: $BACKUP_DIR${NC}"
fi

echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Review and customize your dotfiles in: $DOTFILES_DIR"
echo "  2. Restart your shell or run: source ~/.zshrc"
echo "  3. Commit your changes: git add . && git commit -m 'Initial dotfiles setup'"
