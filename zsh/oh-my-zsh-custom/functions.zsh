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

# Extract archives of various types
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
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
