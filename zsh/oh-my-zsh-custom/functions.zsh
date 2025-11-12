# Make directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Go up N directories (e.g., up 3)
up() {
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

# Find files by name
ff() {
  find . -type f -iname "*$1*"
}

# Find directories by name (renamed from fd to avoid conflict with modern fd tool)
fdir() {
  find . -type d -iname "*$1*"
}

# Create backup of file with timestamp
backup() {
  cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)"
}
