# File listing aliases
alias ll='ls -lh'                # Long format, human-readable sizes
alias la='ls -lAh'               # Include hidden files
alias l='ls -CF'                 # Compact format
alias lt='ls -ltrh'              # Sort by time, newest last

# Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'                # Go to previous directory

# Safe defaults
alias rm='rm -i'                 # Confirm before removing
alias cp='cp -i'                 # Confirm before overwriting
alias mv='mv -i'                 # Confirm before overwriting
alias ln='ln -i'                 # Confirm before creating link

# Quick edits for dotfiles
alias zshconfig='code ~/.zshrc'
alias zshreload='source ~/.zshrc'
alias dotfiles='cd ~/code/joshfiles'

# Utility aliases
alias h='history'
alias path='echo $PATH | tr ":" "\n"'  # Display PATH one entry per line
alias ports='netstat -tulanp'          # Show open ports
