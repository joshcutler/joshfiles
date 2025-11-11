# Oh-My-Zsh Custom Configuration

This directory contains custom oh-my-zsh themes and plugins that will be synced across machines.

## Structure

- `themes/` - Custom Zsh themes
- `plugins/` - Custom Zsh plugins
- `*.zsh` - Custom configuration files loaded automatically

## Current Configuration

Based on your `.zshrc`:
- **Theme**: robbyrussell (built-in)
- **Plugins**: git, rails, ruby, python (all built-in)

## Adding Custom Themes

1. Create or copy a theme file:
   ```bash
   cp mytheme.zsh-theme ~/code/joshfiles/zsh/oh-my-zsh-custom/themes/
   ```

2. Update `.zshrc` to use it:
   ```bash
   ZSH_THEME="mytheme"
   ```

3. Commit and push:
   ```bash
   cd ~/code/joshfiles
   git add . && git commit -m "Add custom theme"
   ```

## Adding Custom Plugins

1. Create plugin directory and files:
   ```bash
   mkdir -p ~/code/joshfiles/zsh/oh-my-zsh-custom/plugins/myplugin
   echo "# Custom plugin code" > ~/code/joshfiles/zsh/oh-my-zsh-custom/plugins/myplugin/myplugin.plugin.zsh
   ```

2. Update `.zshrc` to enable it:
   ```bash
   plugins=(git rails ruby python myplugin)
   ```

3. Commit and push changes

## Custom Configuration Files

Any `.zsh` files in this directory are automatically loaded by oh-my-zsh. Use these for:
- Custom aliases
- Environment variables
- Functions
- Shortcuts to projects

Example: Create `shortcuts.zsh`:
```bash
# Project shortcuts
icarian=~/code/icarian
joshfiles=~/code/joshfiles
```

## Installation

The install script will symlink this entire directory to `~/.oh-my-zsh/custom/`, making all customizations available.

## Note

Oh-my-zsh itself must be installed separately on each machine. This repo only syncs your customizations.

Install oh-my-zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
