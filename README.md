# Josh's Dotfiles

Personal dotfiles for managing configuration across multiple development machines.

## Overview

This repository contains configuration files for:
- **Zsh**: Shell configuration and aliases (with oh-my-zsh support)
- **Git**: Version control settings
- **SSH**: Client configuration
- **asdf**: Version manager configuration
- **Claude**: Claude Code settings and custom slash commands

## Directory Structure

```
.
├── zsh/                    # Zsh configuration files
│   ├── .zshrc
│   ├── .zprofile
│   └── oh-my-zsh-custom/   # Oh-my-zsh customizations
│       ├── themes/         # Custom themes
│       ├── plugins/        # Custom plugins
│       └── README.md
├── git/                    # Git configuration
│   └── .gitconfig
├── ssh/                    # SSH configuration
│   └── config
├── asdf/                   # asdf version manager
│   ├── .tool-versions      # Global tool versions
│   └── .asdfrc             # asdf configuration
├── Brewfile                # Homebrew packages (like Gemfile for system tools)
├── bootstrap.sh            # First-run setup script
├── claude/                 # Claude Code configuration
│   ├── CLAUDE.md
│   ├── settings.json
│   └── commands/           # Custom slash commands
│       ├── bug.md
│       ├── enhancement.md
│       ├── feature.md
│       └── implement.md
├── scripts/                # Custom utility scripts
├── install.sh              # Installation script
└── README.md               # This file
```

## Installation

### Quick Start (Recommended for New Machines)

The **bootstrap script** handles everything - Homebrew, packages, oh-my-zsh, asdf plugins, and dotfiles:

```bash
# Clone this repository
git clone <your-repo-url> ~/code/joshfiles
cd ~/code/joshfiles

# Run the bootstrap script
./bootstrap.sh
```

This will:
1. Install Homebrew (if not present)
2. Install all packages from `Brewfile` (CLI tools, apps, VSCode extensions)
3. Install oh-my-zsh (if not present)
4. Install asdf plugins (ruby, etc.)
5. Symlink all dotfiles to your home directory
6. Backup any existing files

Then restart your terminal and install language runtimes:
```bash
asdf install  # Installs ruby 3.1.6 and other versions from .tool-versions
```

### Configure Terminal Font for Icons

The modern CLI tools (eza) use icons that require a Nerd Font. After installation:

**For iTerm2:**
1. Open iTerm2 Preferences (⌘,)
2. Go to **Profiles** → **Text**
3. Click the **Font** dropdown
4. Search for "Hack Nerd Font Mono" and select it
5. Recommended size: 12-14pt
6. Restart iTerm2 or open a new window

**For Terminal.app:**
1. Open Terminal Preferences (⌘,)
2. Go to **Profiles** → **Font**
3. Click "Change..." button
4. Search for "Hack Nerd Font Mono" and select it
5. Recommended size: 12-14pt
6. Set as default profile if desired

### Manual Installation (Dotfiles Only)

If you already have Homebrew and other tools installed:

```bash
git clone <your-repo-url> ~/code/joshfiles
cd ~/code/joshfiles
./install.sh  # Just symlinks dotfiles, doesn't install packages
```

### Updating Existing Machines

```bash
cd ~/code/joshfiles
git pull                  # Get latest dotfiles
brew bundle               # Install any new packages from Brewfile
```

Changes to dotfiles take effect immediately (symlinks).

## What Gets Installed

The installation script creates these symlinks:

| Source                                | Target                                     |
|---------------------------------------|---------------------------------------------|
| `zsh/.zshrc`                          | `~/.zshrc`                                  |
| `zsh/.zprofile`                       | `~/.zprofile`                               |
| `zsh/oh-my-zsh-custom/themes/*`       | `~/.oh-my-zsh/custom/themes/*`              |
| `zsh/oh-my-zsh-custom/plugins/*`      | `~/.oh-my-zsh/custom/plugins/*`             |
| `zsh/oh-my-zsh-custom/*.zsh`          | `~/.oh-my-zsh/custom/*.zsh`                 |
| `git/.gitconfig`                      | `~/.gitconfig`                              |
| `ssh/config`                          | `~/.ssh/config`                             |
| `asdf/.tool-versions`                 | `~/.tool-versions`                          |
| `asdf/.asdfrc`                        | `~/.asdfrc`                                 |
| `claude/CLAUDE.md`                    | `~/.claude/CLAUDE.md`                       |
| `claude/settings.json`                | `~/.claude/settings.json`                   |
| `claude/commands/*.md`                | `~/.claude/commands/*.md`                   |

### Oh-my-zsh Configuration

Current setup (from `.zshrc`):
- **Theme**: robbyrussell
- **Plugins**: git, rails, ruby, python

Custom themes, plugins, and scripts can be added to `zsh/oh-my-zsh-custom/`. See the [oh-my-zsh customization guide](zsh/oh-my-zsh-custom/README.md).

### Homebrew Package Management

The `Brewfile` works like a `Gemfile` for system packages. Current setup includes:
- **CLI tools**: asdf, gh, jq, httpie, awscli, flyctl, etc.
- **Services**: postgresql@14, redis
- **Apps**: claude-code
- **VSCode extensions**: Copilot, Python, Docker, Rails, etc.

**Adding new packages:**
```bash
brew install <package>          # Install a package
cd ~/code/joshfiles
brew bundle dump --force        # Update Brewfile with currently installed packages
git add Brewfile && git commit -m "Add <package>"
```

**Installing on other machines:**
```bash
brew bundle                     # Install all packages from Brewfile
```

### asdf Configuration

Current setup:
- **Global tool versions**: ruby 3.1.6
- **Config**: `legacy_version_file = yes` (enables reading .ruby-version, .node-version, etc.)

Add more tools to `.tool-versions` as needed:
```
ruby 3.1.6
nodejs 20.0.0
python 3.11.0
```

After updating, run:
```bash
asdf plugin add nodejs    # Add plugin if not present
asdf install              # Install all versions from .tool-versions
```

### Claude Slash Commands

The following custom commands are included:
- `/bug` - Report and fix bugs
- `/enhancement` - Improve existing features
- `/feature` - Implement new features
- `/implement` - Implement specific functionality

## Making Changes

Since files are symlinked, you can edit them in either location:
- Edit in the repo: `~/code/joshfiles/zsh/.zshrc`
- Or edit the symlink: `~/.zshrc`

Changes are reflected immediately. Remember to commit and push:

```bash
cd ~/code/joshfiles
git add .
git commit -m "Update configuration"
git push
```

## Machine-Specific Configuration

For machine-specific settings that shouldn't be synced:

- **Zsh**: Create `~/.zshrc.local` - it will be sourced automatically
- **Git**: Use `git config --local` in specific repositories
- **SSH**: Add machine-specific entries to `~/.ssh/config_local` and include it

## Security Notes

The `.gitignore` is configured to prevent committing:
- Private SSH keys
- Sensitive credentials
- Local-only configuration files
- Backup files

**Important**: Always review files before committing to ensure no secrets are included.

## Maintenance

### Updating on a Machine

```bash
cd ~/code/joshfiles
git pull
```

Changes take effect immediately due to symlinks.

### Adding New Dotfiles

1. Copy the file to the appropriate directory:
   ```bash
   cp ~/.newconfig ~/code/joshfiles/misc/.newconfig
   ```

2. Update `install.sh` to create the symlink

3. Commit and push:
   ```bash
   git add .
   git commit -m "Add new configuration"
   git push
   ```

### Reinstalling

If symlinks get broken or you need to reset:

```bash
cd ~/code/joshfiles
./install.sh
```

The script is idempotent - safe to run multiple times.

## Backup

Existing files are automatically backed up to:
```
~/.dotfiles_backup/YYYYMMDD_HHMMSS/
```

## Troubleshooting

**Symlinks not working?**
- Check file permissions: `ls -la ~/.zshrc`
- Verify symlink target: `readlink ~/.zshrc`
- Reinstall: `./install.sh`

**Changes not taking effect?**
- Restart your shell or source the config: `source ~/.zshrc`

**Merge conflicts?**
- Your local changes in the repo take precedence
- Resolve conflicts manually and commit

## License

Personal configuration files - use at your own risk!
