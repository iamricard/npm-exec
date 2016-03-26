SOURCE_STR="\nnpm-exec() {\n\$(npm bin)/\$@\n}"

# Taken from NVM
detect_profile() {
  if [ -n "$PROFILE" -a -f "$PROFILE" ]; then
    echo "$PROFILE"
    return
  fi

  local DETECTED_PROFILE
  DETECTED_PROFILE=''
  local SHELLTYPE
  SHELLTYPE="$(basename "/$SHELL")"

  if [ "$SHELLTYPE" = "bash" ]; then
    if [ -f "$HOME/.bashrc" ]; then
      DETECTED_PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      DETECTED_PROFILE="$HOME/.bash_profile"
    fi
  elif [ "$SHELLTYPE" = "zsh" ]; then
    DETECTED_PROFILE="$HOME/.zshrc"
  fi

  if [ -z "$DETECTED_PROFILE" ]; then
    if [ -f "$HOME/.profile" ]; then
      DETECTED_PROFILE="$HOME/.profile"
    elif [ -f "$HOME/.bashrc" ]; then
      DETECTED_PROFILE="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      DETECTED_PROFILE="$HOME/.bash_profile"
    elif [ -f "$HOME/.zshrc" ]; then
      DETECTED_PROFILE="$HOME/.zshrc"
    fi
  fi

  if [ ! -z "$DETECTED_PROFILE" ]; then
    echo "$DETECTED_PROFILE"
  fi
}

NPM_EXEC_PROFILE=$(detect_profile)

if [ -z "$NPM_EXEC_PROFILE" ] ; then
  echo "=> Profile not found. Tried $NPM_EXEC_PROFILE (as defined in \$PROFILE), ~/.bashrc, ~/.bash_profile, ~/.zshrc, and ~/.profile."
  echo "=> Create one of them and run this script again"
  echo "=> Create it (touch $NPM_EXEC_PROFILE) and run this script again"
  echo "   OR"
  echo "=> Append the following lines to the correct file yourself:"
  printf "$SOURCE_STR"
  echo
else
  if ! command grep -qc 'npm-exec() {' "$NPM_EXEC_PROFILE"; then
    echo "=> Appending source string to $NPM_EXEC_PROFILE"
    printf "$SOURCE_STR\n" >> "$NPM_EXEC_PROFILE"
  else
    echo "=> Source string already in $NPM_EXEC_PROFILE"
  fi
fi
