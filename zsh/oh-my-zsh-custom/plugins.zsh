# Oh-My-Zsh Plugin Configuration
# Configurations for both built-in and custom plugins

# =============================================================================
# Custom Plugins (installed via Homebrew)
# =============================================================================

# zsh-autosuggestions (brew install zsh-autosuggestions)
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  # Customize appearance
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
  # Use both history and completion as sources
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  # Don't suggest for very long commands
  ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# zsh-syntax-highlighting (brew install zsh-syntax-highlighting)
# MUST be loaded after all other plugins that bind widgets
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  # Enable highlighters
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
fi

# zoxide (brew install zoxide)
# Modern replacement for z - smarter directory jumping
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  # Use 'z' command for jumping to directories
  # Use 'zi' for interactive directory selection with fzf
fi

# =============================================================================
# fzf - Fuzzy Finder
# =============================================================================

# Load fzf shell integrations (Ctrl-T, Ctrl-R, Alt-C keybindings)
# This provides the keybindings while modern-tools.zsh provides custom functions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =============================================================================
# Built-in Oh-My-Zsh Plugins
# =============================================================================

# These plugins are enabled in .zshrc via the plugins=() array:
# - command-not-found: Suggests package to install for unknown commands (macOS)
# - extract: Universal archive extractor (usage: extract <archive-file>)
# - git: Git aliases and functions
# - rails: Rails-specific helpers
# - ruby: Ruby development helpers
# - python: Python development helpers

# No additional configuration needed for built-in plugins
