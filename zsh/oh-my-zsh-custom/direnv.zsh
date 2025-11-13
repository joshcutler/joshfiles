# direnv - load environment variables per project

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"

  # Show direnv messages when loading/unloading (optional)
  # Set to "" to hide messages
  export DIRENV_LOG_FORMAT="direnv: %s"
fi
