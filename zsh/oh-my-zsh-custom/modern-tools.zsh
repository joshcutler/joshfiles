# Modern CLI tool aliases and configurations

# bat - better cat
if command -v bat &> /dev/null; then
  alias cat='bat --paging=never'
  alias catp='bat'  # bat with pager
  export BAT_THEME="TwoDark"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# eza - better ls
if command -v eza &> /dev/null; then
  # Solarized-inspired color scheme (more subdued, readable on dark backgrounds)
  export EZA_COLORS="reset:di=1;34:ln=1;36:so=35:pi=33:ex=32:bd=33:cd=33:su=31:sg=31:tw=1;34:ow=1;34"

  alias ls='eza --icons --color=auto'
  alias ll='eza -l --icons --git --color=auto'
  alias la='eza -la --icons --git --color=auto'
  alias lt='eza -l --icons --git --sort=modified --color=auto'
  alias tree='eza --tree --icons --color=auto'
fi

# fd - better find
# Note: fd and find have different syntax, so we don't alias find->fd
# Use 'fd' directly for the modern find experience

# ripgrep - better grep
if command -v rg &> /dev/null; then
  alias grep='rg'
fi

# fzf - fuzzy finder
if command -v fzf &> /dev/null; then
  # Setup fzf
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

  # Use fd with fzf for better file finding
  if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  # fzf with bat preview
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range=:500 {}'"

  # Custom fzf functions
  # Search and edit file
  fe() {
    local file
    file=$(fzf --preview 'bat --color=always {}') && ${EDITOR:-vim} "$file"
  }

  # Search and cd to directory
  fcd() {
    local dir
    dir=$(fd --type d | fzf) && cd "$dir"
  }

  # Search git history
  fgh() {
    git log --oneline --color=always | fzf --ansi --preview 'git show --color=always {1}' | awk '{print $1}' | xargs git show
  }
fi

# tldr - simplified man pages
if command -v tldr &> /dev/null; then
  alias help='tldr'
  # Note: Colors configured in ~/.config/tldr/config for dark backgrounds
fi
