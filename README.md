# Josh's Dotfiles

Personal dotfiles for managing configuration across multiple development machines.

## Overview

This repository contains configuration files for:
- **Zsh**: Shell configuration and aliases
- **Git**: Version control settings
- **SSH**: Client configuration
- **Claude**: Claude Code settings and custom slash commands

## Directory Structure

```
.
├── zsh/               # Zsh configuration files
│   ├── .zshrc
│   └── .zprofile
├── git/               # Git configuration
│   └── .gitconfig
├── ssh/               # SSH configuration
│   └── config
├── claude/            # Claude Code configuration
│   ├── CLAUDE.md
│   ├── settings.json
│   └── commands/      # Custom slash commands
│       ├── bug.md
│       ├── enhancement.md
│       ├── feature.md
│       └── implement.md
├── scripts/           # Custom utility scripts
├── install.sh         # Installation script
└── README.md          # This file
```

## Installation

### First Time Setup

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/code/joshfiles
   cd ~/code/joshfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

   The script will:
   - Create symlinks from this repo to your home directory
   - Backup any existing files to `~/.dotfiles_backup/`
   - Set up all configurations

3. Restart your shell or source the config:
   ```bash
   source ~/.zshrc
   ```

### On Additional Machines

Simply clone and run `./install.sh` - it will set up all symlinks automatically.

## What Gets Installed

The installation script creates these symlinks:

| Source                         | Target                              |
|--------------------------------|-------------------------------------|
| `zsh/.zshrc`                   | `~/.zshrc`                          |
| `zsh/.zprofile`                | `~/.zprofile`                       |
| `git/.gitconfig`               | `~/.gitconfig`                      |
| `ssh/config`                   | `~/.ssh/config`                     |
| `claude/CLAUDE.md`             | `~/.claude/CLAUDE.md`               |
| `claude/settings.json`         | `~/.claude/settings.json`           |
| `claude/commands/*.md`         | `~/.claude/commands/*.md`           |

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
