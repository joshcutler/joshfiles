# Development Environment Variables

# Editor configuration
export EDITOR='code --wait'
export VISUAL='code --wait'
export GIT_EDITOR='code --wait'

# Pager configuration
export PAGER='less'
export LESS='-R -F -X -M -i'  # Raw color, quit if one screen, no clear, long prompt, ignore case

# Language environment
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Development paths
export PROJECTS_DIR="$HOME/code"

# Python configuration
export PYTHONDONTWRITEBYTECODE=1  # Don't create .pyc files
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Ruby configuration
if command -v brew &> /dev/null; then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
fi

# Node configuration
export NODE_ENV="${NODE_ENV:-development}"
# Increase node memory limit for large projects
export NODE_OPTIONS="--max-old-space-size=4096"

# PostgreSQL
export PGDATA="$HOME/.postgres/data"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_AUTO_UPDATE=1  # Don't auto-update on every install

# History configuration for tools
export SQLITE_HISTORY="$HOME/.sqlite_history"
export PSQL_HISTORY="$HOME/.psql_history"
